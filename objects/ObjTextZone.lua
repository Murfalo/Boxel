local ObjBase = require "ObjBase"
local ObjTextZone = Class.create("ObjTextZone", ObjBase)
	
function ObjTextZone:create()
	-- local active = require "modules.ModActive"
	-- self:addModule(active)
	local textZone = require "modules.ModTextZone"
	self:addModule(textZone)
end

return ObjTextZone
