local PlayerMovementComponent = Class('PlayerMovementComponent')

function PlayerMovementComponent.initialize(self)
	__.extend(self, {
		_left = false,
		_right = false,
		_up = false,
		_down = false
	})
end

function PlayerMovementComponent.left(self) 
	local pressed = love.keyboard.isDown("left")
	local changed = (pressed ~= self._left)
	self._left = pressed
	return pressed, changed
end

function PlayerMovementComponent.right(self) 
	local pressed = love.keyboard.isDown("right")
	local changed = (pressed ~= self._right)
	self._right = pressed
	return pressed, changed
end

function PlayerMovementComponent.up(self) 
	local pressed = love.keyboard.isDown("up")
	local changed = (pressed ~= self._up)
	self._up = pressed
	return pressed, changed
end

function PlayerMovementComponent.down(self) 
	local pressed = love.keyboard.isDown("down")
	local changed = (pressed ~= self._down)
	self._down = pressed
	return pressed, changed
end

return PlayerMovementComponent
