local Turf = require "entities/Turf"
local Grass = Class("Grass", Turf)

function Grass.initialize(self, x, y)
	Turf.initialize(self, "grass", x, y)
end

return Grass
