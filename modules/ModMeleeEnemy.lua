local ModMeleeEnemy = Class.create("ModMeleeEnemy", Entity)
ModMeleeEnemy.dependencies = {"ModEnemy","ModHitboxMaker"}
ModMeleeEnemy.trackFunctions = {"onMelee"}

function ModMeleeEnemy:setMeleeHitbox( hitboxTable )
	self.hitboxTable = hitboxTable
end
function ModMeleeEnemy:onMelee()
	self:createHitbox(self.hitboxTable)
end

function ModMeleeEnemy:setFrameData( startup, activeFrame, recovery)
	self.startUp = startup
	self.activeFrame = activeFrame or startup
	self.recovery = self.startUp + (recovery or 0)
end

function ModMeleeEnemy:setAnimation( animation )
	if animation == "slash" then
		self.preAnim = "slash_p"
		self.recoveryAnim = "slash_r"
	else
	end
end

function ModMeleeEnemy:onAttack()
	local function MeleeAttack( player, frame )
		if self.canMove then
			player:animate()
			player:normalMove()
		end

		if frame == 1 and self.preAnim then
			player:changeAnimation(self.preAnim)
		end
		if frame >= self.startUp and self.recoveryAnim then
			player:changeAnimation(self.recoveryAnim)
		end
		if frame == self.activeFrame then
			self:onMelee()
		elseif frame >= self.recovery then
			player.exit = true
		end
	end
	self:setSpecialState(MeleeAttack)
end

return ModMeleeEnemy