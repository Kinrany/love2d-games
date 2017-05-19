local ImageComponent = require "components/Image"
local DirectionComponent = require "components/Direction"
local PositionComponent = require "components/Position"


local Item = Class("Item")

function Item.initialize(self, image, x, y, dir)
	self.image = ImageComponent(image)
	self.position = PositionComponent(x or 0, y or 0)
	self.direction = DirectionComponent(dir or "UP")
end

return Item
