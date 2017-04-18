local Box    = require "box"
local Bumper = require "bumper"
local Color  = require "color"

local Crane = Class('Crane')

Crane.static.base_width = 60
Crane.static.base_height = 40
Crane.static.shoulder = 300
Crane.static.knot_radius = 10
Crane.static.hand_radius = 15
Crane.static.color1 = Color(255, 165, 0)
Crane.static.color2 = Color(178, 89, 0)
Crane.static.color3 = Color(63, 52, 40)

function Crane.initialize(self, x, y, bump_world)
	self.base_box = Box:new(x, y, self.class.base_width, self.class.base_height)
	self.bumper = Bumper:new(self, self.base_box, {world=bump_world})
end

function Crane.draw(self)
	local mouseX, mouseY = love.mouse.getPosition()
	local boxX, boxY = self.base_box:center()
	local dx, dy = mouseX - boxX, mouseY - boxY
	
	local sh = Crane.shoulder
	local knot_height = math.sqrt(sh*sh - (dx*dx + dy*dy)/4)
	local knotX, knotY = boxX + dx/2, boxY + dy/2 - knot_height
	
	-- draw first shoulder
	love.graphics.setColor(Crane.color1)
	love.graphics.setLineWidth(5)
	love.graphics.line(boxX, boxY, knotX, knotY)
	
	-- draw base
	love.graphics.setColor(Crane.color2)
	love.graphics.rectangle("fill", self.base_box:unpack())
	
	-- draw hand
	love.graphics.setColor(Crane.color3)
	love.graphics.ellipse("fill", mouseX, mouseY, Crane.hand_radius, 10)
	
	-- draw second shoulder
	love.graphics.setColor(Crane.color1)
	love.graphics.setLineWidth(5)
	love.graphics.line(knotX, knotY, mouseX, mouseY)
	
	-- draw knot
	love.graphics.setColor(Crane.color2)
	love.graphics.circle("fill", knotX, knotY+5, Crane.knot_radius)
	
	-- debug output
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("Shoulder: "..sh                        , 200, 0)
	love.graphics.print("dxdy: "    ..dx          ..", "..dy    , 200, 12)
	love.graphics.print("Knot: "    ..knotX       ..", "..knotY , 200, 24)
	love.graphics.print("Height: "  ..knot_height               , 200, 36)
end

function Crane.__index(self, key)
	if key == "box" then
		return self.base_box
	end
end

return Crane
