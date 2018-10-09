local createTileMap = require 'createTileMap'
local drawTileMap = require 'drawTileMap'
local floor, key = math.floor, love.keyboard.isDown

--[[ Próxima tentativa:

1. Detectar quando o jogador apertar alguma tecla para se mover
2. Calcular se quando o jogador se mover, entrará em colisão com algo
	2.1 Se sim, ajuste a colisão no eixo indicado e desative a movimentação. Apenas ative-a se o objeto sólido não estiver
		imediatamente no seu caminho quando andar;
	2.2 Se não,  ande normalmente

]]--

function love.load()    
	player = {x=32*7, y=32*6, w=32, h=32, speed=200}
	
	moveTop = true
	moveBot = true
	moveLef = true
	moveRig = true
	
	map = createTileMap(10, 20, 32)
	map[5][10].is_solid = true
	map[6][10].is_solid = true
	map[6][12].is_solid = true
	map[5][11].is_solid = true
	map[4][10].is_solid = true
end

function love.update(dt)--[[
	topLeftRow 		  = floor(player.y/map.tileSize) +1
	topLeftColumn 	  = floor(player.x/map.tileSize) +1
	topRightRow 	  = floor(player.y/map.tileSize) +1
	topRightColumn 	  = floor((player.x+player.w-1)/map.tileSize) +1
	bottomLeftRow 	  = floor((player.y+player.h-1)/map.tileSize) +1
	bottomLeftColumn  = floor(player.x/map.tileSize) +1
	bottomRightRow	  = floor((player.y+player.h-1)/map.tileSize) +1
	bottomRightColumn = floor((player.x+player.w-1)/map.tileSize) +1]]--
	
	if key('up') then
		nextPosition = player.y - (player.speed*dt)
		topLeftColumn = floor(player.x/map.tileSize) +1
		topRightColumn = floor((player.x+player.w-1)/map.tileSize) +1
		row = floor(nextPosition/map.tileSize) +1
		if map[row][topLeftColumn].is_solid or map[row][topRightColumn].is_solid then
			player.y = (row * map.tileSize)
			moveTop = false
		else
			moveTop = true
			player.y = nextPosition
		end
	end
	
	if key('down') then
		nextPosition = player.y + (player.speed*dt)
		bottomLeftColumn = floor(player.x/map.tileSize) +1
		bottomRightColumn = floor((player.x+player.w-1)/map.tileSize) +1
		row = floor((nextPosition+player.h-1)/map.tileSize) +1
		if map[row][bottomLeftColumn].is_solid or map[row][bottomRightColumn].is_solid then
			player.y = ((row-1) * map.tileSize) - player.h
			moveBot = false
		else
			moveBot = true
			player.y = nextPosition
		end
	end
	
	if key('left') then
		nextPosition = player.x - (player.speed*dt)
		topLeftRow = floor(player.y/map.tileSize) +1
		bottomLeftRow = floor((player.y+player.h-1)/map.tileSize) +1
		col = floor(nextPosition/map.tileSize) +1
		if map[topLeftRow][col].is_solid or map[bottomLeftRow][col].is_solid then
			player.x = ((col-1) * map.tileSize) + map.tileSize
			moveLef = false
		else
			moveLef = true
			player.x = nextPosition
		end
	end
	if key('right') then
		nextPosition = player.x + (player.speed*dt)
		topRightRow = floor(player.y/map.tileSize) +1
		bottomRightRow = floor((player.y+player.h-1)/map.tileSize) +1
		col = floor((nextPosition+player.w-1)/map.tileSize) +1
		if map[topRightRow][col].is_solid or map[bottomRightRow][col].is_solid then
			player.x = ((col-1) * map.tileSize) - player.w
			moveRig = false
		else
			moveRig = true
			player.x = nextPosition
		end
	end
end

function love.draw()
	drawTileMap(map)
	
	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
	love.graphics.print(tostring(tcol))
end