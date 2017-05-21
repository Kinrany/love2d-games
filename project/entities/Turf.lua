local ImageComponent = require "components/Image"
local PositionComponent = require "components/Position"


local Turf = Class("Turf")

function Turf.initialize(self, image, x, y)
	self.image = ImageComponent(image)
	self.position = PositionComponent(x, y)
end

return Turf
