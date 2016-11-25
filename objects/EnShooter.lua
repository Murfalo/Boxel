local ObjBaseUnit = require "objects.ObjBaseUnit"
local EnShooter = Class.create("EnShooter", ObjBaseUnit)

function EnShooter:init( )
	-- init other data
	self.max_health = 100
	self.health = 100

	--initialize movement data
	self.maxJumpTime = 300
	self.currentJumpTime = 0
	self.jumpSpeed = 490
	self.maxAirJumps = 1
	self.deceleration = -9
	self.maxSpeed = 6 * 32
	self.acceleration = 20 * 32
	self.x = 0
	self.y = 0
	self.faction = "enemy"
end

function EnShooter:create()
	ObjBaseUnit.create(self)
	lume.trace("HOhoh")

	self:addModule(require "modules.ModProjectileEnemy")
	self:addModule(require "modules.ModShooter")
	self:setFrameData(8,10,10)
	self:setAttackAnimation(nil)
	self:setAttackRangeRate(150,1)

	self:addSpritePiece(require("assets.spr.scripts.PceWheel"))
	self:addSpritePiece(require("assets.spr.scripts.PceEvilBody"))
	self:addSpritePiece(require("assets.spr.scripts.SprGunEqp"))


	self:setDepth(self.depth or 5000)

	self:createBody( "dynamic" ,true, true)
	self.shape = love.physics.newRectangleShape(7, 16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)

	self.fixture:setCategory(CL_NPC)
end

return EnShooter
