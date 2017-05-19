local ImageManager = require "ImageManager"


local ImageComponent = Class('ImageComponent')

function ImageComponent.initialize(self, name)
	self.image = ImageManager.get(name)
end

function ImageComponent.draw(self, x, y)
	love.graphics.draw(self.image, x, y)
end

return ImageComponent
