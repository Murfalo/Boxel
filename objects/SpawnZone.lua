local ObjBaseUnit = require "objects.ObjBase"
local ObjTest = Class.create("ObjTest", ObjBase)
	
function ObjTest:create()
	self:addModule(require "modules.ModSpawner")
	self:setObject("ObjEnemy")
	self:setSpawnRate(10,20)
end

return ObjTest
