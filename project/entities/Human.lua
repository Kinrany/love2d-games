local Direction = require "classes/Direction"

local DirectionalImageComponent = require "components/DirectionalImage"
local PositionComponent = require "components/Position"
local PlayerMovementComponent = require "components/PlayerMovement"


local Human = Class("Human")

function Human.initialize(self, x, y)
	self.directional_image = DirectionalImageComponent("human")
	self.position = PositionComponent(x or 0, y or 0)
	self.direction = Direction.FRONT
	self.player_movement = PlayerMovementComponent()
end

return Human
