local ObjBase = require "ObjBase"
local ObjDupBox = Class.create("ObjDupBox", ObjBase)
	
function ObjDupBox:create()
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
	self:addModule(require "modules.ModDuplicator")
	-- lume.trace(self.onHitConfirm)
	self.max_health = 100
	self.health = self.max_health
	-- lume.trace("getting removable functions")
	-- for k,v in pairs() do
	-- 	self:removeModule(k)
	-- 	lume.trace("removed module:" ,k)
	-- end
	--self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
end

return ObjDupBox