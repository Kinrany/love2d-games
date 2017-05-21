local DrawingSystem = ECS.processingSystem()

DrawingSystem.filter = ECS.requireAll("image", "position")

local TILE_WIDTH = 32

function DrawingSystem.process(self, e, dt)
	local image = e.image
	local position = e.position
	
	local image = image.image
	local x, y = position.x, position.y
	love.graphics.draw(image, x * TILE_WIDTH, y * TILE_WIDTH)
end

return DrawingSystem
