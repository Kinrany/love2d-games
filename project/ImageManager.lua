local ImageManager = {}

local images = {}

function ImageManager.get(name)
	local image = images[name]
	if image then
		return image
	end
	
	image = ImageManager.load(name)
	images[name] = image
	return image
end

function ImageManager.load(name)
	return love.graphics.newImage("resources/" .. name .. ".png")
end

return ImageManager
