local character = {
	name = "Character",
	pos = Vector2.new(0, 0),
	width = 30,
	height = 30,
	speed = 10,
	organs = {}
}
	
function character.draw(self)
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
	
	for key, organ in pairs(self.organs) do
		if (organ.draw) then
			organ:draw()
		end
	end
	
end

function character.update(self, world)
	if (love.keyboard.isDown("w") or love.keyboard.isDown("up")) then
		self:move(0, -10, world)
	end
	if (love.keyboard.isDown("s") or love.keyboard.isDown("down")) then
		self:move(0, 10, world)
	end
	if (love.keyboard.isDown("a") or love.keyboard.isDown("left")) then
		self:move(-10, 0, world)
	end
	if (love.keyboard.isDown("d") or love.keyboard.isDown("right")) then
		self:move(10, 0, world)
	end
	
	for key, organ in pairs(self.organs) do
		if (organ.update) then
			organ:update()
		end
	end
	
end

function character.move(self, dx, dy, world)
	if (world) then
		local goal = self.pos + (Vector2.new(dx, dy):normalized() * self.speed)
		local goalX, goalY = goal:unpack()
		local actualX, actualY, cols, len = world:move(self, goalX, goalY)
		
		self.pos = Vector2.new(actualX, actualY)
		
		Moses.forEach(cols, function(i, col)
			character:collision(col.other, col)
		end)
	else
		self.pos.x = self.pos.x + dx
		self.pos.y = self.pos.y + dy
	end
end

function character.collision(self, other, collision)
	print(self.name.." collided with "..(other.name or "something"))
	if other.name == "Bullet" then
		self:take_damage(other)
	end
end

function character.take_damage(self, bullet)
	print(self.name.." got hit by "..bullet.name)
end

function character.add_organ(self, organ)
	table.insert(self.organs, organ)
	organ.character = self
end

function character.remove_organ(self, key)
	local organ = self.organs[key]
	if (type(key) == number) then
		table.remove(self.organs, key)
	else
		self.organs[key] = nil
	end
	organ.character = nil
end

return character