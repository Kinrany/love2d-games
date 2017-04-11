local prototype = {
	name = "Crate",
	pos = Vector2.new(0, 0),
	width = 20,
	height = 20
}

function prototype.draw(self)
	love.graphics.setColor(128, 128, 0)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
end

local function new_crate(self, x, y)
	local crate = setmetatable({}, {__index = prototype})
	crate.pos = Vector2.new(x or crate.pos.x, y or crate.pos.y)
	return crate 
end

return setmetatable({}, {__call = new_crate})