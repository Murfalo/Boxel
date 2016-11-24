local ModProjectileEnemy = Class.create("ModProjectileEnemy", Entity)
ModProjectileEnemy.dependencies = {"ModEnemy","ModHitboxMaker"}
ModProjectileEnemy.trackFunctions = {"onMelee"}

function ModProjectileEnemy:setProjectile( projectile )
	self.projectile = projectile
end
function ModProjectileEnemy:onMelee()
	local newShot = self.projectile(self.x,self.y,self)
	Game:add(newShot)
end

return ModProjectileEnemy