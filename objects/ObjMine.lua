local ObjBaseUnit = require "objects.ObjBaseUnit"
local ObjMine = Class.create("ObjMine", ObjBaseUnit)
	
function ObjMine:create()
	ObjBaseUnit.create(self)
	self:createBody( "dynamic" ,false, true)
	self.shape = love.physics.newRectangleShape(16,16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)
	self.health = 20

	self:addSpritePiece(require("assets.spr.scripts.SprMine"))
	-- self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
	self:addModule(require "modules.ModBomb")
	self:addModule(require "modules.ModIrresistable")
end

return ObjMine
