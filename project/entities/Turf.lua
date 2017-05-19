local ImageComponent = require "components/Image"


local Turf = Class("Turf")

function Turf.initialize(self, image)
	if (type(image) == "string") then
		image = ImageComponent(image)
	end
	
	self.image = assert(image)
end

return Turf
