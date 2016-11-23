local ObjBase = require "ObjBase"
local ObjTest = Class.create("ObjTest", ObjBase)
	
function ObjTest:create()
	local active = require "modules.ModActive"
	self:addModule(active)
	local body = require "modules.ModPhysics"
	self:addModule(body)
	self:createBody( "dynamic" ,false, false)

	self.shape = love.physics.newRectangleShape(32,32)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6)

	self:addModule(require "modules.ModDrawable")
	self:addSpritePiece(require("assets.spr.scripts.SprBox"))
	self:addModule(require "modules.ModWooden")
	-- lume.trace("getting removable functions")
	util.print_table(self:getAllRemovableModules())
	-- for k,v in pairs() do
	-- 	self:removeModule(k)
	-- 	lume.trace("removed module:" ,k)
	-- end
	--self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)
end

return ObjTest