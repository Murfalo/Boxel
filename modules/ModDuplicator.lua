local ModDuplicator = Class.create("ModDuplicator", Entity)
-- local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModDuplicator.dependencies = {"ModPartEmitter", "ModActive"}

ModDuplicator.trackFunctions = {"onAttack"}
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

function ModDuplicator:destroy()
	self:removeModule("ModDuplicator")
	local newCopy = util.deepcopy(self)
	newCopy.health = self.max_health
	newCopy.destroyed = false
	Game:add(newCopy)
	newCopy.body:setLinearVelocity(math.random(-3,3) * 32, -8 * 32)

	local newCopy2 = util.deepcopy(self)
	newCopy2.health = self.max_health
	newCopy2.destroyed = false
	Game:add(newCopy2)
	newCopy2.body:setLinearVelocity(math.random(-3,3) * 32, -8 * 32)
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