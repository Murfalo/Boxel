local ObjBase = require "ObjBase"
local ObjShot = Class.create("ObjShot", ObjBase)

function ObjShot:init( x,y,creator )
	self.x = x
	self.y = y
	self.creator = creator
end

function ObjShot:create()
	self:addModule( require "modules.ModProjectile")
	self:setFaction(self.creator.faction)

	self:createBody("dynamic", true, true)
	self:setNoGrav(true)

	self.shape = love.physics.newRectangleShape(16,16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6, true)
	
	self:addSprite(require("assets.spr.scripts.SprShot"))
	
	--Sprite initialization
	self.refresh = 30 
	self.damage = 20
	self.stun = 20
	self.range = 120
	self.forceX = 6 * 32
	self.forceY = -6 * 32
	self.element = "fire"

	if self.creator.dir == 1 then
		self:fireAtPoint(self.x + 128,self.y,4*32)
	else
		self:fireAtPoint(self.x - 128,self.y,4*32)
	end

	self.fixture:setSensor(true)
end

return ObjShot