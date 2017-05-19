local Map = {}

local map_width = 25
local map_height = 19

for x = 1, map_width do
	Map[x] = {}
	for y = 1, map_height do
		Map[x][y] = love.math.random(0, 1)
	end
end

return Map
