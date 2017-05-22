local Dir = require "Direction"
local Sprite = require "Sprite"
local Tile = require "Tile"



local entities = {}
local function add_entity(entity)
	table.insert(entities, entity)
	return entity
end

for x = 0, 20 do
	for y = 0, 15 do
		local tile_name;
		if love.math.random(1, 5) <= 2 then
			tile_name = "stone"
		else
			tile_name = "grass"
		end
		add_entity(Tile:new(tile_name, x, y))
	end
end

local brick_sprite = add_entity(Sprite:new("brick", 5, 10))
local human_sprite = add_entity(Sprite:new("human", 8,  6))

function love.keypressed(key, scancode, isrepeat)
	if key == "left" then
		human_sprite:turn(Dir.left)
	end
	if key == "right" then
		human_sprite:turn(Dir.right)
	end
	if key == "up" then
		human_sprite:moveRelative(Dir.front)
	end
	if key == "down" then
		human_sprite:turn(Dir.back)
	end
end

local function draw_all_sprites()
	local TILE_WIDTH = 32
	for sprite, x, y in Sprite:iterAll() do
		local image = sprite:getImage()
		local screen_x = x * TILE_WIDTH
		local screen_y = y * TILE_WIDTH
		love.graphics.draw(image, screen_x, screen_y)
		
		-- hack for drawing player above other sprites
		local hX, hY = human_sprite:getPos()
		if x == hX and y == hY then
			local image = human_sprite:getImage()
			love.graphics.draw(image, screen_x, screen_y)
		end
	end
end

function love.draw()
	love.graphics.setBackgroundColor(64, 128, 64)
	draw_all_sprites()
end
