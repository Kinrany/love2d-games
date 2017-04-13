_G.Inspect = require('lib/inspect')
_G.Memoize = require('lib/memoize')
_G.Moses = require('lib/moses')
_G.Vector2 = require('lib/hump/vector')


local character = require('character')

local Camera = require('lib/hump/camera')
local camera = Camera.new(character:get_pos():unpack())

local TileContainer = require('tilecontainer')


local function show_nearby_tiles()
	local initial_radius = 4
	local x0, y0 = character.grid_pos:unpack()
	for x = x0-initial_radius, x0+initial_radius do
		for y = y0-initial_radius, y0+initial_radius do
			if TileContainer.get(x,y) == nil then
				TileContainer.add(x, y)
			end
		end
	end
end


function love.load()
	love.window.setTitle("Map generator")
	
	show_nearby_tiles()
end

function love.update()
	character:update()
	
	camera:lookAt(character:get_pos():unpack())
	
	if love.keyboard.isDown("r") then
		TileContainer.reset_all()
	end
	if love.keyboard.isDown("f") then
		show_nearby_tiles()
	end
	
	local x0, y0 = character.grid_pos:unpack()
	for x = x0-1, x0+1 do
		for y = y0-1, y0+1 do
			local tile = TileContainer.get(x, y)
			if tile == nil then
				TileContainer.add(x, y)
			end
		end
	end
end

function love.draw()
	camera:attach()
	love.graphics.setBackgroundColor(192, 192, 255)
	
	TileContainer.draw()

	character:draw()
	
	camera:detach()
	
	
	-- console output
	
	love.graphics.setColor(0, 0, 0)
	local offset = 0
	local function writeline(str)
		if str then
			love.graphics.print(str, 0, offset)
		end
		offset = offset + 12
	end
	
	writeline("Tile count: "..TileContainer.count())
	
	local x, y = character.grid_pos:unpack()
	writeline("Character position: "..x..", "..y)
	
	writeline("Current FPS: "..love.timer.getFPS())
	
	writeline()
	
	writeline("Press R to reset all tiles")
	
	writeline("Press F to show all nearby tiles")
end

