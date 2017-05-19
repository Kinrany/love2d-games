local Map = {}

local map_width = 25
local map_height = 19

-- random map
for x = 1, map_width do
	Map[x] = {}
	for y = 1, map_height do
		Map[x][y] = love.math.random(0, 1)
	end
end

Map.turfCodes = {
	[0] = require "entities/Grass",
	[1] = require "entities/Stone"
}

return Map
