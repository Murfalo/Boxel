local ModGlass = Class.create("ModGlass", Entity)
local ObjSimpleEmitter = require "objects.ObjSimpleEmitter"
ModGlass.dependencies = {"ModPartEmitter", "ModActive","ModHitboxMaker"}
local ObjShot = require "objects.ObjShot"

ModGlass.trackFunctions = {}
ModGlass.removable = true

function ModGlass:create()
	self.fallTime = 0
	self:addEmitter("glass" , "assets/spr/shard.png")
	self:setRandomDirection("glass" , 3 * 32)
	self:setRandRotation("glass",32,0,1)
	local glass = self.psystems["glass"]
	glass:setParticleLifetime(1, 2);
	self:setFade("glass")
	self:addIcon(require("assets.spr.scripts.IcoGlass"))
end


function ModGlass:tick( dt )
	if self.velY > 6 * 32 then
		self.fallTime = self.fallTime + dt
	else
		self.fallTime = 0
	end

end

function ModGlass:setHitState(stunTime, forceX, forceY, damage, element,faction,hitbox)
	if (not faction or faction ~= self.faction)  and damage > 0 then
		self:emit("glass", 4)
		self:setHealth(self.health - 8)
	end
end

function ModGlass:onCollide(other, collision)
	if other ~= nil and other ~= self.attacker then
		if self.fallTime > 0.4 then
			self:emit("glass",8)
			self:setHealth(self.health - self.health)
		end
	end
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

function ModGlass:preProcessProjectile( projectile )
	projectile.image = "assets.spr.scripts.SprShard"
	projectile.stun = 60
	projectile.range = 32
end

function ModGlass:onRemove()
	self:removeIcon("assets/spr/glass.png")
end

function ModGlass:postProcessProjectile( projectile )
	local function setShatter2(self,dt )
		self.dir = 1
		if self.range == 1 then
			for i=1,10 do
				local newShot = ObjShot(self.x,self.y,self)
				newShot.image = "assets.spr.scripts.SprShard"
				newShot.damage = 10
				newShot.firePointX = math.random(-128,128)
				newShot.firePointY =  math.random(-128,128)
				newShot.speed = self.speed
				Game:add(newShot)
				newShot.hitFuncts = self.hitFuncts

			end
		end
	end
	projectile:addTickFunction(setShatter2)
end
return ModGlass