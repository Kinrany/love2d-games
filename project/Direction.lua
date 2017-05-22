local get_direction, add_direction;

local directions = {}

local mt = {
	__tostring = function(self)
		return self._str
	end,
	
	__add = function(left, right)
		if type(right) ~= "table" then
			right = get_direction(right)
		end
		
		return get_direction(left._num + right._num)
	end
}

add_direction = function(num, str, dx, dy)
	local direction = {
		_num = num,
		_str = str,
		dx = dx,
		dy = dy
	}
	direction = setmetatable(direction, mt)
	
	directions[num] = direction
	directions[str] = direction
end

get_direction = function(dir)
	if type(dir) == "number" or type(dir) == "integer" then
		dir = (dir+1)%4-1
	end
	return directions[dir]
end

add_direction(-1,  "left", -1,  0)
add_direction( 0, "front",  0, -1)
add_direction( 1, "right",  1,  0)
add_direction( 2,  "back",  0,  1)

local Direction = setmetatable({}, {
	__index = function(self, key)
		assert(type(key) == "string")
		return directions[string.lower(key)]
	end
})

Direction.default = directions.front

function Direction.iter()
	local i = -1 - 1
	return function()
		i = i + 1
		return directions[i]
	end
end

return Direction
