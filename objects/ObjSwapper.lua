local ObjBase = require "ObjBase"
local ObjSwapper = Class.create("ObjSwapper", ObjBase)
local TimedText = require "objects.TimedText"

function ObjSwapper:init( x,y,attacker )
	self.x = x
	self.y = y
	self.attacker = attacker
end

function ObjSwapper:create()
	self:addModule( require "modules.ModProjectile")
	self:setFaction(self.attacker.faction)

	self.attacker.swapperOut = true
	self:createBody("dynamic", true, true)
	self:setNoGrav(true)

	self.shape = love.physics.newRectangleShape(16,16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6, true)
	
	self:addSpritePiece(require("assets.spr.scripts.SprSwapper"))
	
	--Sprite initialization
	self.refresh = 30 
	self.damage = 0
	self.stun = 0
	self.range = 120
	self.forceX = 0
	self.forceY = 0
	self.element = "hit"

	if self.attacker.dir == 1 then
		self:fireAtPoint(self.x + 128,self.y,4*32)
	else
		self:fireAtPoint(self.x - 128,self.y,4*32)
	end

	self.fixture:setSensor(true)
	if self.attacker.currentSwapper then
		self:changeAnimation("active")
	end

	local function spin(self)
		self:setSprAngle(Game:getTicks()/16)
	end

	self:addTickFunction(spin)

	local function foundTarget(self,target, hitType, hitbox)
		if Class.istype(target,"ObjBase") then
			if target ~= self.attacker then
				self.returnToChar = true
				if self.attacker.currentSwapper then
					target:addModule(require("modules."..self.attacker.currentSwapper))
					self.attacker.currentSwapper = nil
					self:changeAnimation("unactive")
				else
					self.range = 900
					self.haveSomething = true
					local mods = target:getAllRemovableModules()
					if #mods > 0 then
						local removeMod = mods[math.random(1,#mods)]
						target:removeModule(removeMod)
						self.haveSomething = removeMod
						self:changeAnimation("active")
					end
				end
			end
		end
	end
	self:addOnHitFunction(foundTarget)

	local function returnToPlayer(self)
		if self.haveSomething then
			self:moveToPoint(self.attacker.x,self.attacker.y,0,7*32)
			if self:getDistanceToPoint(self.attacker.x,self.attacker.y) < 16 then
				local displayText = "Nothing"
				if self.haveSomething ~= true then
					displayText = self.haveSomething
					self.attacker.currentSwapper = self.haveSomething
				end
				local newText = TimedText(displayText, self.x, self.y, 14)
				Game:add(newText)
				self.range = 0
			end
		end
	end
	self:addTickFunction(returnToPlayer)

	local function onDestroy(self)
		self.attacker.swapperOut = false
	end

	self:addDestroyFunction(onDestroy)
end

return ObjSwapper