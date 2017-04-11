_G.Inspect = require('lib/inspect') -- pretty print for tables
_G.Moses = require('lib/moses') -- functional library
_G.Vector2 = require('lib/hump/vector') -- immutable 2D vector library

local Bump = require('lib/bump') -- collision system for rectangles
local world = Bump.newWorld()

local ui = require('user_interface')

local Camera = require('lib/hump/camera') -- camera class for Love2D
local main_camera = nil

local character = require('character')
character.pos.x, character.pos.y = -40, -40

local Bullet = require('bullet')

local Crate = require('crate')
local crates = {
	Crate(), 
	Crate(0, 50), 
	Crate(50, 0), 
	Crate(50, 50)
}

local Turret = require('turret')
local turret = Turret(100, 100)
turret.target = character

function love.load()
	math.randomseed(os.time())
	main_camera = Camera.new()
	
	love.window.setTitle("Sketch 1")
	
	-- add objects to collision system
	local function world_add(t)
		world:add(t, t.x or t.pos.x, t.y or t.pos.y, t.width or t.w, t.height or t.h)
	end
	
	world_add(character)
	Moses.forEach(crates, function(i, crate) world_add(crate) end)
	world_add(turret)
	Bullet:load(world)
end

function love.update()
	character:update(world)
	main_camera:lookAt(character.pos.x, character.pos.y)
	
	turret:update()
	Bullet:update(world)
	
	ui:update()
end

function love.draw() 
	
	-- start drawing using camera position
	main_camera:attach()
	
	-- draw world
	Moses.forEach(crates, function(_, crate) crate:draw() end)
	character:draw()
	turret:draw()
	Bullet:draw()
	
	-- stop drawing using camera position
	main_camera:detach()
	
	-- draw UI
	ui:draw()
end
