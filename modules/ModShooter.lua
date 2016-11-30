local ModShooter = Class.create("ModShooter", Entity)
local ObjShot = require "objects.ObjShot"
local laserSound = love.audio.newSource("/assets/sounds/Laser.wav");

ModShooter.trackFunctions = {"onAttack","preProcessProjectile","postProcessProjectile"}

function ModShooter:onAttack()
	local newShot = ObjShot(self.x,self.y,self)
	self:preProcessProjectile(newShot)
	Game:add(newShot)
	laserSound:play()
	self:postProcessProjectile(newShot)
end

function ModShooter:preProcessProjectile( projectile )
end

function ModShooter:postProcessProjectile( projectile )
end
return ModShooter