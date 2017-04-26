_G.Beholder = require "lib/beholder"
_G.Class    = require "lib/middleclass"
_G.__       = require "lib/underscore"
_G.Inspect  = require "lib/inspect"
_G.Memoize  = require "lib/memoize"

_G.Color = require "color"

local Organ = require "Organ"

function love.update(dt)
	Organ.process_fired()
end
