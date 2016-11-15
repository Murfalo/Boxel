local ObjBase = require "ObjBase"
local ObjTorch = Class.create("ObjTorch", ObjBase)
	
function ObjTorch:create()
	self:addModule( require "modules.ModWeapon")
	self:addModule( require "modules.ModHitboxMaker")

	self.shape = love.physics.newRectangleShape(32,32)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22)

	self:addSprite(require("assets.spr.scripts.SprTorch"))

	self.isKeyItem = false
	self.isPrimary = true
	self.name = "Torch" --String that displays in Inventory
	self.invSprite = love.graphics.newImage( "assets/spr/torch_item.png" )

	self.spritePiece = 	self:createSpritePiece(8,8,"weapon", require ("assets.spr.scripts.SprTorchEqp"))
	--self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
	self:setFrameData(8,10,10)
	self:setAnimation("slash")
	self:setCanMove(true)
end

function ObjTorch:onAttack()
	self:createHitbox({width = 60, height = 15,xOffset = 10, yOffset = -5, damage = 15, guardDamage = 12,
	stun = 35, persistence = 0.15,xKnockBack = 4 * 32, yKnockBack = -3 * 32, element = "fire"})
end

return ObjTorch