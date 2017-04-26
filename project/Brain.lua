local Organ = require "Organ"

local Brain = Class('Brain', Organ)

local stimulation_handlers = {
	update = function(self, data)
		__.each({"w", "s", "a", "d"}, function(key)
			if love.keyboard.isDown(key) then
				self:fire(key)
			end
		end)
	end
}

function Brain.initialize(self)
	self.class.super.initialize(self, stimulation_handlers)
end

return Brain
