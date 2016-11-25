local ModShooter = Class.create("ModShooter", Entity)
local ObjShot = require "objects.ObjShot"

ModShooter.trackFunctions = {"onAttack","preProcessProjectile","postProcessProjectile"}

function ModShooter:onAttack()
	local newShot = ObjShot(self.x,self.y,self)
	self:preProcessProjectile(newShot)
	Game:add(newShot)
	self:preProcessProjectile(newShot)
end

function ModShooter:preProcessProjectile( projectile )
end

function ModShooter:postProcessProjectile( projectile )
end
return ModShooter