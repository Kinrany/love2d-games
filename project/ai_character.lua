local Character   = require "character"
local AIBrain     = require "ai_brain"

local AICharacter = Class('AICharacter', Character)

function AICharacter.initialize(self, x, y, bump_world)
	self.class.super.initialize(self, x, y, bump_world)
	self.brain = AIBrain:new()
end

return AICharacter
