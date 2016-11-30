local ModProjectileEnemy = Class.create("ModProjectileEnemy", Entity)
ModProjectileEnemy.dependencies = {"ModEnemy","ModShooter"}

function ModProjectileEnemy:preProcessProjectile( projectile )
	projectile.image = "assets.spr.scripts.SprEnShot"
end


return ModProjectileEnemy