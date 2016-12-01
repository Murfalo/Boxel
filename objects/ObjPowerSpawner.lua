local ObjBase = require "ObjBase"
local ObjPowerSpawner = Class.create("ObjPowerSpawner", ObjBase)
local ModSpawner = require "modules.ModSpawner"
	
function ObjPowerSpawner:create()
	self:addModule(ModSpawner)
	self:setObject({"ObjPowerup"})
	-- lume.trace("Spawner created")
	self:setSpawnRate(30,40)
	--self:setActive(false)
	--ModFlaming
end

return ObjPowerSpawner
