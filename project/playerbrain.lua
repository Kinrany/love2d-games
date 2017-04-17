local function string_to_char_table(str)
	local t = {}
	str:gsub(".", function(char) table.insert(t, char) end)
	return t
end
string_to_char_table = Memoize(string_to_char_table)

local function check_keys(keys, output_table)
	if type(keys) == "string" then
		keys = string_to_char_table(keys)
	end
	
	local isDown = love.keyboard.isDown
	
	__.for_each(keys, function(key)
		if isDown(key) then
			output_table[key] = true
		end
	end)
end


local prototype = {}

function prototype.get_input(self)
	local input = {}
	
	check_keys("abcdefghijklmnopqrstuvwxyz", input)
	check_keys("0123456789", input)
	check_keys({"up", "down", "left", "right"}, input)
	
	return input
end



local PlayerBrain = {}

function PlayerBrain.new() 
	return setmetatable({}, {__index = prototype})
end

return PlayerBrain
