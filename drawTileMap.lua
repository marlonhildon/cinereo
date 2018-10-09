--[[ Original
return function (tileMap)
  local  rect = love.graphics.rectangle
  for i=1, tileMap.lines do
    for j=1, tileMap.columns do
      rect('line', tileMap[i][j].x, tileMap[i][j].y, tileMap[i][j].size, tileMap[i][j].size)
    end
  end
end
]]--

return function (tileMap)
	local  rect = love.graphics.rectangle
	for i=1, tileMap.lines do
		for j=1, tileMap.columns do
			if tileMap[i][j].is_solid then
				love.graphics.setColor(255, 0, 0)
				rect('fill', tileMap[i][j].x, tileMap[i][j].y, tileMap[i][j].size, tileMap[i][j].size)
			else
				love.graphics.setColor(0, 0, 255)
				rect('line', tileMap[i][j].x, tileMap[i][j].y, tileMap[i][j].size, tileMap[i][j].size)
			end
		end
	end
end