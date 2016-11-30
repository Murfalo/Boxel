local ObjBase = require "ObjBase"
local ObjSpawnZone = Class.create("ObjSpawnZone", ObjBase)
local ModSpawner = require "modules.ModSpawner"
	
function ObjSpawnZone:create()
	self:addModule(ModSpawner)
	self:setObject({"EnSword","EnShooter","EnTorch"})
	-- lume.trace("Spawner created")
	self:setSpawnRate(4,20)
	self.modifiers = {
		{"ModDuplicator",0.03},
		{"ModFlaming",0.03},
		{"ModPlant",0.02},
		{"ModBomb",0.04},
		{"ModSuperHeavy",0.03},
		{"ModVampiric",1}
	}
	--ModFlaming
end

return ObjSpawnZone
