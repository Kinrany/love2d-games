local Sprite = require "Sprite"



local Tile = class("Tile")

function Tile.initialize(self, name, x, y)
	self.sprite = Sprite:new(name, x, y)
end

return Tile
