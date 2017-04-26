local Axons = {}

local axons = {}

local function get_id(organ, axon_name)
	local id = #axons
	axons[id] = {organ=organ, name=axon_name}
	return id
end
Axons.get_id = Memoize(get_id)

function Axons.get_axon(id)
	return axons[id].organ, axons[id].name
end

return Axons
