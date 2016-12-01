local ModRadiant = Class.create("ModRadiant", Entity)
ModRadiant.dependencies = {"ModActive", "ModHitboxMaker"}
ModRadiant.removable = true
local Scene = require "xl.Scene"


function ModRadiant:create()
	self.timeSinceLast = 1
	self:addIcon(require("assets.spr.scripts.IcoRadiant"))
	self.pulseAlpha = 0
	self.pulseColor1 = 0
	self.pulseColor2 = 0
	self.pulseColor3 = 0
	self.pulseRadius = 0
	self.radius = 60
	if not self.circleNode then
		self.circleNode = Scene.wrapNode( function (  )
			love.graphics.setColor( 220 + self.pulseColor1, 220 + self.pulseColor2, 50 + self.pulseColor3 , 120 + self.pulseAlpha)
			love.graphics.circle("fill", self.x, self.y + 16, self.radius + self.pulseRadius, 100)
			love.graphics.setColor(255,255,255,255)
		end,
		9000)
		Game.scene:insert( self.circleNode )
		Game.scene:move(self.circleNode, 9000)
	end
end

function ModRadiant:tick( dt )
	local ticks = Game:getTicks()
	self.pulseAlpha = 30 * math.sin(ticks/20)
	self.pulseColor1 = 15 * math.sin(ticks/25)
	self.pulseColor2 = 30 * math.sin(ticks/30)
	self.pulseColor3 = 40 * math.sin(ticks/35)
	self.pulseRadius = self.radius/6 * math.sin(ticks/20)

	if self.timeSinceLast <= 0 then
		self:createHitbox({radius = 64,xOffset = 0, yOffset = 0, damage = 0, guardDamage = 0,
			stun = 0, persistence = 0.35, element = "light"})
		self.timeSinceLast = 1.5
	else
		self.timeSinceLast = self.timeSinceLast - dt
	end
end

function ModRadiant:onHitConfirm(target, hitType, hitbox) 
end

function ModRadiant:onRemove()
	Game.scene:remove( self.circleNode )
	self:removeIcon("assets/spr/radiant.png")
	self.circleNode = nil
end

function ModRadiant:destroy()
	Game.scene:remove( self.circleNode )
	self.circleNode = nil
end
return ModRadiant