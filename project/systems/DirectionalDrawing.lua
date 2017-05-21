local DirectionalDrawingSystem = ECS.processingSystem()

DirectionalDrawingSystem.filter = ECS.requireAll("directional_image", "position", "direction")

local TILE_WIDTH = 32

function DirectionalDrawingSystem.process(self, e, dt)
	local directional_image = e.directional_image
	local position = e.position
	local direction = e.direction
	
	local image = directional_image.images[direction]
	local x, y = position.x, position.y
	love.graphics.draw(image, x * TILE_WIDTH, y * TILE_WIDTH)
end

return DirectionalDrawingSystem
