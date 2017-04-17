local Box = Class('Box')

function Box.initialize(self, x, y, w, h)
	self.x = assert(x)
	self.y = assert(y)
	self.w = assert(w)
	self.h = assert(h)
end

function Box.update(self, x, y, w, h)
	self.x = x or self.x
	self.y = y or self.y
	self.w = w or self.w
	self.h = h or self.h
end

function Box.unpack(self)
	return self.x, self.y, self.w, self.h
end

return Box