local Brick = require "entities/Brick"

local turfs = require "TurfContainer"

local DrawingSystem = require "systems/Drawing"
local DirectionalDrawingSystem = require "systems/DirectionalDrawing"

local world = ECS.world()
world:addSystem(DrawingSystem)
world:addSystem(DirectionalDrawingSystem)


function love.load() 
	turfs.loadMap(require "Map")
	turfs.addToECS(world)
	
	local brick = Brick(3, 5)
	world:add(brick)
end

function love.update(dt)
	--world:update(dt)
end

function love.draw()
	--turfs.draw()
	--world:update(dt, function (system) return system == DirectionalDrawingSystem end)
	world:update(dt)
end
