local Rectangle = Class('Rectangle')

function Rectangle.initialize(self, x, y, w, h)
	self.x = assert(x)
	self.y = assert(y)
	self.w = assert(w)
	self.h = assert(h)
end

function Rectangle.unpack(self)
	return self.x, self.y, self.w, self.h
end

function Rectangle.draw(self)
	love.graphics.rectangle("fill", self:unpack())
end

return Rectangle
