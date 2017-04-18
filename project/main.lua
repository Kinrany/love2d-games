local Bump = require "lib/bump"
local bump_world = Bump.newWorld()

local Crate           = require "crate"
local Character       = require "character"
local PlayerCharacter = require "player_character"
local AICharacter     = require "ai_character"
local Crane           = require "crane"


local objects = {}

local function add_object(class, ...)
	local object = class:new(...)
	table.insert(objects, object)
	return object
end


function love.load()
	-- hide mouse
	love.mouse.setVisible(false)
	
	-- create crates along the borders
	local num = 15
	for i = 1, num do
		local x = 10 + (love.graphics.getWidth() - 20 - Crate.width) / (num - 1) * (i - 1)
		local y1 = 10
		local y2 = love.graphics.getHeight() - Crate.height - 10
		add_object(Crate, x, y1, bump_world)
		add_object(Crate, x, y2, bump_world)
	end
	local num = 12
	for i = 2, num-1 do
		local y = 10 + (love.graphics.getHeight() - 20 - Crate.height) / (num - 1) * (i - 1)
		local x1 = 10
		local x2 = love.graphics.getWidth() - Crate.width - 10
		add_object(Crate, x1, y, bump_world)
		add_object(Crate, x2, y, bump_world)
	end
	
	-- create a crane in the middle
	local w, h = love.graphics.getDimensions()
	local x, y = w/2 - Crane.base_width/2, h/2 - Crane.base_height/2
	add_object(Crane, x, y, bump_world)
	
	-- create playe character
	add_object(PlayerCharacter, 200, 200, bump_world)
end

local mouse_debounce = true
function love.update()
	-- lovebird console
	Lovebird.update()
	
	-- update all objects
	__.each(objects, function(object)
		if object.update then
			object:update()
		end
	end)
end

function love.mousepressed(x, y, button)
	
	-- on RMB click create an AI character
	if button == 2 then
		x, y = x - Character.width/2, y
		add_object(AICharacter, x, y, bump_world)
	end
end

function love.draw()
	love.graphics.setBackgroundColor(192, 255, 192)
	
	-- sort objects by Y coordinate
	table.sort(objects, function(a, b) 
		if a.class.name == 'Crane' then
			return false
		elseif b.class.name == 'Crane' then
			return true
		else
			return a.box.bottom < b.box.bottom 
		end
	end)
	-- draw all objects
	__.each(objects, function(object)
		if object.draw then
			object:draw()
		end
	end)
	
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("Objects: " .. #objects, 0, 0)
	love.graphics.print("Mouse: "..love.mouse.getX()..", "..love.mouse.getY(), 0, 12)
end
