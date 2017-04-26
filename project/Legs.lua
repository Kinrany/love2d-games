local Organ = require "Organ"

local Legs = Class('Legs', Organ)

local stimulation_handlers = {
	right = function(self, data)
		self._rect.x = self._rect.x + self._speed
	end,
	left = function(self, data)
		self._rect.x = self._rect.x - self._speed
	end,
	up = function(self, data)
		self._rect.y = self._rect.y - self._speed
	end,
	down = function(self, data)
		self._rect.y = self._rect.y + self._speed
	end
}

function Legs.initialize(self, rect)
	self.class.super.initialize(self, stimulation_handlers)
	self._rect = rect
	self._speed = 5
end

return Legs
