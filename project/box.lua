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

function Box.center(self)
	return self.x + self.w/2, self.y + self.h/2
end

function Box.__index(self, key)
	if     key == "centerX"  then return self.x + self.w/2
	elseif key == "centerY"  then return                    self.y + self.h/2
	elseif key == "left"     then return self.x
	elseif key == "right"    then return self.x + self.w
	elseif key == "top"      then return                    self.y
	elseif key == "bottom"   then return                    self.y + self.h
	end
end

return Box
