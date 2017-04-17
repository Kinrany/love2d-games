local Color = Class('Color')

function Color.initialize(self, r, g, b, a)
	self[1] = assert(r)
	self[2] = assert(g)
	self[3] = assert(b)
	self[4] = a or 255
end

function Color.unpack(self)
	return self[1], self[2], self[3], self[4]
end

function Color.__index(self, key)
	if     key == 'r' then return self[1]
	elseif key == 'g' then return self[2]
	elseif key == 'b' then return self[3]
	elseif key == 'a' or key == 'alpha' then
		return self[4]
	end
end

return Color