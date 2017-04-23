_G.Class  = require "lib/middleclass"
_G.__     = require "lib/underscore"
_G.Entity = require "entity"


local Human = require "human"


function love.load(arg) 
	Human(100, 100)
end

function love.update(dt)
	__.each(Entity.list, function(entity) entity:update(dt) end)
end

function love.draw()
	love.graphics.setBackgroundColor(180, 255, 180)
	__.each(Entity.list, function(entity) entity:draw() end)
end


