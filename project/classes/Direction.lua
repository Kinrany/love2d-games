local Direction = Class('Direction')

local _str = setmetatable({}, {__mode = "k"})
local _num = setmetatable({}, {__mode = "k"})

local initialized = false
function Direction.initialize(self, str, num)
	if initialized then
		error("Use singletons, e.g. Direction.RIGHT, or Direction.to()")
	end
	
	_str[self] = str
	_num[self] = num
end

function Direction.__newindex(self, key, value)
	error("Direction is immutable.")
end


local left = Direction("LEFT", -1)
local front = Direction("FRONT", 0)
local right = Direction("RIGHT", 1)
local back = Direction("BACK", 2)

local directions = {
	LEFT = left,
	FRONT = front,
	RIGHT = right,
	BACK = back,
	[-1] = left,
	[0] = front,
	[1] = right,
	[2] = back
}

local function to(x)
	if type(x) == "table" and x.class == Direction then
		return x
	else
		return directions[x] or error(tostring(x) .. " is not a valid direction")
	end
end


Direction.static.LEFT = left
Direction.static.FRONT = front
Direction.static.RIGHT = right
Direction.static.BACK = back
Direction.static.to = to


function Direction.__tostring(self)
	return _str[self]
end

local function add(num1, num2)
	local num = num1 + num2
	return (num + 1) % 4 - 1
end
function Direction.__add(l, r)
	return to(add(_num[to(l)], _num[to(r)]))
end

initialized = true
return Direction
