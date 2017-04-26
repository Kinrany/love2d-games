--[[

-- example:

local TwoMap = require "twomap"

local names_jobs = TwoMap("name", "job")

-- TwoMap.Item1
names_jobs.name["Martha"] = "Director"

print(11, names_jobs.name["Martha"])             --> "Director"
print(12, names_jobs.job["Director"])            --> "Martha"

-- TwoMap.Item2
names_jobs.job["Accountant"] = "Ashley"

print(21, names_jobs.name["Ashley"])             --> "Accountant"
print(22, names_jobs.job["Accountant"])          --> "Ashley"

names_jobs.job["Director"] = "Catherine"

print(31, names_jobs.name["Martha"])             --> nil
print(32, names_jobs.name["Catherine"])          --> "Director"
print(33, names_jobs.job["Director"])            --> "Catherine"

-- TwoMap:add
names_jobs:add("job", "Director", "Mike")

print(41, names_jobs.name["Catherine"])          --> "Director"
print(42, names_jobs.name["Mike"])               --> "Director"
print(43, names_jobs.job["Director"])            --> "Catherine"

-- TwoMap:get
names_jobs:get("job", "Director")                
--> {"Catherine", "Mike"}

-- TwoMap:remove
names_jobs:remove("name", "Catherine", "Director")

print(51, names_jobs.name["Catherine"])          --> nil
print(52, names_jobs.job["Director"])            --> "Mike"
print(53, names_jobs:get("job", "Director"))     --> {"Mike"}

--]]

local TwoMap = Class('TwoMap')

function TwoMap.initialize(self, name1, name2)
	name1 = name1 or "name1"
	name2 = name2 or "name2"
	
	-- tables t[key1][key2]
	-- return true when twomap contains pair (key1, key2)
	local t1, t2 = {}, {}
	
	local function __index(tx) 
		return function(_, key)
			-- return first element
			return tx[key] and next(tx[key])
		end
	end
	
	local function __newindex(id)
		return function(_, key, value)
			self:set(id, key, value)
		end
	end
	
	local function make_mt(tx, id)
		return {
			__index = __index(tx),
			__newindex = __newindex(id)
		}
	end
	
	local mt1 = make_mt(t1, 1)
	local mt2 = make_mt(t2, 2)
	
	self._name1 = name1
	self._name2 = name2
	self._t = {t1, t2}
	self[1] = setmetatable({}, mt1)
	self[2] = setmetatable({}, mt2)
	self[name1] = self[1]
	self[name2] = self[2]
end

local function index_to_number(twomap, index)
	if type(index) == "number" then
		return index
	elseif type(index) == "string" then
		if index == twomap._name1 then
			return 1
		elseif index == twomap._name2 then
			return 2
		else
			error("Unknown index name: "..index)
		end
	else
		error("Index must be either number or string")
	end
end

function TwoMap.get(self, index, key)
	local id = index_to_number(self, index)
	local my_values_table = self._t[id][key]
	
	if not my_values_table then
		return {}
	end
	
	local values = {}
	for value, _ in pairs(my_values_table) do
		table.insert(values, value)
	end
	
	return values
end

function TwoMap.set(self, index, key, value)
	local id = index_to_number(self, index)
	local other_id = 3 - id
	local t = self._t
	
	if t[id][key] then -- erase old values from twomap
		for v, _ in pairs(t[id][key]) do
			t[other_id][v][key] = nil
		end
	end
	t[id][key] = {}
	
	self:add(id, key, value)
end

function TwoMap.add(self, index, key, value)
	local id = index_to_number(self, index)
	local other_id = 3 - id
	local t = self._t
	
	if not t[id][key] then
		t[id][key] = {[value] = true}
	else
		t[id][key][value] = true
	end
	
	if not t[other_id][value] then
		t[other_id][value] = {[key] = true}
	else
		t[other_id][value][key] = true
	end
end

function TwoMap.remove(self, index, key, value)
	local id = index_to_number(self, index)
	local other_id = 3 - id
	local t = self._t
	
	t[id][key][value] = nil
	t[other_id][value][key] = nil
end

function TwoMap.iterator(self, index)
	local id = index_to_number(self, index)
	local t = self._t[id]
	
	return coroutine.wrap(function()
		for key, values in pairs(t) do
			for value, _ in pairs(values) do
				coroutine.yield(key, value)
			end
		end
	end)
end

return TwoMap
