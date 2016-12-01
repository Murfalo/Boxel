local ModSuperHeavy = Class.create("ModSuperHeavy", Entity)
ModSuperHeavy.dependencies = {"ModPartEmitter","ModActive","ModHitboxMaker"}

ModSuperHeavy.trackFunctions = {"onCollide"}
ModSuperHeavy.removable = true

function ModSuperHeavy:create( ... )
	self.smashTime = 0
	self.fallTime = 0
	self:addEmitter("smoke" , "assets/spr/smoke.png")
	self:setRandomDirection("smoke" , 3 * 32)
	self:setRandRotation("smoke",32,0,1)
	local smoke = self.psystems["smoke"]
	smoke:setParticleLifetime(1, 2);
	self:setFade("smoke")
	self:addIcon(require("assets.spr.scripts.IcoSuperHeavy"))
	self.oldMaxSpeed = self.maxSpeed

	self.maxSpeed = self.maxSpeed * 0.8
end

function ModSuperHeavy:tick( dt )
	self.smashTime = self.smashTime - dt
	if self.velY > 6 * 32 then
		self.fallTime = self.fallTime + dt
	else
		self.fallTime = 0
	end

end
function ModSuperHeavy:onCollide(other, collision)
	if other ~= nil and other ~= self.attacker then
		if self.fallTime > 0.12 and self.smashTime <= 0 then
			local danger = math.floor(self.velY - (6 * 32))
			self.smashTime = 1.5
			self:emit("smoke",2)
			self:createHitbox({stun=0.2,damage=danger,forceX=32,forceY=(danger+7*32),XOffset = 0,YOffset = -64,persistence = 0.4})
		end
	end
end

function ModSuperHeavy:onRemove()
	self.maxSpeed = self.oldMaxSpeed
	self:removeIcon("assets/spr/superHeavy.png")
end
return ModSuperHeavy