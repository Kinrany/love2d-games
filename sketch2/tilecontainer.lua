local TileGenerator = require('tilegenerator')
local TileDrawer = require('tiledrawer')


local __index = {}

local tiles = {}
local tile_count = 0

function __index.get(x, y)
	return tiles[x] and tiles[x][y]
end

function __index.count()
	return tile_count
end

function __index.add(x, y)
	if tiles[x] == nil then
		tiles[x] = {}
	end
	
	if tiles[x][y] == nil then
		tiles[x][y] = TileGenerator.get_tile(Vector2(x, y))
		tile_count = tile_count + 1
	else
		error("Tile "..x..", "..y.." is already present.")
	end
end

function __index.draw()
	for x, tiles_x in pairs(tiles) do
		for y, tile in pairs(tiles_x) do
			TileDrawer.draw(tile, Vector2(x, y))
		end
	end
end

function __index.reset_all()
	tiles = {}
	tile_count = 0
end

return setmetatable({}, {__index=__index, __newindex=function() error("No. Use functions instead.") end})
