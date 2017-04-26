local list = {}

list.items = {}

function list.add(item)
	list.items[item] = true
end

function list.remove(item)
	list.items[item] = nil
end

function list.update(dt)
	for item, _ in pairs(list.items) do
		local status, err;
		if type(item) == "function" then
			local status, err = pcall(item, dt)
		elseif type(item) == "table" and type(item.update) == "function" then
			local status, err = pcall(item.update, item, dt)
		end
		
		if status == false then
			list.items[item] = nil
			print("Update failed: "..err)
		end
	end
end

function __newindex()
	error("Use updatelist.add() instead.")
end

return setmetatable(list, {__newindex = __newindex})
