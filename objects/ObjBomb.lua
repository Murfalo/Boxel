local ObjBaseUnit = require "objects.ObjBaseUnit"
local ObjBomb = Class.create("ObjBomb", ObjBaseUnit)
	
function ObjBomb:create()
	ObjBaseUnit.create(self)
	self:createBody( "dynamic" ,false, true)
	self.shape = love.physics.newRectangleShape(24,32)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)
	self.health = 100

	self:addSpritePiece(require("assets.spr.scripts.SprBomb"))
	-- self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
	self:addModule(require "modules.ModBomb")
end

return ObjBomb
