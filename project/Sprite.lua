local ImageManager = require "ImageManager"
local Direction = require "Direction"



local Sprite = class("Sprite")


Sprite.static._world = {}
Sprite.static._worldAddSprite = function(self, sprite)
	local x, y = sprite._x, sprite._y
	local w = self._world
	
	if not w[x] then
		w[x] = {}
	end
	if not w[x][y] then
		w[x][y] = setmetatable({}, {__mode="k"})
	end
	w[x][y][sprite] = true
end
Sprite.static._worldDeleteSprite = function(self, sprite)
	self._world[sprite._x][sprite._y][sprite] = nil
end
Sprite.static._worldMoveSprite = function(self, sprite, new_x, new_y)
	self:_worldDeleteSprite(sprite)
	sprite._x = new_x
	sprite._y = new_y
	self:_worldAddSprite(sprite)
end


-- creates iterator (xy_table, sprite) -> (next sprite, 'true')
Sprite.static.iterAt = function(self, x, y)
	local w = self._world
	local xy_table = w[x] and w[x][y]
	if xy_table then
		return next, xy_table, nil
	else
		return function() end
	end
end

-- creates iterator () -> (sprite, x, y)
Sprite.static.iterAll = function(self)
	local w = self._world
	local x, x_table = next(w)
	local y, xy_table = next(x_table or {})
	local sprite;
	return function()
		sprite = next(xy_table or {}, sprite)
		if not sprite then
			y, xy_table = next(x_table or {}, y)
			if not y then
				x, x_table = next(w, x)
				if not x then
					return nil
				end
				y, xy_table = next(x_table or {}, y)
			end
			sprite = next(xy_table or {}, sprite)
		end
		return sprite, x, y
	end
end


function Sprite.initialize(self, name, x, y, dir, image_name)
	self.name = assert(name)
	self._x = x or 0
	self._y = y or 0
	
	image_name = image_name or name
	self._image_pack = assert(ImageManager.getPack(image_name))
	
	self._dir = dir or Direction.default
	
	self.class:_worldAddSprite(self)
end

function Sprite.__tostring(self)
	return self.name .. " sprite"
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
function Sprite.getImage(self)
	return self._image_pack[self._dir]
end

function Sprite.setPos(self, x, y)
	self.class:_worldMoveSprite(self, x, y)
end
function Sprite.setDir(self, direction)
	self._dir = direction
end

function Sprite.moveAbsolute(self, direction)
	local new_x = self._x + direction.dx
	local new_y = self._y + direction.dy
	self.class:_worldMoveSprite(self, new_x, new_y)
end
function Sprite.moveRelative(self, relativeDirection)
	local absolute = self._dir + relativeDirection
	self:moveAbsolute(absolute)
end
function Sprite.turn(self, direction)
	self._dir = self._dir + direction
end


return Sprite
