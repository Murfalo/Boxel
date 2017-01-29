local ObjBaseUnit = require "objects.ObjBaseUnit"
local ObjCake = Class.create("ObjCake", ObjBaseUnit)
	
function ObjCake:create()
	self.health = 250
	self.max_health = 250
	ObjBaseUnit.create(self)
	self:createBody( "dynamic" ,false, true)
	self.shape = love.physics.newRectangleShape(32,16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 50)
	self:addSpritePiece(require("assets.spr.scripts.SprCake"))
	-- self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
	self:addModule(require "modules.ModDelicious")

end

return ObjCake
