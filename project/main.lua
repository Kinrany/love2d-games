

_G.drawlist   = require "lib/tools/drawlist"
_G.updatelist = require "lib/tools/updatelist"

local Organ = require "Organ"
local Player = require "Player"

function love.load()
	player = Player()
end

function love.update(dt)
	Organ.process_fired()
	
	--updatelist.update(dt)
	
	player:update(dt)
	
	Lovebird.update()
end

function love.draw()
	love.graphics.setBackgroundColor(128, 256, 128)
	--drawlist.draw()
	player:draw()
end
