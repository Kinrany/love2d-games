local ImageManager = require "ImageManager"


local ImageComponent = Class('ImageComponent')

function ImageComponent.initialize(self, arg)
	if type(arg) == "string" then
		self.image = ImageManager.get(arg)
	elseif type(arg) == "table" then
		self.image = arg
	else 
		error("arg = " .. tostring(arg) .. " of type " .. type(arg) .. ", not string or table")
	end
end

function ImageComponent.draw(self, x, y)
	love.graphics.draw(self.image, x, y)
end

return ImageComponent
