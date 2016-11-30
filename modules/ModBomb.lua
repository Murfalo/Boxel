local ModBomb = Class.create("ModBomb", Entity)
local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModBomb.dependencies = {"ModPartEmitter", "ModActive","ModHitboxMaker","ModInteractive"}

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
	lume.trace("Hello Hello")
	self:addIcon(require("assets.spr.scripts.IcoBomb"))
end

function ModBomb:tick( dt )
	self.bombCoolDown = self.bombCoolDown - dt
end
function ModBomb:setHitState(stunTime, forceX, forceY, damage, element,faction,hitbox)
	if element == "fire" and self.bombCoolDown <= 0 then
		self.bombCoolDown = 2.0
		self:onAttack()
	end
end

function ModBomb:onAttack()
	self:createHitbox({radius = 64,xOffset = 0, yOffset = 0, damage = 40, guardDamage = 12,
	stun = 35, persistence = 0.35,xKnockBack = 3 * 32, yKnockBack = -12 * 32, element = "fire"})
	self:setHitState(2, 0, -8 * 32, 40, "fire",nil,40)
	self:emit("fire",8)
end
function ModBomb:destroy()
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
	self:onAttack()
end

function ModBomb:onRemove()
	self:removeIcon("assets/spr/warning.png")
end
return ModBomb