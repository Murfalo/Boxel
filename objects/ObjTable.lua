local ObjBaseUnit = require "objects.ObjBaseUnit"
local ObjTable = Class.create("ObjTable", ObjBaseUnit)
	
function ObjTable:create()
	ObjBaseUnit.create(self)
	self:createBody( "dynamic" ,false, true)
	self.shape = love.physics.newRectangleShape(32,16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)
	self.health = 400
	self.max_health = 400

	self:addSpritePiece(require("assets.spr.scripts.SprTable"))
	-- self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
	self:addModule(require "modules.ModSuperHeavy")
end

return ObjTable
