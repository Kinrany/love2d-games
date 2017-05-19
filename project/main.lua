local turfs = require "TurfContainer"

function love.load() 
	local map = require "Map"
	turfs.loadMap(map)
end

function love.update(dt)

end

function love.draw()
	turfs.draw()
end
