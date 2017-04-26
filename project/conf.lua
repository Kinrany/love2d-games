_G.Beholder = require "lib/beholder"
_G.Class    = require "lib/middleclass"
_G.__       = require "lib/underscore"
_G.Inspect  = require "lib/inspect"
_G.Memoize  = require "lib/memoize"

_G.Color     = require "lib/classes/color"
_G.Rectangle = require "lib/classes/rectangle"

_G.Lovebird = require "lib/lovebird/lovebird"
Lovebird.allowhtml=true
Lovebird.print = __.wrap(Lovebird.print, function(lp, ...)
	lp("<pre>")
	lp(...)
	lp("</pre>")
end)
