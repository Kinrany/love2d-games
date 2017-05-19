local Brick = require "entities/Brick"

local turfs = require "TurfContainer"

local DrawingSystem = require "systems/Drawing"
local world = ECS.world(DrawingSystem)

function love.load() 
	turfs.loadMap(require "Map")
	local brick = Brick(3, 5)
	world:add(brick)
	
end

function love.update(dt)
	--world:update(dt)
end

function love.draw()
	turfs.draw()
	--world:update(dt, function (system) return system == DrawingSystem end)
	world:update(dt)
end
