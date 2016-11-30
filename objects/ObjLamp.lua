local ObjBaseUnit = require "objects.ObjBaseUnit"
local ObjLamp = Class.create("ObjLamp", ObjBaseUnit)
	
function ObjLamp:create()
	ObjBaseUnit.create(self)
	self:createBody( "dynamic" ,false, true)
	self.shape = love.physics.newRectangleShape(30,20)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 50)
	self.health = 60
	self.max_health = 60

	self:addSpritePiece(require("assets.spr.scripts.SprLamp"))
	-- self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
	self:addModule(require "modules.ModRadiant")
end

return ObjLamp
