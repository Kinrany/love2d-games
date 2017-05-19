local ImageComponent = require "components/Image"


local Turf = Class("Turf")

function Turf.initialize(self, image)
	self.image = ImageComponent(image)
end

return Turf
