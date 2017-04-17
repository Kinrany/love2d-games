local Drawable = {}

function Drawable.draw(self)
	local box, color = self.box, self.color or self.class.color
	love.graphics.setColor(color:unpack())
	love.graphics.rectangle("fill", box:unpack())
end

return Drawable
