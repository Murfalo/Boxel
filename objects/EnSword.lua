local ObjBaseUnit = require "objects.ObjBaseUnit"
local EnSword = Class.create("EnSword", ObjBaseUnit)

function EnSword:init( )
	-- init other data
	self.max_health = 80
	self.health = 80

	--initialize movement data
	self.maxJumpTime = 300
	self.currentJumpTime = 0
	self.jumpSpeed = 490
	self.maxAirJumps = 1
	self.deceleration = -9
	self.maxSpeed = 4 * 32
	self.acceleration = 20 * 32
	self.x = 0
	self.y = 0
	self.faction = "enemy"
end

function EnSword:create()
	ObjBaseUnit.create(self)

	self:addModule(require "modules.ModMeleeEnemy")
	self:setMeleeHitbox({width = 60, height = 15,xOffset = 10, yOffset = -5, damage = 20, guardDamage = 12,
	stun = 35, persistence = 0.15,xKnockBack = 4 * 32, yKnockBack = -3 * 32})
	self:setFrameData(8,10,10)
	self:setAttackAnimation("slash")
	self:setAttackRangeRate(50,1)

	self:addSpritePiece(require("assets.spr.scripts.PceWheel"))
	self:addSpritePiece(require("assets.spr.scripts.PceEvilBody"))
	self:addSpritePiece(require("assets.spr.scripts.SprKnifeEqp"))


	self:setDepth(self.depth or 5000)

	self:createBody( "dynamic" ,true, true)
	self.shape = love.physics.newRectangleShape(7, 16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)

	self.fixture:setCategory(CL_NPC)
	if self.mModule then
		self:addModule(require( "modules.".. self.mModule))
	end
end

return EnSword
