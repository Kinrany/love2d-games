local Organ = require "Organ"

local Brain = Class('Brain', Organ)

local function stimulation_handler(self, host, port, data)
	
end

function Brain.initialize(self)
	self.class.super.initialize(self, stimulation_handler)
end


return Brain
