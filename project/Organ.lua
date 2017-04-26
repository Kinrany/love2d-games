local TwoMap = require "lib/tools/twomap"
local Axons = require "Axons"


local Organ = Class('Organ')

-- connections between axons
-- stored as axon ids
Organ.static._connections = TwoMap("host", "listener")

-- fired axons
-- key   == axon id
-- value == data
Organ.static._fired = {}

function Organ.static._add_fired(host_axon_id, data)
	Organ.fired[host_axon_id] = data
end

function Organ.static.process_fired()
	
	-- replace static Organ._fired with empty table
	local fired;
	fired, Organ._fired = Organ._fired, {}
	
	for host_axon_id, data in pairs(fired) do
		-- stimulate every listening axon
		local listeners = connections:get("host", host_axon_id)
		__.each(listeners, function(listener_axon_id)
			local organ, axon_name = Axons.get_axon(listener_axon_id)
			organ:stimulate(axon_name, data)
		end)
	end
end

function Organ.static.connect(organ, axon, host, host_axon)
	-- add connection to twomap
	-- using axon ids
	local listener_id = Axons.get_id(organ, axon)
	local host_id = Axons.get_id(host, host_axon)
	Organ._connections:add("host", host_id, listener_id)
end

-- removes one or all connections
function Organ.static.disconnect(organ, axon, host, host_axon)
	assert(organ)
	assert(axon)
	
	if host and host_axon then
		-- remove one connection
		
		local listener_id = Axons.get_id(organ, axon)
		local host_id = Axons.get_id(host, host_axon)
		Organ._connections:remove("host", host_id, listener_id)
	else
		-- remove all connections
		
		local id = Axons.get_id(organ, axon)
		local connections = Organ._connections
		
		local function remove_all(index_name)
			__(connections:get(index_name, id)):chain()
				:flatten()
				:each(function(id2)
					connections:remove(index_name, id, id2)
				end)
		end
		remove_all("host")
		remove_all("listener")
	end
end

function Organ.initialize(self, stimulation_handlers)
	self._stimulation_handlers = assert(stimulation_handlers)
end

function Organ.stimulate(self, axon_name, data)
	self._stimulation_handlers[axon_name](data, self.fire)
end

function Organ.fire(self, axon_name, data)
	local axon_id = Axons.get_id(self, axon_name)
	Organ._add_fired(axon_id, data)
end

-- example stimulation handler
function Organ.static.propagate_handler(data, fire)
	fire("print", data)
end

return Organ