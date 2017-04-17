local prototype = {
	x = 0,
	y = 0,
	w = 100,
	h = 100
}

function prototype.get_left(self) 
	return self.x
end
function prototype.get_right(self)
	return self.x + self.w
end
function prototype.get_top(self)
	return self.y
end
function prototype.get_bottom(self)
	return self.y + self.h
end

function prototype.get_center(self)
	return self.x + self.w / 2, self.y + self.h / 2
end

function prototype.get_xywh(self)
	return self.x, self.y, self.w, self.h
end

function prototype.set_xywh(self, x, y, w, h)
	self.x = x or self.x
	self.y = y or self.y
	self.w = w or self.w
	self.h = h or self.h
end



local Sprite = {}

function Sprite.new()
	return setmetatable({}, {__index = prototype})
end

return Sprite
