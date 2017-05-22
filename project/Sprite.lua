local ImageManager = require "ImageManager"
local Direction = require "Direction"

local Sprite = {}

function Sprite.new(args)
	assert(args, "At least tell me your name!")
	
	local name = args.name or args.image_name
	local image_name = args.image_name or args.name
	local x, y = args.x or 0, args.y or 0
	local dir = args.dir or Direction.front
	
	
end

function Sprite.create(name, image_name, x, y, dir)
	local image = ImageManager.get(image_name) or ImageManager.get(image_name .. "_" .. dir)
	local sprite = {
		name = assert(name),
		image_name = assert(ImageManager.get(image_name))
	}
end

return Sprite
