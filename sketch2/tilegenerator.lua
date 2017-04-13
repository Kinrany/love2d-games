local Tile = require('tile')


local TileGenerator = {}

TileGenerator.seed = os.time()
local function get_random_bool(...)
	local seeds = {TileGenerator.seed, ...}
	local seed = Moses.reduce(seeds, function(state, v) 
		return ((state + v) * 25964951 + 13466917) % 2147483647 
	end)
	
	math.randomseed(seed)
	--math.random()
	return math.random(2) == 2
end

local function get_right_edge(grid_pos)
	return get_random_bool(grid_pos.x, grid_pos.y, 0)
end
local function get_up_edge(grid_pos)
	return get_random_bool(grid_pos.x, grid_pos.y, 1)
end

function TileGenerator.get_edge(grid_pos, side)
	if side == "up" then
		return get_up_edge(grid_pos)
	elseif side == "down" then
		return get_up_edge(grid_pos + Vector2(0, 1))
	elseif side == "left" then
		return get_right_edge(grid_pos + Vector2(-1, 0))
	elseif side == "right" then
		return get_right_edge(grid_pos)
	else 
		error("Parameter side accepts only \"up\" and \"right\" strings.")
	end
end

function TileGenerator.get_tile(grid_pos)
	local up    = TileGenerator.get_edge(grid_pos, "up")
	local down  = TileGenerator.get_edge(grid_pos, "down")
	local left  = TileGenerator.get_edge(grid_pos, "left")
	local right = TileGenerator.get_edge(grid_pos, "right")
	return Tile.new(up, down, left, right)
end

return TileGenerator
