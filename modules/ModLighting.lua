local ModLighting = Class.create("ModLighting", Entity)
ModLighting.dependencies = {"ModActive", "ModHitboxMaker"}
ModLighting.removable = true
local Scene = require "xl.Scene"


function ModLighting:create()
	self.timeSinceLast = 1
	self:addIcon(require("assets.spr.scripts.IcoVampire"))
	self.pulseAlpha = 0
	self.pulseColor1 = 0
	self.pulseColor2 = 0
	self.pulseColor3 = 0
	self.pulseRadius = 0
	self.radius = 60
	self.circleNode = Scene.wrapNode( function (  )
		love.graphics.setColor( 220 + self.pulseColor1, 220 + self.pulseColor2, 50 + self.pulseColor3 , 170 + self.pulseAlpha)
		love.graphics.circle("fill", self.x, self.y + 16, self.radius + self.pulseRadius, 100)
	end,
	9000)
	Game.scene:insert( self.circleNode )
	Game.scene:move(self.circleNode, 9000)
end

function ModLighting:tick( dt )
	local ticks = Game:getTicks()
	self.pulseAlpha = 30 * math.sin(ticks/20)
	self.pulseColor1 = 15 * math.sin(ticks/25)
	self.pulseColor2 = 30 * math.sin(ticks/30)
	self.pulseColor3 = 40 * math.sin(ticks/35)
	self.pulseRadius = self.radius/6 * math.sin(ticks/20)

	if self.timeSinceLast <= 0 then
		self:createHitbox({radius = 64,xOffset = 0, yOffset = 0, damage = 40, guardDamage = 0,
			stun = 0, persistence = 0.35, element = "light"})
		self.timeSinceLast = 1.5
	else
		self.timeSinceLast = self.timeSinceLast - dt
	end
end

function ModLighting:onHitConfirm(target, hitType, hitbox) 
	self:setHealth(self.health + 3)
end

function ModLighting:onRemove()
	Game.scene:remove( self.circleNode )
	self:removeIcon("assets/spr/vampire.png")
end

function ModLighting:destroy()
	Game.scene:remove( self.circleNode )
end
return ModLighting