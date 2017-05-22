local ImageManager = require "ImageManager"
local Direction = require "Direction"

local Sprite = class("Sprite")

Sprite.static._world = {}
Sprite.static._worldAddSprite = function(self, sprite)
	local x, y = sprite._x, sprite_y
	if not _world[x] then
		_world[x] = {}
	end
	if not _world[x][y] then
		_world[x][y] = setmetatable({}, {__mode="k"})
	end
	_world[x][y][sprite] = true
end
Sprite.static_worldDeleteSprite = function(self, sprite)
	_world[sprite._x][sprite._y][sprite] = nil
end
Sprite.static._worldMoveSprite = function(self, sprite, new_x, new_y)
	self:_worldDeleteSprite(sprite)
	sprite._x = new_x
	sprite._y = new_y
	self:_worldAddSprite(sprite)
end

function Sprite.initialize(self, args)
	assert(args, "At least tell me your name!")
	
	self.name = args.name or args.image_name or "Sprite"
	
	local image_name = args.image_name or args.name
	self._image_pack = assert(ImageManager.getPack(image_name))
	
	self._x = args.x or 0
	self._y = args.y or 0
	self._dir = args.dir or Direction.default
end

function Sprite.getX(self)
	return self._x
end
function Sprite.getY(self)
	return self._y
end
function Sprite.getPos(self)
	return self._x, self._y
end

function Sprite.getDir(self)
	return self._dir
end

function Sprite.move(self, direction)
	local new_x = self._x + direction.dx
	local new_y = self._y + direction.dy
	self.class:_worldMoveSprite(sprite, new_x, new_y)
end

function Sprite.turn(self, direction)
	self._dir = self._dir + direction
end

function Sprite.getImage(self)
	return self._image_pack(self._dir)
end

return Sprite
