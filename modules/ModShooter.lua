local ModShooter = Class.create("ModShooter", Entity)
local ObjShot = require "objects.ObjShot"
local laserSound = love.audio.newSource("/assets/sounds/Laser.wav");

ModShooter.trackFunctions = {"onAttack","preProcessProjectile","postProcessProjectile"}


function ModShooter:onAttack()
	self:shoot()
end

function ModShooter:shoot()
	local newShot = ObjShot(self.x,self.y,self)
	self:preProcessProjectile(newShot)
	if self.user and self.user.preProcessProjectile then
		self.user:preProcessProjectile(newShot)
	end
	Game:add(newShot)
	self:postProcessProjectile(newShot)
	if self.user and self.user.postProcessProjectile then
		self.user:postProcessProjectile(newShot)
	end
	laserSound:play()
end

function ModShooter:preProcessProjectile( projectile )
end

function ModShooter:postProcessProjectile( projectile )
end

function ModShooter:onDeath()
	if self == Game.tagag then
		-- fhwoh()
	end
end

return ModShooter