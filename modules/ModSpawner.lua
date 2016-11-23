local ModSpawner = Class.create("ModSpawner", Entity)

function ModSpawner:init( x,y,object,minSpawntime,maxSpawntime, lifeTime, minX, maxX, minY, maxY)
	self.x = x
	self.y = y
	self.object = object
	self.minSpawntime = minSpawntime
	self.maxSpawntime = maxSpawntime
	self.lifeTime = lifeTime
	self.minX = minX
	self.maxX = maxX
	self.minY = minY
	self.maxY = maxY
end

function ModSpawner:create()
	self.timer = 0
	self.minSpawnTime = self.minSpawntime or 15
	self.maxSpawnTime = self.maxSpawntime or self.minSpawnTime or 60
	self.minX = tonumber(self.minX) or 0
	self.maxX = tonumber(self.maxX) or 0
	self.minY = tonumber(self.minY) or 0
	self.maxY = tonumber(self.maxY) or 0
end

function ModSpawner:tick(dt)
	self.timer = self.timer + 1

	if self.isActive and self.minSpawnTime then
		if not self.spawnTime or self.timer == 0 then
			self.spawnTime = math.random(self.minSpawnTime, self.maxSpawnTime)
		end
		if self.timer > self.spawnTime then
			self:spawnObject()
		end
	end
	if self.lifeTime then
		self.lifeTime = self.lifeTime - 1
		if self.lifeTime == 0 then
			Game:del(self)
		end
	end
end

function ModSpawner:spawnObject(x,y)
	local x = x or self.x + math.random(self.minX,self.maxX)
	local y = y or self.y + math.random(self.minY, self.maxY)
	if self.object then
		local objectName = self.object
		local newObj = util.create("objects/".. objectName, x, y)
		Game:add(newObj)
	end
	self.timer = 0
end

function ModSpawner:setSpawnRange( minX, maxX, minY, maxY )
	self.minX = minX
	self.maxX = maxX
	self.minY = minY
	self.maxY = maxY
end

function ModSpawner:setActive( isActive )
	self.isActive = isActive
end
function ModSpawner:setSpawnRate( min, max )
	self.minSpawnTime = min or 15
	self.maxSpawnTime = max or min or 60
end
return ModSpawner