local Dir = require "Direction"


local ImageManager = {}
local images = {}

-- provides error message as second return value
function ImageManager.get(name)
	local image = images[name]
	if image then
		return image
	end
	
	image, error_message = ImageManager._tryLoad(name)
	images[name] = image
	return image, error_message
end

ImageManager.getPack = memoize(function(name)
	local pack = {}
	pack.default = ImageManager.get(name .. Dir.default) or ImageManager.get(name) error("No image")
	
	for dir in Dir.iter() do
		pack[tostring(dir)] = ImageManager.get(name .. dir)
	end
	
	return setmetatable(pack, {__index = function(self, key) return self.default end})
end)

function ImageManager._load(name)
	return love.graphics.newImage("resources/" .. name .. ".png")
end

-- on success returns image
-- on failure returns nil and error message
function ImageManager._tryLoad(name) 
	local success, image_or_error = pcall(love.graphics.newImage, "resources/" .. name .. ".png")
	if success then
		return image_or_error -- image
	else
		return nil, image_or_error -- nil, error
	end
end

return ImageManager
