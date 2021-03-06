local ModControllable = Class.create("ModControllable", Entity)
local Keymap  = require "xl.Keymap"
local TimedText = require "objects.TimedText"
local ObjIntHitbox = require "objects.ObjIntHitbox"
local ObjSwapper = require "objects.ObjSwapper"
local swapperSound = love.audio.newSource("/assets/sounds/Swapper.wav");


ModControllable.dependencies = {"ModActive","ModInventory","ModShooter"}
ModControllable.trackFunctions = {"normalState"}
--calculates necessary force to make the character move in a certain direction

function ModControllable:normalState()

	--self.lighting:setPosition(self.x, self.y + self.height-2)
	local maxSpeed, maxYSpeed = self.maxSpeed, self.maxYSpeed
	--local decForce = self.deceleration * self.body:getMass() 
	if not self.isCrouching then
		if self.referenceVel ~= 0  and ((self.dir == 1 and self.referenceVel < 0) or (self.dir == -1 and self.referenceVel > 0)) then 
			self:moveLateral(self.maxSpeed, self.maxYSpeed, self.acceleration * 2)
		else
			self:moveLateral(self.maxSpeed, self.maxYSpeed, self.acceleration)
		end
	end
	self:moveVertical()
	if Keymap.isDown("down") and Keymap.isDown("jump") then
		self:setJumpThru(1)
	end
	self:animate()
	--self:normalizeSprSize()
	self:proccessInventory()
	--self:debugDisplay()
end

function ModControllable:normalMove()
	if self.referenceVel ~= 0  and ((self.dir == 1 and self.referenceVel < 0) or (self.dir == -1 and self.referenceVel > 0)) then
		self:moveLateral(self.maxSpeed, self.maxYSpeed, self.acceleration * 2)
	else
		self:moveLateral(self.maxSpeed, self.maxYSpeed, self.acceleration)
	end
 	self:moveVertical()
end

function ModControllable:moveVertical()
	--Jumping code
	if self.flying then
		self.inAir = false
	end
	
	if Keymap.isPressed("jump") and not Keymap.isDown("down") and self.jumpCooldown == 0 then
		self.noGrav = false
		if not self.inAir then
			self.body:setLinearVelocity(self.velX, -self.jumpSpeed/15) 
			self.jumpCooldown = 10 
			self.jumping = true
			self.isMoving = true
			self:drawJumpFX(math.random(2,3))
		elseif self.airJumps > 0 then
			if Keymap.isDown("left") then
				self.dir = -1
			elseif Keymap.isDown("right") then
				self.dir = 1
			end
			-- self:drawJumpFX(math.random(2,3))
			self.body:setLinearVelocity(self.velX, -self.jumpSpeed/20) 
			self.jumpCooldown = 10 
			self.jumping = true
			self.isMoving = true
			self.airJumps = self.airJumps - 1
		end
	elseif self.jumping then
		self.currentJumpTime = self.currentJumpTime + 1
	end
	if self.currentJumpTime > self.maxJumpTime then
		self.jumping = false
	end
	if not Keymap.isDown("jump") then
		self.currentJumpTime = 0
		self.jumping = false
	end
	
	--check for crouching, you cannot move while crouching.
	if Keymap.isDown("down") and not self.inAir then
		if self.isCrouching == false then --enter crouching state
			-- self:setFixture(self.shapeCrouch, 22.6)
			-- self.body:setPosition(self.x, self.y - 9)	
			self.isCrouching = true
			--self:setActionState(1,"5-7",0.2,5,7)
		end
		self.isMoving = false
	else --if you are not crouching, you are counted as standing
		if self.isCrouching then --return back to standing orientation
			-- self:setFixture(self.shape, 22.6)
			-- self.body:setPosition(self.x, self.y - 9)	
		end
		self.isCrouching = false
	end
end

