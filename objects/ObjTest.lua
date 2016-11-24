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
	self:addSprite(require("assets.spr.scripts.SprBox"))
	self:addModule(require "modules.ModWooden")
	-- lume.trace(self.onHitConfirm)
	self.max_health = 1000
	self.health = self.max_health
	-- lume.trace("getting removable functions")
	-- for k,v in pairs() do
	-- 	self:removeModule(k)
	-- 	lume.trace("removed module:" ,k)
	-- end
	--self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
end

return ObjTest