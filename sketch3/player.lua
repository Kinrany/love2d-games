local Sprite = require "sprite"


local prototype = {
	speed = 3
}

function prototype.move(self, dx, dy)
	local world = self.bump_world
	local sprite = self.sprite
	
	local goalX, goalY = sprite.x + dx, sprite.y + dy
	local actualX, actualY = world:move(self, goalX, goalY, nil)
	sprite:set_xywh(actualX, actualY)
end

function prototype.update(self)
	local brain = self.brain
	if brain then
		local input = brain:get_input()
		local speed = self.speed
		
		if input["up"] or input["w"] then
			self:move(0, -speed)
		end
		if input["down"] or input["s"] then
			self:move(0, speed)
		end
		if input["left"] or input["a"] then
			self:move(-speed, 0)
		end
		if input["right"] or input["d"] then
			self:move(speed, 0)
		end
	end
end

function prototype.draw(self)
	love.graphics.setColor(64, 192, 64)
	love.graphics.rectangle("fill", self.sprite:get_xywh())
end

function prototype.destroy(self)
	self.bump_world:remove(self)
end



local Player = {}

function Player.new(bump_world)
	local sprite = Sprite.new()
	sprite.w = 30
	sprite.h = 50
	
	local player = {
		sprite = sprite,
		bump_world = bump_world
	}
	
	bump_world:add(player, sprite:get_xywh())
	
	return setmetatable(player, {__index = prototype})
end

return Player
