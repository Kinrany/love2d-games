local Turf = require "entities/Turf"
local Stone = Class("Stone", Turf)

function Stone.initialize(self)
	Turf.initialize(self, "stone")
end

return Stone
