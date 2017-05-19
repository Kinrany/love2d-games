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

function TurfContainer.draw()
	for x, v in pairs(turfs) do
		for y, turf in pairs(v) do
			turf.image:draw(x * 32, y * 32)
		end
	end
end

return TurfContainer
