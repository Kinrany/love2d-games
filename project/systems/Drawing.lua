local DrawingSystem = ECS.processingSystem()

DrawingSystem.filter = ECS.requireAll("image", "position")

local TILE_WIDTH = 32

function DrawingSystem.process(self, e, dt)
	love.graphics.draw(e.image.image, e.position.x * TILE_WIDTH, e.position.y * TILE_WIDTH)
end

return DrawingSystem
