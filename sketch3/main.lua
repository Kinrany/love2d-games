_G.Inspect = require "lib/inspect"
_G.Memoize = require "lib/memoize"
_G.__      = require "lib/underscore"

Bump = require "lib/bump"
bump_world = Bump.newWorld()

local Character = require "character"
local PlayerBrain  = require "playerbrain"
local player = Character.new(bump_world)
player.brain = PlayerBrain.new()

local AIBrain = require "aibrain"
local ai = Character.new()
ai.x = 200
ai.y = 100
ai.color = {192, 64, 64}
ai:set_bump_world(bump_world)
ai.brain = AIBrain.new()

Camera = require "lib/hump/camera"
camera = Camera.new()

function love.load()
	
end

function love.update()
	player:update()
	ai:update()
	
	camera:lookAt(player.sprite:get_center())
end


function love.draw()
	love.graphics.setBackgroundColor(255, 255, 255)
	camera:attach()
	
	love.graphics.setColor(128, 64, 192)
	love.graphics.rectangle("line", 0, 0, 100, 100)
	
	player:draw()
	ai:draw()
	
	camera:detach()
	
	-- console
	local offset = 0
	local function write_line(text)
		love.graphics.setColor(0, 0, 0)
		love.graphics.print(Inspect(text), 0, offset)
		offset = offset + 12
	end
	
	write_line("Player:")
	write_line{player.sprite:get_xywh()}
	write_line{player.brain:get_input()}
	write_line("AI:")
	write_line{ai.sprite:get_xywh()}
	write_line{ai.brain:get_input()}
end







