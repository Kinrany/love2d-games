_G.Inspect = require "lib/inspect"
_G.Memoize = require "lib/memoize"
_G.Class   = require "lib/middleclass"
_G.__      = require "lib/underscore"


local Bump = require "lib/bump"
local bump_world = Bump.newWorld()

local Crate = require "crate"
local crates = {}

function love.update()
	if love.mouse.isDown(1) then
		local x, y = love.mouse.getPosition()
		x, y = x - Crate.width/2, y - Crate.height/2
		local crate = Crate:new(x, y, bump_world)
		table.insert(crates, crate)
	end
end

function love.draw()
	love.graphics.setBackgroundColor(192, 255, 192)
	
	for i, crate in ipairs(crates) do
		crate:draw()
	end
	
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(#crates, 0, 0)
end
