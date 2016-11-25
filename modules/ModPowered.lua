local ModPowered = Class.create("ModPowered", Entity)
local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModPowered.dependencies = {"ModActive","ModInteractable","ModHitboxMaker"}

ModPowered.trackFunctions = {}
ModPowered.removable = true

function ModPowered:setHitState(stunTime, forceX, forceY, damage, element,faction,hitbox)
	if element == "electric" then
		if hitbox and hitbox.attacker then
			self:onPlayerInteract( hitbox.attacker )
		end
	end
end

return ModPowered