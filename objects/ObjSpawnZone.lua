local ObjBase = require "ObjBase"
local ObjSpawnZone = Class.create("ObjSpawnZone", ObjBase)
local ModSpawner = require "modules.ModSpawner"
	
function ObjSpawnZone:create()
	self:addModule(ModSpawner)
	self:setObject({"EnSword","EnShooter","EnTorch"})
	-- lume.trace("Spawner created")
	self:setSpawnRate(15,20)
end

return ObjSpawnZone
