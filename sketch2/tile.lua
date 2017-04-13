local Tile = {}

function Tile.new(up, down, left, right)
	assert(type(up) == "boolean")
	assert(type(down) == "boolean")
	assert(type(left) == "boolean")
	assert(type(right) == "boolean")
	
	local tile = {
		up = up,
		down = down,
		left = left,
		right = right
	}
	
	return tile
end
Tile.new = Memoize(Tile.new)

return Tile
