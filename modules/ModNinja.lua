local ModNinja = Class.create("ModNinja", Entity)
ModNinja.dependencies = {"ModPartEmitter","ModActive","ModHitboxMaker"}

ModNinja.trackFunctions = {"onCollide"}
ModNinja.removable = true

function ModNinja:create( ... )
	self.smoke = 0
	self.fallTime = 0
	self:addEmitter("smoke" , "assets/spr/smoke.png")
	self:setRandomDirection("smoke" , 3 * 32)
	self:setRandRotation("smoke",32,0,1)
	local smoke = self.psystems["smoke"]
	smoke:setParticleLifetime(1, 2);
	self:setFade("smoke")
	self:addIcon(require("assets.spr.scripts.IcoNinja"))
	self.oldMaxSpeed = self.maxSpeed

	self.maxSpeed = self.maxSpeed * 1.2
end

function ModNinja:tick( dt )
	if not self.inAir then
		self.smoked = false
		self.airJumps = 1
	end
	if self.inAir and self.airJumps == 0  and not self.smoked then
		self:emit("smoke",4)
		self.smoked = true
	end

end
function ModNinja:onRemove()
	self.maxSpeed = self.oldMaxSpeed
	self:removeIcon("assets/spr/ninja.png")
end

function ModNinja:preProcessProjectile( projectile )
	projectile.image = "assets.spr.scripts.SprNinja"
	projectile.speed = 6 * 32
end

function ModNinja:postProcessProjectile( projectile )
	local function spinStar(self)
		self:setSprAngle(Game:getTicks()/8)
	end
	projectile:addTickFunction(spinStar)
end
return ModNinja