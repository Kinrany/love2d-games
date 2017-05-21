local ImageManager = require "ImageManager"


local ImageComponent = Class('ImageComponent')

function ImageComponent.initialize(self, name)
	assert(type(name) == "string", "name is a " .. type(name) .. " but should be a string")
	
	self.image = ImageManager.get(name) 
	assert(self.image, "Couldn't load image " .. name)
end

return ImageComponent
