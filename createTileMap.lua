return function (lines, columns, tileSize)
	local tileMap = {}
	local xTile, yTile = 0, 0
  
	for i=1, lines do
		tileMap[i] = {}
		for j=1, columns do
			tileMap[i][j] = {x=xTile, y=yTile, size=tileSize, is_solid=false}
			xTile = xTile + tileSize
		end
		xTile = 0
		yTile = yTile + tileSize
	end
  
	tileMap.lines = lines
	tileMap.columns = columns
	tileMap.tileSize = tileSize
	return tileMap
end