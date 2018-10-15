local rect 		= love.graphics.rectangle
local setColor  = love.graphics.setColor
local floor 	= math.floor

-- Tilemap class
local Tilemap = {}

function Tilemap:new(rows, columns, tileSize)
	local xTile, yTile = 0, 0
	local object = {
		rows 	 = rows,
		columns  = columns,
		tileSize = tileSize
	}
	for i=1, rows do
		object[i] = {}			-- Creates new rows
		for j=1, columns do
			object[i][j] = {	-- Creates new columns
				x 		= xTile, 
				y 		= yTile, 
				solid 	= false, 
				tag 	= 0
			}
			xTile = xTile + tileSize
		end
		xTile = 0
		yTile = yTile + tileSize
	end
	setmetatable(object, {__index = Tilemap})
	return object
end

-- Tilemap methods
function Tilemap:draw()
	local rows, columns, tileSize = self.rows, self.columns, self.tileSize
	for i=1, rows do
		for j=1, columns do
			if self[i][j].solid then
				setColor(255, 0, 0, 128)
				rect('fill', self[i][j].x, self[i][j].y, tileSize, tileSize)
			else
				setColor(0, 71, 171)
				rect('line', self[i][j].x, self[i][j].y, tileSize, tileSize)
			end
		end
	end
end

--################################################################################################
--################################################################################################

-- Player class
local Player = {}

function Player:new(x, y, w, h, speed)
	local object = {
		x = x,
		y = y,
		width = w,
		height = h,
		speed = speed,
		tilemap = {},
		dt = 0
	}
	setmetatable(object, {__index = Player})
	return object
end

-- Player methods
function Player:setWorld(playerTilemap, dt)
	self.tilemap, self.dt = playerTilemap, dt
end

function Player:draw()
	rect('fill', self.x, self.y, self.width, self.height)
end

function Player:moveUp()
	local nextPosition 	 = floor(self.y - (self.speed*self.dt))							--Predicts player's next frame position
	local topLeftColumn  = floor(self.x/self.tilemap.tileSize) +1					--Player's top-left corner column at tilemap
	local topRightColumn = floor((self.x+self.width-1)/self.tilemap.tileSize) +1	--Player's top-right corner column at tilemap
	local row 			 = floor(nextPosition/self.tilemap.tileSize) +1				--Predicts player's next row position at tilemap
	if self.tilemap[row][topLeftColumn].solid or self.tilemap[row][topRightColumn].solid then	--Solid object ahead?
		self.y = (row * self.tilemap.tileSize)	--Yes, solve the collision!
	else
		self.y = nextPosition					--No solid objects ahead, move!
	end
end

function Player:moveDown()
	nextPosition 	  = floor(self.y + (self.speed*self.dt))
	bottomLeftColumn  = floor(self.x / self.tilemap.tileSize) +1
	bottomRightColumn = floor((self.x + self.width-1) / self.tilemap.tileSize) +1
	row 			  = floor((nextPosition + self.height-1) / self.tilemap.tileSize) +1
	if self.tilemap[row][bottomLeftColumn].solid or self.tilemap[row][bottomRightColumn].solid then
		self.y = ((row-1) * self.tilemap.tileSize) - self.height
	else
		self.y = nextPosition
	end
end

function Player:moveLeft()
	nextPosition  = floor(self.x - (self.speed*self.dt))
	topLeftRow 	  = floor(self.y / self.tilemap.tileSize) +1
	bottomLeftRow = floor((self.y + self.height-1) / self.tilemap.tileSize) +1
	column 		  = floor(nextPosition / self.tilemap.tileSize) +1
	if self.tilemap[topLeftRow][column].solid or self.tilemap[bottomLeftRow][column].solid then
		self.x = ((column-1) * self.tilemap.tileSize) + self.tilemap.tileSize
	else
		self.x = nextPosition
	end
end

function Player:moveRight()
	nextPosition   = floor(self.x + (self.speed*self.dt))
	topRightRow    = floor(self.y / self.tilemap.tileSize) +1
	bottomRightRow = floor((self.y + self.height-1) / self.tilemap.tileSize) +1
	column 		   = floor((nextPosition + self.width-1) / self.tilemap.tileSize) +1
	if self.tilemap[topRightRow][column].solid or self.tilemap[bottomRightRow][column].solid then
		self.x = ((column-1) * self.tilemap.tileSize) - self.width
	else
		self.x = nextPosition
	end
end

--################################################################################################
--################################################################################################

return {tilemap=Tilemap, player=Player}