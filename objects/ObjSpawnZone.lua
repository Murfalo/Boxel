local ObjBase = require "ObjBase"
local ObjSpawnZone = Class.create("ObjSpawnZone", ObjBase)
local ModSpawner = require "modules.ModSpawner"
	
function ObjSpawnZone:create()
	self:addModule(ModSpawner)
	self:setObject({"ObjEnemy","ObjEnemyShooter"})
	self:setSpawnRate(5,5)
end

return ObjSpawnZone
