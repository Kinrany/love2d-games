local function empty_function(self, args) end

local objects = setmetatable({}, {__mode = "k"})

local prototype = {
	name    = "GameObject",
	pos     = Vector2.new(0, 0),
	width   = 20,
	height  = 20,
	
	load    = empty_function,
	draw    = empty_function,
	update  = empty_function
}


local GameObject = {}

function GameObject.new(args)
	args = args or {}
	
	local object = setmetatable({}, {__index = prototype})
	Moses.forEach(args, function(k, v) object[k] = v end)
	
	objects[object] = true
	
	return object
end

function GameObject.load(args)
	Moses.forEach(objects, function(object, _) object:load(args) end)
end

function GameObject.draw(args)
	Moses.forEach(objects, function(object, _) object:draw(args) end)
end

function GameObject.update(args)
	Moses.forEach(objects, function(object, _) object:update(args) end)
end

return GameObject
