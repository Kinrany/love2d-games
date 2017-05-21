local Direction = require "classes/Direction"


local PlayerMovementSystem = ECS.processingSystem()

PlayerMovementSystem.filter = ECS.requireAll("position", "direction", "player_movement")

local TILE_WIDTH = 32

function PlayerMovementSystem.process(self, e, dt)
	local position = e.position
	local direction = e.direction
	local player_movement = e.player_movement
	
	local pressed, changed = player_movement:up()
	if pressed and changed then
		position:move(direction)
	end
	
	local pressed, changed = player_movement:left()
	if pressed and changed then
		e.direction = direction + "LEFT"
	end
	
	local pressed, changed = player_movement:right()
	if pressed and changed then
		e.direction = direction + "RIGHT"
	end
	
	local pressed, changed = player_movement:down()
	if pressed and changed then
		e.direction = direction + "BACK"
	end
end

PlayerMovementSystem.custom_flags = {
	update = true,
	draw = false
}

return PlayerMovementSystem
