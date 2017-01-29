local ModEnemy = Class.create("ModEnemy", Entity)
ModEnemy.dependencies = {"ModActive","ModHitboxMaker"}

ModEnemy.trackFunctions = {"onAttack","onAttackStart"}

function ModEnemy:create( )
	self.aggressive = false
	self.deflectable = true

	-- self:setGoal(self.x, self.y)
	self.startX = self.x
	self.startY = self.y
	self.jumpSpeed = 210
	self.AICounter = 0
	self.AIStatus = nil
	self.timeSinceLastAttack = 0
	self.faction = "enemy"
	self.timeSinceLastJump = 0
	-- lume.trace("Setting can be deflectined")
	local function aggressiveAI( char, target )
		--self.status = "normal"
		self:moveToPoint(target.x,target.y, 32)
		self:tryAttack()
		self:randomJump(self.randomJumpProbability)
	end
	self:setRandomJumpProbability(0.01,2)
	self:setAttackFunction(aggressiveAI)

	if self.searchRadius then
		self.searchRadius = tonumber(self.searchRadius)
	end
end

function ModEnemy:setAttackFunction( script )
	self.attackFunct= script
end
function ModEnemy:normalState()
	if self == Game.tagag then
	end
	self.status = "normal"
	if not self.target or self.target.destroyed then
		self:findTarget()
	elseif not self.searchRadius or self:testProximity(self.target.x,self.target.y, self.searchRadius) then
		self.attackFunct(self,self.target)
	end
	self:animate()
end

function ModEnemy:tick( dt)
	self.timeSinceLastAttack = self.timeSinceLastAttack + dt
	self.timeSinceLastJump = self.timeSinceLastJump + dt

end

function ModEnemy:normalMove( )
	self:normalState()
end

function ModEnemy:setRandomJumpProbability( prob , delayBetweenJumps)
	self.randomJumpProbability = prob
	self.jumpDelay = delayBetweenJumps
end

function ModEnemy:randomJump( prob )
	if math.random() < (prob or 1) and self.timeSinceLastJump > self.jumpDelay then
		self:jump()
	end
end

function ModEnemy:setAttackRangeRate( range ,rate)
	self.attackRange = range
	self.attackRate = rate
end

function ModEnemy:tryAttack()
	local dist = self:getDistanceToPoint(self.target.x,self.target.y)
	if dist <= self.attackRange and self.timeSinceLastAttack > self.attackRate then
		self:onAttackStart()
	end
end

function ModEnemy:onAttack() end

function ModEnemy:findTarget()
	if self.x == 0 and self.y == 0 then return end
	local found = false
	local actList = Game:findObjectsWithModule("ModControllable")
	local minDist = 9999999
	for i,v in ipairs(actList) do
		if not self.faction or (v.faction and v.faction ~= self.faction) then
			-- lume.trace(self.x,self.y)
			local dist = self:getDistanceToPoint(v.x,v.y) 
			if dist < minDist then
				minDist = dist
				self.target = v
				found = true
			end
		end
	end
	if not found then self.target = nil end
end


function ModEnemy:setGoal( x, y ,tolerance)
	self.initX = x
	self.initY = y
	self.tolerance = tolerance or 4
end

function ModEnemy:moveToPoint(destinationX, destinationY, proximity,grounded)
	local velX, velY = self.body:getLinearVelocity()
	local distance = math.sqrt(((destinationX - self.x) * (destinationX - self.x)) +
		((destinationY - self.y) * (destinationY - self.y)) )
	if proximity ~= nil and distance <= proximity then
		return
	else
		local accForce = self.acceleration * self.body:getMass()
		local dvX = 0
		if self.x < destinationX then
			dvX = dvX + 1
			self.dir = 1
		elseif self.x > destinationX then
			dvX = dvX - 1
			self.dir = -1
		end

		if dvX ~= 0 and math.abs(self.velX - self.referenceVel) < self.maxSpeed * self.speedModifier then
			self.forceX = dvX * accForce
			if util.sign(self.velX) == dvX then
				self.forceX = self.forceX * 2
			end
		end

		self.forceX = self:calcForce( dvX, self.velX, accForce, self.maxSpeed )
		if self.inAir then
			self.forceX = self.forceX * 0.8
		end
		self.isMoving = (dvX ~= 0) or self.inAir
	end

	if not grounded and  math.abs(self.forceX) ~= 0 and math.abs(velX) <= 16 then-- if something is stopping you, try jumping
		self.jmpCount1 = self.jmpCount1 + 1
	else
		self.jmpCount1 = 0
	end

	if not grounded and destinationY - self.y < -24 then -- if target is higher than you, try jumping
		self.jmpCount2 = self.jmpCount2 + 1
	else
		self.jmpCount2 = 0
	end
	if not grounded and (self.jmpCount1 >= 8 or self.jmpCount2 >= 16) and (self.jmpCount2 < 240) then
		self:jump()
	else
		self.jumpCooldown = 0
		self.currentJumpTime = 0
		self.jumping = false
	end
end

function ModEnemy:turnToPoint(x, y)
	if x > self.x then
		self.dir = 1
	else
		self.dir = -1
	end
end

function ModEnemy:setFrameData( startup, activeFrame, recovery)
	self.startUp = startup
	self.activeFrame = activeFrame or startup
	self.recovery = self.startUp + (recovery or 0)
end

function ModEnemy:setAttackAnimation( animation )
	if animation == "slash" then
		self.preAnim = "slash_p"
		self.recoveryAnim = "slash_r"
	else
	end
end

function ModEnemy:setSelfCanMove( canMove )
	self.canMove = canMove
end

function ModEnemy:onAttackStart()
	self.timeSinceLastAttack = 0
	local function attackAnimation( player, frame )
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
			self:onAttack()
		elseif frame >= self.recovery then
			player.exit = true
		end
	end
	self:setSpecialState(attackAnimation)
end

return ModEnemy