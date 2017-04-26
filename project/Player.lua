local Organ = require "Organ"
local Brain = require "Brain"
local Legs  = require "Legs"


local Player = Class('Player')

Player.static.tick_organ = Organ()

function Player.initialize(self)
	self.color = Color.blue
	self.rect = Rectangle(100, 100, 100, 100)
	
	self.brain = Brain()
	self.legs = Legs(self.rect)
	
	Organ.connect(self.brain, "update", Player.tick_organ, "tick")
	__({{"right", "d"},
		{"left",  "a"},
		{"up",    "w"},
		{"down",  "s"}}):each(function(axons) 
			Organ.connect(self.legs, axons[1], self.brain, axons[2]) 
		end)
	
end

function Player.draw(self)
	self.color:draw()
	self.rect:draw()
end

function Player.update(self, dt)
	Player.tick_organ:fire("tick")
end

return Player
