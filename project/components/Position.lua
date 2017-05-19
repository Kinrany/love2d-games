local PositionComponent = Class('PositionComponent')

function PositionComponent.initialize(self, x, y)
	self.x = assert(x)
	self.y = assert(y)
end

return PositionComponent
