local Turf = require "entities/Turf"
local Grass = Class("Grass", Turf)

function Grass.initialize(self)
	Turf.initialize(self, "grass")
end

return Grass
