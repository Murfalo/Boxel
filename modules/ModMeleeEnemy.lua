local ModMeleeEnemy = Class.create("ModMeleeEnemy", Entity)
ModMeleeEnemy.dependencies = {"ModEnemy","ModHitboxMaker"}
ModMeleeEnemy.trackFunctions = {"onMelee"}

function ModMeleeEnemy:setMeleeHitbox( hitboxTable )
	self.hitboxTable = hitboxTable
end
function ModMeleeEnemy:onMelee()
	self:createHitbox(self.hitboxTable)
end

return ModMeleeEnemy