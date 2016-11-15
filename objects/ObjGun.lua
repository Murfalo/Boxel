local ObjBase = require "ObjBase"
local ObjGun = Class.create("ObjGun", ObjBase)
local ObjShot = require "objects.ObjShot"

function ObjGun:create()
	self:addModule( require "modules.ModWeapon")

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

function ObjGun:onAttack()
	local newShot = ObjShot(self.x,self.y,self)
	lume.trace(newShot.modules)
	lume.trace(ObjShot.modules)
	util.print_table(newShot.modules)
	Game:add(newShot)
end

return ObjGun