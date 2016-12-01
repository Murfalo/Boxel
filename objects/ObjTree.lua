local ObjBaseUnit = require "objects.ObjBaseUnit"
local ObjTree = Class.create("ObjTree", ObjBaseUnit)
	
function ObjTree:create()
	ObjBaseUnit.create(self)
	self:createBody( "dynamic" ,false, true)
	self.shape = love.physics.newRectangleShape(16,16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 50)
	self.health = 200
	self.max_health = 200
	self:addSpritePiece(require("assets.spr.scripts.SprTree"))
	-- self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
	self:addModule(require "modules.ModPlant")
	-- self:addModule(require "modules.ModDuplicator")
	-- self:addModule(require "modules.ModEmitter")

end

return ObjTree
