local ModPlant = Class.create("ModPlant", Entity)
local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModPlant.dependencies = {"ModPartEmitter", "ModActive","ModHitboxMaker"}

ModPlant.trackFunctions = {}
ModPlant.removable = true

function ModPlant:create()
	self:addEmitter("wood" , "assets/spr/woodchip.png")
	self:setRandomDirection("wood" , 3 * 32)
	self:setRandRotation("wood",32,0,1)
	local wood = self.psystems["wood"]
	wood:setParticleLifetime(1, 2);
	self:setFade("wood")

	self:addIcon(require("assets.spr.scripts.IcoWooden"))
end

function ModPlant:setHitState(stunTime, forceX, forceY, damage, element,faction,hitbox)
	if (not faction or faction ~= self.faction) and element == "fire" then
		local function onFire(player,extraInfo)
			if not extraInfo.frame then extraInfo.frame = 0 end
			extraInfo.frame = extraInfo.frame + 1
			local frame = extraInfo.frame

			if frame % 16 == 0 then
				-- self.health = self.health - 2
				self:setHealth(self.health - 2)
				self:createHitbox({width = 48, height = 48,xOffset = 0, yOffset = 0, damage = 15, guardDamage = 12,
					stun = 35, persistence = 0.15,xKnockBack = 4 * 32, yKnockBack = -3 * 32, element = "fire"})
				self:emit("fire", 2)
			end
			
			if frame > self.fireTime then
				player:setPassive("onFire",nil)
			end
		end
		self:setPassive("onFire",onFire)
	end
	if element == "light" then
		self:setHealth(self.health + 6)
	end
	if (not faction or faction ~= self.faction)  and damage > 0 then
		self:emit("wood", 4)
	end
end

function ModPlant:destroy()
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

function ModPlant:onRemove()
	self:removeIcon("assets/spr/wooden.png")
end

return ModPlant