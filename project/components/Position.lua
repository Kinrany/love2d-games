local Direction = require "classes/Direction"


local PositionComponent = Class('PositionComponent')

function PositionComponent.initialize(self, x, y)
	self.x = assert(x)
	self.y = assert(y)
end

-- move position in given absolute direction
function PositionComponent.move(self, direction)
	if direction == Direction.RIGHT then
		self.x = self.x + 1
	elseif direction == Direction.LEFT then
		self.x = self.x - 1
	elseif direction == Direction.FRONT then
		self.y = self.y - 1
	elseif direction == Direction.BACK then
		self.y = self.y + 1
	else
		error("Unknown direction: " .. tostring(direction))
	end
end

return PositionComponent
