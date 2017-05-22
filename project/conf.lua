_G.inspect = require "lib/inspect"
_G.memoize = require "lib/memoize"
_G.class   = require "lib/middleclass"
_G.__      = require "lib/underscore"

inspect.print = function(self, ...)
	return print(self(...))
end
