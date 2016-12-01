local ModDuplicator = Class.create("ModDuplicator", Entity)
-- local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModDuplicator.dependencies = {"ModPartEmitter", "ModActive"}
local TimedText = require "objects.TimedText"

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
	self:addIcon(require("assets.spr.scripts.IcoDuplicator"))
end

function ModDuplicator:onDeath()
	self:removeModule("ModDuplicator")

	if self:hasModule("ModControllable") then
		self.health = 250
		lume.trace()
		self.isAlive = true
		local newText = TimedText("A clone has replaced you", self.x, self.y, 20)
		Game:add(newText)
		self.textWritten = false
	else
		local selfType = require("objects."..self.type)
		for i=1,4 do
			local newCopy = selfType()	
			Game:add(newCopy)
			--Class.include(newCopy,self)
			Game.tagag = newCopy

			newCopy.x = self.x
			newCopy.y = self.y
			-- newCopy.health = 100 --self.max_health
			-- newCopy.max_health = 100
			newCopy:setPosition(self.x,self.y)
			for i,v in ipairs(self:getAllRemovableModules()) do
				newCopy:addModule(require ("modules." .. v))
			end
			newCopy:removeModule("ModDuplicator")
			newCopy.body:setLinearVelocity(math.random(-4,4) * 32, -12 * 32)
		end
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

function ModDuplicator:onRemove()
	self:removeIcon("assets/spr/duplicator.png")
end

return ModDuplicator