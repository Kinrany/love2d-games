local Axons = {}

local axons = {}

local function get_id(organ, axon_name)
	table.insert(axons, {organ=organ, name=axon_name})
	return #axons
end
Axons.get_id = Memoize(get_id)

function Axons.get_axon(id)
	return axons[id].organ, axons[id].name
end

return Axons
