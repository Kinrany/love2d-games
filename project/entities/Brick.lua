local Item = require "entities/Item"

local ImageComponent = require "components/Image"


local Brick = Class("Brick", Item)

function Brick.initialize(self, x, y)
	Item.initialize(self, "brick", x, y)
end


return Brick
