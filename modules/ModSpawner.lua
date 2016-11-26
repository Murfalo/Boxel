local ModSpawner = Class.create("ModSpawner", Entity)

ModSpawner.trackFunctions = {"spawnObject"}
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
	self.minSpawnTime = self.minSpawntime or 0.15
	self.maxSpawnTime = self.maxSpawntime or self.minSpawnTime or 1
	self.minX = tonumber(self.minX) or 0
	self.maxX = tonumber(self.maxX) or 0
	self.minY = tonumber(self.minY) or 0
	self.maxY = tonumber(self.maxY) or 0
	self:setActive(false)
end

function ModSpawner:tick(dt)
	self.timer = self.timer - dt
	if self.isActive and self.minSpawnTime then
		if not self.spawnTime or self.timer <= 0 then
			self.spawnTime = math.random(self.minSpawnTime, self.maxSpawnTime)
		end
		if self.timer <= 0 then
			self:spawnObject()
			self.timer = self.spawnTime
		end
	end
	if self.lifeTime then
		self.lifeTime = self.lifeTime - dt
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
		if type(self.object) =="table" then
			objectName = self.object[math.random(1,#self.object)]
		end
		local newObj = util.create("objects/".. objectName, x, y)
		Game:add(newObj)
		if newObj:hasModule("ModPhysics") then
			newObj:setPosition(x,y)
		end
	end
	self.timer = 0
end

function ModSpawner:setObject(objType)
	self.object = objType
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
	self.minSpawnTime = min or 0.25
	self.maxSpawnTime = max or min or 1
end
return ModSpawner