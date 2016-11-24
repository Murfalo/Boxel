local ObjBase = require "ObjBase"
local ObjGameInterface = Class.create("ObjGameInterface", ObjBase)
	
function ObjGameInterface:create()
	self:setSpawnRate(5,5)
end

return ObjGameInterface
