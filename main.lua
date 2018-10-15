local cinereo = require 'cinereo'
local tilemap, player = cinereo.tilemap, cinereo.player
local key = love.keyboard.isDown

function love.load()
	map = tilemap:new(10, 20, 32)
	map[5][10].solid = true
	map[6][10].solid = true
	map[6][12].solid = true
	map[5][11].solid = true
	map[4][10].solid = true
	p1 = player:new(0, 0, 32, 32, 200)
	
end

function love.update(dt)
	p1:setWorld(map, dt)
	if key('up') 	then p1:moveUp() 	end
	if key('down') 	then p1:moveDown()  end
	if key('left') 	then p1:moveLeft()  end
	if key('right') then p1:moveRight() end
	
end

function love.draw()
	map:draw()
	p1:draw()
end