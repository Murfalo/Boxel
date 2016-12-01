local ModBomb = Class.create("ModBomb", Entity)
local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
local bombSound = love.audio.newSource("assets/sounds/Bomb.wav")
ModBomb.dependencies = {"ModPartEmitter", "ModActive","ModHitboxMaker","ModInteractive","ModShooter"}

ModBomb.trackFunctions = {"onAttack"}
ModBomb.removable = true

function ModBomb:create()
	self:addEmitter("fire" , "assets/spr/fire.png")
	self:setRandomDirection("fire" , 3 * 32)
	self:setRandRotation("fire",32,0,1)
	local fire = self.psystems["fire"]
	fire:setParticleLifetime(1, 2);
	self:setAreaSpread("fire","normal",8,8)
	self.bombCoolDown = 0
	self:setFade("fire")
	self:addIcon(require("assets.spr.scripts.IcoBomb"))
end

function ModBomb:tick( dt )
	self.bombCoolDown = self.bombCoolDown - dt
	if self.toExplode then
		self:explode()
		self.toExplode = false
	end
end
function ModBomb:setHitState(stunTime, forceX, forceY, damage, element,faction,hitbox)
	if element == "fire" and self.bombCoolDown <= 0 then
		self.bombCoolDown = 2.0
		self.toExplode = true
	end
end

function ModBomb:explode()
	self:createHitbox({radius = 50,xOffset = 0, yOffset = 0, damage = 40, guardDamage = 12,
	stun = 35, persistence = 0.35,xKnockBack = 3 * 32, yKnockBack = -12 * 32, element = "fire",faction="none"})
	self:setHitState(2, 0, -8 * 32, 40, "fire",nil,40)
	self:emit("fire",8)
end
function ModBomb:destroy()
	bombSound:play()
	local newEmitter = ObjSimpleEmitter(self.x,self.y)
	Game:add(newEmitter)
	newEmitter:setDestroyAfterEmpty(true)
	newEmitter:addEmitter("fire" , "assets/spr/fire.png")
	newEmitter:setRandomDirection("fire" , 3 * 32)
	newEmitter:setRandRotation("fire",32,0,1)
	local fire = newEmitter.psystems["fire"]
	fire:setParticleLifetime(1, 2);
	newEmitter:setFade("fire")
	newEmitter:emit("fire",16)
end

function ModBomb:onPlayerInteract(player) 
	self:explode()
end

function ModBomb:onRemove()
	self:removeIcon("assets/spr/warning.png")
end

function ModBomb:preProcessProjectile( projectile )
	projectile.image = "assets.spr.scripts.SprBombShot"
end

function ModBomb:postProcessProjectile( projectile )
	local function boom(proj,target,hitType,hitbox)
		if Class.istype(target,"ObjBase") and target:hasModule("ModActive") and not target:hasModule("ModFruity") then
			target:setHealth(target.health- 10)
			target:emit("fire",8)
			target.body:setLinearVelocity(self.velX,-12*32)
			if target.createHitbox then
				target:createHitbox({radius = 48,xOffset = 0, yOffset = 0, damage = 40, guardDamage = 12,
					stun = 35, persistence = 0.35,xKnockBack = 3 * 32, yKnockBack = -12 * 32, element = "fire",faction="none"})
			end
			bombSound:play()

		end
	end
	projectile:addOnHitFunction(boom)
end

return ModBomb