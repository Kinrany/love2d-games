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

add_direction = function(num, str)
	local direction = {
		_num = num,
		_str = str
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

add_direction(-1, "left")
add_direction(0, "front")
add_direction(1, "right")
add_direction(2, "back")

local Direction = setmetatable({}, {
	__index = function(self, key)
		assert(type(key) == "string")
		return directions[string.lower(key)]
	end
})

return Direction
