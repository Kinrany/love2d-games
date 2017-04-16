local directions = {"up", "down", "left", "right"}

local prototype = {}

function prototype.get_input(self)
	self.direction = directions[os.time() % 4 + 1]
	
	local input = {}
	
	input[self.direction] = true
	
	return input
end



local PlayerBrain = {}

function PlayerBrain.new() 
	return setmetatable({direction = "up"}, {__index = prototype})
end

return PlayerBrain
