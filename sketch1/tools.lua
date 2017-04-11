local tools = {}

--  unpacks all arguments
--  usage: print(munpack("a", {"b", "c"}, "d", {{"e"}}, f)) => a b c d table: 0x2b3b8c5cccc0 f
function tools.munpack(...)
	local args = {...}
	local result = {}
	for i, t in ipairs(args) do
		if (type(t) == "table") then
			for _, v in ipairs(t) do
				table.insert(result, v)
			end
		else
			table.insert(result, t)
		end
	end
	return table.unpack(result)
end

local private = setmetatable({}, {__mode="k"})
function tools.getprivate(t, key)
	local private_table = private[t]
	return private_table and private_table[key]
end
function tools.setprivate(t, key, value)
	if (not private[t]) then
		private[t] = {}
	end
	private[t][key] = value
end

return tools