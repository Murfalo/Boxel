local ObjBaseUnit = require "objects.ObjBaseUnit"
local ObjBomb = Class.create("ObjBomb", ObjBaseUnit)
	
function ObjBomb:create()
	ObjBaseUnit.create(self)
	self:addModule(require "modules.ModBomb")
	self:addModule(require "modules.ModIrresistable")
	

	self:createBody( "dynamic" ,false, true)
	self.shape = love.physics.newRectangleShape(24,32)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)
	self.health = 20

	self:addSprite(require("assets.spr.scripts.SprMine"))
	-- self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
end

return ObjBomb
