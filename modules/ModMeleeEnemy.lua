local ModMeleeEnemy = Class.create("ModMeleeEnemy", Entity)
local attackSound = love.audio.newSource("/assets/sounds/EnemyAttack.wav")
ModMeleeEnemy.dependencies = {"ModEnemy","ModHitboxMaker"}
ModMeleeEnemy.trackFunctions = {"onAttack"}

function ModMeleeEnemy:setMeleeHitbox( hitboxTable )
	self.hitboxTable = hitboxTable
end
function ModMeleeEnemy:onAttack()
	attackSound:play()
	self:createHitbox(self.hitboxTable)
end

return ModMeleeEnemy