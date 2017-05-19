local DirectionComponent = Class('DirectionComponent')

local dirs, mt = {}, {}
for i, dir in ipairs({
	{ num = -1, str =  "LEFT" },
	{ num =  0, str =    "UP" },
	{ num =  1, str = "RIGHT" },
	{ num =  2, str =  "DOWN" }
}) do 
	dir = setmetatable(dir, mt)
	dirs[dir.num] = dir 
	dirs[dir.str] = dir
end

mt.__tostring = function(self) return self.str end
mt.__add = function(self, other) 
	local x = self.num + other.num
	return dirs[(x + 1) % 4 - 1]
end
mt.__eq = function(self, other)
	return self.str == other
end

local function isDirection(direction)
	if (type(direction) == "number") then return false end
	if (type(direction) == "integer") then return false end
	
	for name, _ in pairs(dirs) do
		if direction == name then return true end
	end
	
	return false
end


DirectionComponent.static.directions = dirs
DirectionComponent.isDirection = isDirection


function DirectionComponent.initialize(self, direction)
	assert(isDirection(direction), tostring(direction) .. " is not a valid direction!")
	self.dir = direction
end


function DirectionComponent.turn(self, direction)
	assert(isDirection(direction))
	self.dir = self.dir + direction
end
function DirectionComponent.turnLeft(self)
	self.dir = self.dir + dirs.LEFT
end
function DirectionComponent.turnRight(self)
	self.dir = combine(self.dir, dirs.RIGHT)
end
function DirectionComponent.turnBack(self)
	self.dir = combine(self.dir, dirs.BACK)
end


return DirectionComponent
