local ObjBaseUnit = require "objects.ObjBase"
local ObjTest = Class.create("ObjTest", ObjBase)
	
function ObjTest:create()
	self:addModule(require "modules.ModSpawner")
	self:setObject("ObjEnemy")
end

return ObjTest
