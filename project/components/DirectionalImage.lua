local ImageManager = require "ImageManager"


local DirectionalImageComponent = Class('DirectionalImageComponent')

function DirectionalImageComponent.initialize(self, name)
	assert(type(name) == "string", "name is a " .. type(name) .. " but should be a string")
	
	local up = ImageManager.get(name) or ImageManager.get(name .. "_up")
	assert(up, "Couldn't load image " .. name)
	
	self.images = {
		["RIGHT"] = ImageManager.get(name .. "_right") or up,
		["DOWN"] = ImageManager.get(name .. "_down") or up,
		["LEFT"] = ImageManager.get(name .. "_left") or up,
		["UP"] = up
	}
end

return DirectionalImageComponent
