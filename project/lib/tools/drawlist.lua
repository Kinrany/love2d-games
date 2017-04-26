local list = {}

list.items = {}

function list.add(item)
	list.items[item] = true
end

function list.remove(item)
	list.items[item] = nil
end

function list.draw()
	for item, _ in pairs(list.items) do
		local status, err;
		if type(item) == "function" then
			local status, err = pcall(item)
		elseif type(item) == "table" and type(item.draw) == "function" then
			local status, err = pcall(item.draw, item)
		end
		
		if status == false then
			list.items[item] = nil
			print("Drawing failed: "..tostring(err))
		end
	end
end

function __newindex()
	error("Use drawlist.add() instead.")
end

return setmetatable(list, {__newindex = __newindex})
