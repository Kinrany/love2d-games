local DrawHeadRectangle = {}

function DrawHeadRectangle.initDrawHeadRectangle(self, headWidth, headHeight, headColor)
	self.headWidth = assert(headWidth)
	self.headHeight = assert(headHeight)
	self.headColor = assert(headColor)
end

function DrawHeadRectangle.drawHeadRectangle(self)
	love.graphics.setColor(self.headColor:unpack())
	love.graphics.rectangle("fill", self.x - self.headWidth/2, self.y - self.headHeight - self.bodyHeight, self.headWidth, self.headHeight)
end

return DrawHeadRectangle
