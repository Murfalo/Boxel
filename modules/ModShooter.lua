local ModShooter = Class.create("ModShooter", Entity)
local ObjShot = require "objects.ObjShot"

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
end

function ModShooter:preProcessProjectile( projectile )
end

function ModShooter:postProcessProjectile( projectile )
end
return ModShooter