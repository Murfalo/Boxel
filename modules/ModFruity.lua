local ModFruity = Class.create("ModFruity", Entity)
local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModFruity.dependencies = {"ModPartEmitter", "ModActive","ModShooter"}

ModFruity.trackFunctions = {"preProcessProjectile"}
ModFruity.removable = true

function ModFruity:create()
	self:addIcon(require("assets.spr.scripts.IcoFruity"))
end

function ModFruity:onRemove()
	self:removeIcon("assets/spr/mmmm.png")
end


function ModFruity:preProcessProjectile( projectile )
	projectile.image = "assets.spr.scripts.IcoFruity"
	projectile.element = "hit"
	projectile.damage = 0
	projectile.stun = 0
	projectile.speed = 3 * 32
	projectile.range = 100
end

function ModFruity:postProcessProjectile( projectile )
	local function fruiten(self,target,hitType,hitbox)
		if Class.istype(target,"ObjBase") and target:hasModule("ModActive") and not target:hasModule("ModFruity") then
			target:setHealth(target.health + 20)
		end
	end
	projectile:addOnHitFunction(fruiten)
end

return ModFruity