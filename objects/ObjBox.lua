local ObjBaseUnit = require "objects.ObjBaseUnit"
local ObjTable = Class.create("ObjTable", ObjBaseUnit)
	
function ObjTable:create()
	ObjBaseUnit.create(self)
	self:createBody( "dynamic" ,false, true)
	self.shape = love.physics.newRectangleShape(32,32)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 50)
	self.health = 90
	self.max_health = 90

	self:addSpritePiece(require("assets.spr.scripts.SprBox"))
	-- self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
end

return ObjTable
