local TileDrawer = {}

TileDrawer.tile_size = 40

function TileDrawer.gridToWorld(grid_pos)
	return grid_pos * TileDrawer.tile_size
end

function TileDrawer.draw(tile, grid_pos)
	local x, y = TileDrawer.gridToWorld(grid_pos):unpack()
	local tile_size = TileDrawer.tile_size
	
	
	love.graphics.setColor(128, 128, 128)
	love.graphics.rectangle("fill", x, y, tile_size, tile_size)
	
	
	love.graphics.setColor(116, 88, 62)
	love.graphics.setLineWidth(3)
	
	local half = tile_size/2
	local x0, y0 = x + half, y + half
	if tile.up then
		local x1, y1 = x0, y0 - half
		love.graphics.line(x0, y0, x1, y1)
	end
	if tile.down then
		local x1, y1 = x0, y0 + half
		love.graphics.line(x0, y0, x1, y1)
	end
	if tile.left then
		local x1, y1 = x0 - half, y0
		love.graphics.line(x0, y0, x1, y1)
	end
	if tile.right then
		local x1, y1 = x0 + half, y0
		love.graphics.line(x0, y0, x1, y1)
	end
	
	
	if (tile.up or tile.down or tile.left or tile.right) then
		love.graphics.circle("fill", x0, y0, 5)
	end
end



return TileDrawer
