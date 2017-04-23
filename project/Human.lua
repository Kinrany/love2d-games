local Color = require "color"
local DrawBodyRectangle = require "DrawBodyRectangle"
local DrawHeadRectangle = require "DrawHeadRectangle"
local WasdMovement = require "WasdMovement"


local Human = Class('Human', Entity)
Human:include(DrawBodyRectangle)
Human:include(DrawHeadRectangle)
Human:include(WasdMovement)

function Human.initialize(self, x, y)
	self.class.super.initialize(self, assert(x), assert(y))
	self:initDrawBodyRectangle(30, 50, Color(128, 64, 128))
	self:initDrawHeadRectangle(20, 20, Color(64, 32, 64))
	self:initWasdMovement(200)
end

function Human.update(self, dt)
	self:updateWasdMovement(dt)
end

function Human.draw(self)
	self:drawBodyRectangle()
	self:drawHeadRectangle()
end

return Human
