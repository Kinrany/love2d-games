local Bumper = Class('Bumper')

local _private = setmetatable({}, {__mode="k"})

function Bumper.initialize(self, box, world, filter)
	_private[self] = {
		box = assert(box),
		world = world,
		filter = filter
	}

	if world then 
		world:add(self, _private[self].box:unpack())
	end
end

function Bumper.set_world(self, new_world)
	local old_world = _private[self].world
	if old_world then
		old_world:remove(self)
	end
	
	if new_world then
		new_world:add(self, _private[self].box:unpack())
	end
	
	_private[self].world = new_world
end

function Bumper.set_filter(self, filter)
	_private[self].filter = filter
end

function Bumper.move(self, x, y, filter)
	filter = filter or _private[self].filter
	local world = _private[self].world
	if world then
		x, y, cols, len = world:move(self, x, y, filter)
	end
	_private[self].box:update(x, y)
end

return Bumper
