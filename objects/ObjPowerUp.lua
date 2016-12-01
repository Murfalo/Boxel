local ObjBaseUnit = require "objects.ObjBaseUnit"
local ObjPowerUp = Class.create("ObjPowerUp", ObjBaseUnit)
	
function ObjPowerUp:create()
	ObjBaseUnit.create(self)
	self:createBody( "dynamic" ,true, true)
	self.shape = love.physics.newRectangleShape(16,16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)
	self.health = 100
	self.max_health = 100

	self:addSpritePiece(require("assets.spr.scripts.SprPowerChip"))
	self.choices =  {"ModDuplicator","ModFlaming","ModPlant","ModBomb","ModSuperHeavy","ModVampiric","ModNinja","ModDelicious","ModGlass","ModRadiant","ModEmitter"}
	local mModule = self.choices[math.random(1,#self.choices)]
	self:addModule(require ("modules."..mModule))
	self:addModule(require "modules.ModTemp")
end

return ObjPowerUp
