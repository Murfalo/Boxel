local ModDuplicator = Class.create("ModDuplicator", Entity)
-- local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModDuplicator.dependencies = {"ModPartEmitter", "ModActive"}

ModDuplicator.trackFunctions = {"onAttack","onDeath"}
ModDuplicator.removable = true

function ModDuplicator:create()
	-- self:addEmitter("fire" , "assets/spr/fire.png")
	-- self:setRandomDirection("fire" , 3 * 32)
	-- self:setRandRotation("fire",32,0,1)
	-- local fire = self.psystems["fire"]
	-- fire:setParticleLifetime(1, 2);
	-- self:setAreaSpread("fire","normal",8,8)
	-- self.bombCoolDown = 0
	-- self:setFade("fire")

end

function ModDuplicator:onDeath()
	self:removeModule("ModDuplicator")
	local selfType = require("objects."..self.type)
	for i=1,3 do
		local newCopy = selfType(self)
		Class.include(newCopy,self)
		newCopy.health = self.max_health
		newCopy.destroyed = false
		Game:add(newCopy)
		newCopy:removeModule("ModDuplicator")
		newCopy.body:setLinearVelocity(math.random(-4,4) * 32, -12 * 32)
	end

	-- local newEmitter = ObjSimpleEmitter(self.x,self.y)
	-- Game:add(newEmitter)
	-- newEmitter:setDestroyAfterEmpty(true)
	-- newEmitter:addEmitter("fire" , "assets/spr/fire.png")
	-- newEmitter:setRandomDirection("fire" , 3 * 32)
	-- newEmitter:setRandRotation("fire",32,0,1)
	-- local fire = newEmitter.psystems["fire"]
	-- fire:setParticleLifetime(1, 2);
	-- newEmitter:setFade("fire")
	-- newEmitter:emit("fire",16)
end

return ModDuplicator