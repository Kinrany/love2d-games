local DirectionalImageComponent = require "components/DirectionalImage"
local DirectionComponent = require "components/Direction"
local PositionComponent = require "components/Position"


local Item = Class("Item")

function Item.initialize(self, image_name, x, y, dir)
	self.directional_image = DirectionalImageComponent(image_name)
	self.position = PositionComponent(x or 0, y or 0)
	self.direction = DirectionComponent(dir or "UP")
end

return Item
