local ModMeleeEnemy = Class.create("ModMeleeEnemy", Entity)
ModMeleeEnemy.dependencies = {"ModEnemy","ModHitboxMaker"}
ModMeleeEnemy.trackFunctions = {"onAttack"}

function ModMeleeEnemy:setMeleeHitbox( hitboxTable )
	self.hitboxTable = hitboxTable
end
function ModMeleeEnemy:onAttack()
	self:createHitbox(self.hitboxTable)
end

return ModMeleeEnemy