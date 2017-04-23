local Entity = Class('Entity')
Entity.static.list = {} --setmetatable({}, {__mode = "v"})

function Entity.initialize(self, x, y)
	self.x = assert(x)
	self.y = assert(y)
	table.insert(Entity.list, self)
end

function Entity.destroy(self)
	table.remove(Entity.list, self)
end

function Entity.coords(self)
	return x, y
end

function Entity.load(self) end
function Entity.update(self, dt) end
function Entity.draw(self) end

return Entity
