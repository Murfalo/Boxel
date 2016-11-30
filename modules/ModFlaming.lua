local ModFlaming = Class.create("ModFlaming", Entity)
local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModFlaming.dependencies = {"ModPartEmitter", "ModActive","ModHitboxMaker"}

ModFlaming.trackFunctions = {"preProcessProjectile"}
ModFlaming.removable = true

function ModFlaming:create()
	self:addEmitter("fire" , "assets/spr/fire.png")
	self:setRandRotation("fire",32,0,1)

	local fire = self.psystems["fire"]
	fire:setDirection(((3*math.pi)/2))
	fire:setSpeed(64)
	fire:setSpread(math.pi/4)
	fire:setParticleLifetime(1, 1);
	self:setAreaSpread("fire","normal",2,2)
	self.timeSinceLastFire = 1
	self:setFade("fire")
	self:addIcon(require("assets.spr.scripts.IcoFlaming"))

end

function ModFlaming:tick(dt)
	self.timeSinceLastFire = self.timeSinceLastFire + dt
	if self.timeSinceLastFire > 0.3 then
		self.timeSinceLastFire = 0 
		self:createHitbox({width = 48, height = 48,xOffset = 0, yOffset = 0, damage = 15, guardDamage = 12,
				stun = 35, persistence = 0.15,xKnockBack = 4 * 32, yKnockBack = -3 * 32, element = "fire"})
		self:emit("fire", 2)
	end
end

function ModFlaming:onRemove()
	self:removeIcon("assets/spr/fire.png")
end


function ModFlaming:preProcessProjectile( projectile )
	projectile.image = "assets.spr.scripts.SprFireShot"
	projectile.element = "fire"
end


return ModFlaming