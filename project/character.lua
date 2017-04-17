local Sprite = require "sprite"


local prototype = {
	speed = 3,
	color = {64, 192, 64}
}

function prototype.move(self, dx, dy)
	local world = self.bump_world
	local sprite = self.sprite
	
	local goalX, goalY = sprite.x + dx, sprite.y + dy
	local actualX, actualY
	if world then
		actualX, actualY = world:move(self, goalX, goalY, nil)
	else
		actualX, actualY = goalX, goalY
	end
	
	sprite:set_xywh(actualX, actualY)
end

function prototype.set_bump_world(self, bump_world)
	if self.bump_world then
		self.bump_world:remove(self)
		self.bump_world = nil
	end
	
	if bump_world then
		bump_world:add(self, self.sprite:get_xywh())
		self.bump_world = bump_world
	end
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
	love.graphics.setColor(unpack(self.color))
	love.graphics.rectangle("fill", self.sprite:get_xywh())
end

function prototype.destroy(self)
	self:set_bump_world(nil)
end



local Character = {}

function Character.new(bump_world)
	local sprite = Sprite.new()
	sprite.w = 30
	sprite.h = 50
	
	local character = {
		sprite = sprite
	}
	setmetatable(character, {__index = prototype})
	
	character:set_bump_world(bump_world)
	
	return character
end

return Character
