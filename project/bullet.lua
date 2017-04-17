local getprivate = require('tools').getprivate
local setprivate = require('tools').setprivate

local Bullet = {}
Bullet.world = nil

local prototype = {
	name = "Bullet",
	pos = Vector2.new(0, 0),
	width = 5,
	height = 5,
	velocity = Vector2.new(0, 0),
	speed = 10
}

function prototype.load(self)
	Bullet.world:add(self, self.pos.x, self.pos.y, self.width, self.height)
end

function prototype.draw(self)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
end

function prototype.update(self)
	local goalX, goalY = (self.pos + self.velocity):unpack()
	local actualX, actualY, cols, len = Bullet.world:move(self, goalX, goalY, function(item, other)
		if other.name == "Turret" then 
			return nil
		else 
			return "touch"
		end
	end)
	
	__(cols):each(function(collision)
		local other = collision.other
		if other.name == "Character" then
			other:take_damage(self)
		end
	end)

	self.pos = Vector2.new(actualX, actualY)

	if len > 0 then
		-- there was a collision
		self:destroy()
	end
	
	if self.pos:len() > 1000 then
		-- bullet is too far from the middle
		self:destroy()
	end
end

function prototype.set_direction(self, direction_vector)
	self.velocity = direction_vector:normalized() * self.speed
end

local bullets = setmetatable({}, {__mode = "k"})
function prototype.destroy(self)
	Bullet.world:remove(self)
	bullets[self] = nil
end

function Bullet.load(self, world)
	Bullet.world = world
end

function Bullet.draw(self)
	__(bullets):chain():keys():each(function(bullet)
		bullet:draw()
	end)
end

function Bullet.update(self)
	__(bullets):chain():keys():each(function(bullet)
		bullet:update(Bullet.world)
	end)
end

function Bullet.new(self, x, y)
	local bullet = setmetatable({}, {__index = prototype})
	bullet.pos = Vector2.new(x or bullet.pos.x, y or bullet.pos.y)
	bullets[bullet] = true 
	bullet:load()
	return bullet 
end

return setmetatable(Bullet, {__call = Bullet.new})