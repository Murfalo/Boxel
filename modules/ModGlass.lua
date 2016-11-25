local ModGlass = Class.create("ModGlass", Entity)
local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModGlass.dependencies = {"ModPartEmitter", "ModActive","ModHitboxMaker"}

ModGlass.trackFunctions = {}
ModGlass.removable = true

function ModGlass:create()
	self:addEmitter("wood" , "assets/spr/woodchip.png")
	self:setRandomDirection("wood" , 3 * 32)
	self:setRandRotation("wood",32,0,1)
	local wood = self.psystems["wood"]
	wood:setParticleLifetime(1, 2);
	self:setFade("wood")
end

function ModGlass:setHitState(stunTime, forceX, forceY, damage, element,faction,hitbox)
	if damage and damage >= 30 then
		self.health = 0
	end
	self:emit("wood", 4)
end

function ModGlass:destroy()
	local newEmitter = ObjSimpleEmitter(self.x,self.y)
	Game:add(newEmitter)
	newEmitter:setDestroyAfterEmpty(true)
	newEmitter:addEmitter("wood" , "assets/spr/woodchip.png")
	newEmitter:setRandomDirection("wood" , 3 * 32)
	newEmitter:setRandRotation("wood",32,0,1)
	local wood = newEmitter.psystems["wood"]
	wood:setParticleLifetime(1, 2);
	newEmitter:setFade("wood")
	newEmitter:emit("wood",16)
end

return ModGlass