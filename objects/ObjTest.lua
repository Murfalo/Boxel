local ObjBase = require "ObjBase"
local ObjTest = Class.create("ObjTest", ObjBase)
	
function ObjTest:create()
	local active = require "modules.ModActive"
	self:addModule(active)
	local body = require "modules.ModPhysics"
	self:addModule(body)

	self:createBody( "dynamic" ,false, false)

	self.shape = love.physics.newRectangleShape(30,30)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)

	self:addModule(require "modules.ModDrawable")
	self:addSpritePiece(require("assets.spr.scripts.SprBox"))

	self:addModule(require "modules.ModWooden")
	self:addModule(require "modules.ModDelicious")
	self:addModule(require "modules.ModIrresistable")
	-- lume.trace(self.onHitConfirm)
	self.max_health = 100
	self.health = self.max_health
end

return ObjTest