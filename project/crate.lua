local Box       = require "box"
local Bumper    = require "bumper"
local Color     = require "color"
local Drawable  = require "drawable"

local Crate = Class('Crate')

Crate.static.width = 30
Crate.static.height = 30
Crate.static.color = Color:new(247, 134, 22)

function Crate.initialize(self, x, y, bump_world)
	self.box = Box:new(x or 0, y or 0, self.class.width, self.class.height)
	self.bumper = Bumper:new(self.box, bump_world)
end

Crate:include(Drawable)

return Crate
