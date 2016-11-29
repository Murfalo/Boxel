local ModGlass = Class.create("ModGlass", Entity)
local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModGlass.dependencies = {"ModPartEmitter", "ModActive","ModHitboxMaker"}

ModGlass.trackFunctions = {}
ModGlass.removable = true

function ModGlass:create()
	self:addEmitter("glass" , "assets/spr/shard.png")
	self:setRandomDirection("glass" , 3 * 32)
	self:setRandRotation("glass",32,0,1)
	local glass = self.psystems["glass"]
	glass:setParticleLifetime(1, 2);
	self:setFade("glass")
end

function ModGlass:setHitState(stunTime, forceX, forceY, damage, element,faction,hitbox)
	if damage and damage >= 30 then
		self.health = 0
	end
	self:emit("glass", 4)
end

function ModGlass:destroy()
	local newEmitter = ObjSimpleEmitter(self.x,self.y)
	Game:add(newEmitter)
	newEmitter:setDestroyAfterEmpty(true)
	newEmitter:addEmitter("glass" , "assets/spr/shard.png")
	newEmitter:setRandomDirection("glass" , 3 * 32)
	newEmitter:setRandRotation("glass",32,0,1)
	local glass = newEmitter.psystems["glass"]
	glass:setParticleLifetime(1, 2);
	newEmitter:setFade("glass")
	newEmitter:emit("glass",16)
end

return ModGlass