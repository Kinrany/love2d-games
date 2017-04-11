local Bullet = require('bullet')

local prototype = {
	name = "Turret",
	pos = Vector2.new(0, 0),
	width = 20,
	height = 20,
	cooldown = 0.3,
	target = nil
}

function prototype.draw(self)
	love.graphics.setColor(0, 128, 128)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
end

function prototype.shoot(self)
	if self.target then
		local bullet = Bullet(self.pos.x, self.pos.y)
		bullet:set_direction(self.target.pos - self.pos)
	else
		print("no target")
	end
end

local last_shot = nil
function prototype.update(self)
	local current_time = love.timer.getTime()
	if (last_shot == nil or (current_time - last_shot) > self.cooldown) then
		last_shot = current_time
		self:shoot()
	end
end

local function new(self, x, y)
	local turret = setmetatable({}, {__index = prototype})
	turret.pos = Vector2.new(x or turret.pos.x, y or turret.pos.y)
	return turret 
end

return setmetatable({}, {__call = new})