local Brick = require "entities/Brick"
local Human = require "entities/Human"

local turfs = require "TurfContainer"

local DrawingSystem = require "systems/Drawing"
local DirectionalDrawingSystem = require "systems/DirectionalDrawing"
local PlayerMovementSystem = require "systems/PlayerMovement"

local world = ECS.world()
world:addSystem(DrawingSystem)
world:addSystem(DirectionalDrawingSystem)
world:addSystem(PlayerMovementSystem)


function love.load() 
	turfs.loadMap(require "Map")
	turfs.addToECS(world)
	
	local brick = Brick(3, 5)
	world:addEntity(brick)
	
	local human = Human(10, 12)
	world:addEntity(human)
end

function love.draw()
	world:update(love.timer.getDelta())
end
