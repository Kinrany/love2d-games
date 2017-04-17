local Box       = require "box"
local Bumper    = require "bumper"
local Color     = require "color"
local Drawable  = require "drawable"

local Character = Class('Character')

Character.static.width = 30
Character.static.height = 50
Character.static.color = Color:new(48, 99, 181)
Character.static.speed = 1

function Character.initialize(self, x, y, bump_world)
	self.box = Box:new(x or 0, y or 0, self.class.width, self.class.height)
	self.bumper = Bumper:new(
		self, self.box, 
		{world=bump_world, handler=collision_handler})
	self.brain = nil
end

function Character.update(self)
	if self.brain then
		local commands = self.brain:get_commands()
		local speed = self.class.speed
		local dx, dy = 0, 0
		
		if commands["up"]   or commands["w"] then
			dy = dy - speed
		end
		if commands["down"] or commands["s"] then
			dy = dy + speed
		end
		if commands["left"]   or commands["a"] then
			dx = dx - speed
		end
		if commands["right"] or commands["d"] then
			dx = dx + speed
		end
		
		self.bumper:move(self.box.x + dx, self.box.y + dy)
	end
end

function collision_handler(item, other, collision)
	local item_name = tostring(item:get_owner())
	local other_name = tostring(other:get_owner())
	--print(item_name.." collided with "..other_name)
end

Character:include(Drawable)

return Character
