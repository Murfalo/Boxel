local ObjBase = require "ObjBase"
local ObjGun = Class.create("ObjGun", ObjBase)

function ObjGun:create()
	self:addModule( require "modules.ModWeapon")
	self:addModule( require "modules.ModShooter")

	self.shape = love.physics.newRectangleShape(32,32)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)

	self:addSprite(require("assets.spr.scripts.SprGun"))

	self.isKeyItem = false
	self.isPrimary = true
	self.name = "Gun" --String that displays in Inventory
	self.invSprite = love.graphics.newImage( "assets/spr/gun.png" )

	self.spritePiece = 	self:createSpritePiece(8,8,"weapon",require ("assets.spr.scripts.SprGunEqp"))
	self:setFrameData(1,2,10)
	self:setCanMove(true)
end

return ObjGun