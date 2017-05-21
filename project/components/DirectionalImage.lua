local Direction = require "classes/Direction"

local ImageManager = require "ImageManager"


local DirectionalImageComponent = Class('DirectionalImageComponent')

function DirectionalImageComponent.initialize(self, name)
	assert(type(name) == "string", "name is a " .. type(name) .. " but should be a string")
	
	local front = ImageManager.get(name) or ImageManager.get(name .. "_front")
	assert(front, "Couldn't load image " .. name)
	
	local back = ImageManager.get(name .. "_back") or front
	local left = ImageManager.get(name .. "_left") or back or front
	local right = ImageManager.get(name .. "_right") or front
	
	self.images = {
		[Direction.FRONT] = front,
		[Direction.BACK] = back,
		[Direction.LEFT] = left,
		[Direction.RIGHT] = right
	}
end

return DirectionalImageComponent
