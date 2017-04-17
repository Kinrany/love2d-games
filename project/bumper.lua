local Bumper = Class('Bumper')

local _private = setmetatable({}, {__mode="k"})

function Bumper.initialize(self, owner, box, options)
	options = options or {}
	
	_private[self] = {
		box = assert(box),
		owner = assert(owner),
		world = options.world,
		filter = options.filter,
		handler = options.handler
	}

	if options.world then 
		options.world:add(self, _private[self].box:unpack())
	end
end

function Bumper.get_owner(self)
	return _private[self].owner
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

function Bumper.set_handler(self, handler)
	_private[self].handler = handler
end

function Bumper.move(self, x, y, options)
	options = options or {}
	local filter = options.filter or _private[self].filter
	local handler = options.handler or _private[self].handler
	
	local world = _private[self].world
	local collisions
	if world then
		x, y, collisions = world:move(self, x, y, filter)
	end
	
	_private[self].box:update(x, y)
	
	if collisions and handler then
		__(collisions):each(function(collision)
			handler(collision.item, collision.other, collision)
		end)
	end
end

return Bumper
