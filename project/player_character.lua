local Character   = require "character"
local PlayerBrain = require "player_brain"
local Color       = require "color"

local PlayerCharacter = Class('PlayerCharacter', Character)

PlayerCharacter.static.color = Color:new(168, 61, 35)
PlayerCharacter.static.speed = 4

function PlayerCharacter.initialize(self, x, y, bump_world)
	self.class.super.initialize(self, x, y, bump_world)
	self.brain = PlayerBrain:new()
end

return PlayerCharacter
