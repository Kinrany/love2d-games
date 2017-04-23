local DrawBodyRectangle = {}

function DrawBodyRectangle.initDrawBodyRectangle(self, bodyWidth, bodyHeight, bodyColor)
	self.bodyWidth = assert(bodyWidth)
	self.bodyHeight = assert(bodyHeight)
	self.bodyColor = assert(bodyColor)
end

function DrawBodyRectangle.drawBodyRectangle(self)
	love.graphics.setColor(self.bodyColor:unpack())
	love.graphics.rectangle("fill", self.x - self.bodyWidth/2, self.y - self.bodyHeight, self.bodyWidth, self.bodyHeight)
end

return DrawBodyRectangle
