local TileDrawer = require('tiledrawer')

local character = {
	grid_pos = Vector2(0, 0),
	draw_radius = 10
}

function character.get_pos(self)
	local pos = TileDrawer.gridToWorld(self.grid_pos)
	local tile_size = TileDrawer.tile_size
	return pos + Vector2(tile_size/2, tile_size/2)
end

local movement_cooldown = 0
function character.update(self)
	if movement_cooldown <= 0 then
		local isDown = love.keyboard.isDown
		
		local dxdy = Vector2(0, 0)
		if (isDown("up")    or isDown("w")) then
			dxdy = dxdy + Vector2( 0, -1)
		end
		if (isDown("down")  or isDown("s")) then
			dxdy = dxdy + Vector2( 0,  1)
		end
		if (isDown("left")  or isDown("a")) then
			dxdy = dxdy + Vector2(-1,  0)
		end
		if (isDown("right") or isDown("d")) then
			dxdy = dxdy + Vector2( 1,  0)
		end
		
		if (dxdy:len2() ~= 0) then
			self.grid_pos = self.grid_pos + dxdy
			movement_cooldown = 3
		end
	else
		movement_cooldown = movement_cooldown - 1
	end
end

function character.draw(self)
	local x, y = self:get_pos():unpack()
	love.graphics.setColor(0, 0, 255)
	love.graphics.circle("fill", x, y, self.draw_radius)
end

return character


