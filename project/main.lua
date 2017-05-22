local Dir = require "Direction"
local Sprite = require "Sprite"

local sprites = {}
local function add_sprite(name, x, y)
	local sprite = Sprite:new(name, x, y)
	table.insert(sprites, sprite)
	return sprite
end

add_sprite("brick", 5, 10)
add_sprite("human", 8, 6)
add_sprite("grass", 0, 0)


local function draw_all_sprites()
	local TILE_WIDTH = 32
	for sprite, x, y in Sprite:iterAll() do
		love.graphics.draw(sprite:getImage(), x * TILE_WIDTH, y * TILE_WIDTH)
	end
end

function love.draw()
	draw_all_sprites()
end
