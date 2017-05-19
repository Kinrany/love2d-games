local turfs = require "TurfContainer"

local map = require "Map"
local turfCodes = {
	[0] = require "entities/Grass",
	[1] = require "entities/Stone"
}

function love.load() 
	for x = 1, #map do
		for y = 1, #(map[x]) do
			local turfCode = map[x][y]
			local turfClass = turfCodes[turfCode]
			turfs.set(x-1, y-1, turfClass())
		end
	end
end

function love.update(dt)

end

function love.draw()
	turfs.draw()
end
