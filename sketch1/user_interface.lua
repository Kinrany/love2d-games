local ui = {
	name = "User Interface",
	colors = {r=128, g=128, b=128}
}

function ui.update(self)
	-- shift ui colors randomly
	local colors = self.colors
	
	for k, v in pairs(colors) do
		colors[k] = colors[k] + math.random(-10, 10)
		if colors[k] < 0 then
			colors[k] = 0
		elseif colors[k] > 255 then
			colors[k] = 255
		end
	end
end

function ui.draw(self)
	love.graphics.setColor(self.colors.r, self.colors.g, self.colors.b)
	love.graphics.setLineWidth(16)
	love.graphics.rectangle("line", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

return ui