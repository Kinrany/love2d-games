_G.Inspect = require "lib/inspect"
_G.Memoize = require "lib/memoize"
_G.__      = require "lib/underscore"

Bump = require "lib/bump"
bump_world = Bump.newWorld()

local Player = require "player"
local player = Player.new(bump_world)

local Brain  = require "brain"
player.brain = Brain.new()

Camera = require "lib/hump/camera"
camera = Camera.new()

function love.load()
	
end

function love.update()
	player:update()
	
	camera:lookAt(player.sprite:get_center())
end


function love.draw()
	love.graphics.setBackgroundColor(255, 255, 255)
	
	camera:attach()
	
	love.graphics.setColor(128, 64, 192)
	love.graphics.rectangle("line", 0, 0, 100, 100)
	
	player:draw()
	
	camera:detach()
	
	-- console
	local offset = 0
	local function write_line(text)
		love.graphics.setColor(0, 0, 0)
		love.graphics.print(Inspect(text), 0, offset)
		offset = offset + 12
	end
	
	write_line{player.sprite:get_xywh()}
end







