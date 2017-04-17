local Tile = require('tile')


local TileGenerator = {}

-- this can be replaced with a custom seed
-- if you want to always have the same map
TileGenerator.seed = os.time()

-- randomly generates true or false
-- uses TileGenerator.seed and all arguments as a seed
local function get_random_bool(...)
	-- put all seeds into a table
	local seeds = {TileGenerator.seed, ...}
	
	-- replace all seeds with a single int
	local seed = __(seeds):reduce(0, function(memo, v) 
		-- this is an equivalent of
		-- memo = foo(memo, v)
		-- where v is one of the seeds
		return ((memo + v) * 25964951 + 13466917) % 2147483647 
	end)
	
	-- use the seed to generate a number 0 or 1
	-- then return true if the number is 1
	math.randomseed(seed)
	return math.random(0, 1) == 1
end

-- generate the state of an edge that is on the right
-- side of the tile with coordinates (grid_pos.x, grid_pos.y)
local function get_right_edge(grid_pos)
	return get_random_bool(grid_pos.x, grid_pos.y, 0)
end
-- same, but for the state of an edge that is above the tile
local function get_up_edge(grid_pos)
	return get_random_bool(grid_pos.x, grid_pos.y, 1)
end

-- public method for generating an edge.
-- grid_pos is a vector with tile coordinates,
-- side is a string that says which edge 
-- of that tile to generate.
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

-- public method for generating a tile.
-- tiles have a boolean variable for each of their edges.
function TileGenerator.get_tile(grid_pos)
	local up    = TileGenerator.get_edge(grid_pos, "up")
	local down  = TileGenerator.get_edge(grid_pos, "down")
	local left  = TileGenerator.get_edge(grid_pos, "left")
	local right = TileGenerator.get_edge(grid_pos, "right")
	return Tile.new(up, down, left, right)
end

return TileGenerator
