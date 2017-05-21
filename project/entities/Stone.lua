local Turf = require "entities/Turf"
local Stone = Class("Stone", Turf)

function Stone.initialize(self, x, y)
	Turf.initialize(self, "stone", x, y)
end

return Stone
