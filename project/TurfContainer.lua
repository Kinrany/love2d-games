local TurfContainer = {}

local turfs = {}

function TurfContainer.set(x, y, turf)
	if turfs[x] == nil then
		turfs[x] = {}
	end
	turfs[x][y] = turf
end

function TurfContainer.get(x, y)
	return turfs[x][y]
end

function TurfContainer.loadMap(map) 
	local turfCodes = map.turfCodes
	
	for x = 1, #map do
		for y = 1, #(map[x]) do
			local turfCode = map[x][y]
			local turfClass = turfCodes[turfCode]
			TurfContainer.set(x-1, y-1, turfClass(x-1, y-1))
		end
	end
end

function TurfContainer.addToECS(world)
	for x, v in pairs(turfs) do
		for y, turf in pairs(v) do
			world:addEntity(turf)
		end
	end
end

--[[ TODO:
         create iterator over all turfs
         rewrite loadMap and addToECS using iterator
--]]

return TurfContainer