--Manages left/right
function ModControllable:moveLateral(maxSpeed, maxYSpeed, acceleration)
	--Movement Code
	maxSpeed = maxSpeed or self.maxSpeed
	local accForce
	if acceleration then
		accForce = acceleration * self.body:getMass()
	else
		accForce = self.acceleration * self.body:getMass()
	end
	local dvX = 0
	if not self.inAir then self.turnTime = nil end
	if Keymap.isDown("left") then 
		dvX = dvX - 1
		 if self.dir == 1 and self.velX > 0 then
			self.turnTime = 16
		end
		--if not self.inAir  or self.velX < 0 then
			self.dir = -1 
		--end
	end
	if Keymap.isDown("right") then 
		dvX = dvX + 1
		if self.dir == -1 and self.velX < 0 then
			self.turnTime = 16
		end
		 	self.dir =   1 
		--end
	end
	if self.turnTime then self.turnTime = self.turnTime - 1 end
	if dvX ~= 0 and math.abs(self.velX - self.referenceVel) < maxSpeed * self.speedModifier then
		self.forceX = dvX * accForce
		if util.sign(self.velX) == dvX then
			self.forceX = self.forceX * 2
		end
	end
	self.forceX = self:calcForce( dvX, self.velX, accForce, maxSpeed )
	if self.inAir then
		self.forceX = self.forceX * 0.8
	end
	self.isMoving = (dvX ~= 0) or self.inAir
end

--Manages character's inventory management, item usage and environmental interaction code.
function ModControllable:proccessInventory()
	--Open Inventory
	-- if Keymap.isDown("inv") and not self.inventoryLocked then
	-- 	--Sound.playFX("stapler.mp3")
	-- 	InventoryMenu:open(self.inventory)
	-- end
	--Item using code
	-- if Keymap.isPressed("use") and self.currentEquips["neutral"] then
	-- 	lume.trace()
	-- 	self.currentEquips["neutral"]:use()
	-- 	-- if Keymap.isDown("up") and self.currentEquips["up"] then
	-- 	-- 	self.currentEquips["up"]:use()
	-- 	-- elseif Keymap.isDown("down") and self.currentEquips["down"] then
	-- 	-- 	self.currentEquips["down"]:use()
	-- 	-- elseif self.currentEquips["neutral"] then
	-- 	-- 	self.currentEquips["neutral"]:use()
	-- 	-- end
	-- 	-- elseif self.currentPrimary then
	-- 	-- 	self.currentPrimary:use()
	-- 	-- end
	-- end

	if Keymap.isPressed("use") and not self.swapperOut then
		local newShot = ObjSwapper(self.x,self.y,self)
		Game:add(newShot)
		swapperSound:play()
	end

	self:setPrimary(Keymap.isPressed("primary"))

	--interaction code

	if Keymap.isPressed("interact") and not Game.DialogActive then
		local intHitbox = ObjIntHitbox(self) 
		Game:add(intHitbox)
	end
	if Keymap.isPressed("journal") then gamestate.push(JBase) end	
end

function ModControllable:drawJumpFX( amount )
	-- local angle = 0
	-- for i=1,amount do
	-- 	local FX = FXExplosion(self.x, self.y + self.height/2, "assets/spr/fx/jump_blue.png",32,48)
	-- 	Game:add(FX)
	-- 	FX:setMaxSize(16,24)
	-- 	FX.sprite:setAnimation(math.random(1,4),1,5)
	-- 	FX:setDepth(9000)
	-- 	angle = angle +  math.random(math.pi, math.pi * 2)
	-- 	FX:setAngle(angle)
	-- 	local speed = math.random(1,2)
	-- 	FX:setSpeed(speed * math.cos(angle),speed * math.sin(angle))
	-- end
end

function ModControllable:onKill(target, hitType, hitbox)
	local Advanced = true
	-- lume.trace(self.killCount)
	--Game.round = 5
	if self.killCount == 3 then
		Game.round = 2
	elseif self.killCount == 10 then
		Game.round = 3
	elseif self.killCount == 22 then
		Game.round = 4
	elseif self.killCount == 45 then
		Game.round = 5
	else 
		Advanced = false
	end
	if Advanced then
		-- lume.trace(self.killCount)
		local newText = TimedText("Round Advanced", self.x, self.y, 20)

		Game:add(newText)
	end
end

function ModControllable:onDeath()
	if not self:hasModule("ModDuplicator") and not self.reviving then
		if not self.textWritten then
			Game.round = 1
			local newText = TimedText("You died, Press I to Restart\nEnemies Defeated: " .. self.killCount, self.x, self.y, 20)
			Game:add(newText)
			self.textWritten = true
		end
		self:changeAnimation("hit")
		if Keymap.isDown("interact") then
			lume.trace()
			Game.playerIsDead = true
			Game:loadRoom( Game.currentRoom)
		end
	end
	self.reviving = false
end
return ModControllable