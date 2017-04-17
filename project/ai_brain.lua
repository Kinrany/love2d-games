local AIBrain = Class('AIBrain')

local directions = {"up", "down", "left", "right"}
	
function AIBrain.initialize(self)
	self.direction_id = 1
	self.direction_offset = os.time() % 4
end

function AIBrain.get_commands(self)
	
	local num = (os.time() * 131071 + 524287) % 100
	if num < 40 then
		self.direction_id = (num + self.direction_offset) % 4 + 1
	end
	
	local commands = {}
	commands[directions[self.direction_id]] = true
	return commands
end

return AIBrain
