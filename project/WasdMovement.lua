local WasdMovement = {}

function WasdMovement.initWasdMovement(self, speed)
	self.speed = assert(speed)
end

function WasdMovement.updateWasdMovement(self, dt)
	local isDown = love.keyboard.isDown
	local dist = self.speed * dt
	
	if isDown("up") or isDown("w") then
		self.y = self.y - dist
	end
	if isDown("down") or isDown("s") then
		self.y = self.y + dist
	end
	if isDown("left") or isDown("a") then
		self.x = self.x - dist
	end
	if isDown("right") or isDown("d") then
		self.x = self.x + dist
	end
end

return WasdMovement
