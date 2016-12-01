local ModEmitter = Class.create("ModEmitter", Entity)
ModEmitter.dependencies = {"ModPartEmitter","ModActive","ModShooter"}
local ObjShot = require "objects.ObjShot"
local laserSound = love.audio.newSource("/assets/sounds/Laser.wav");
ModEmitter.trackFunctions = {"onCollide"}
ModEmitter.removable = true

function ModEmitter:create( ... )
	if not self.faction then
		self.faction = "neutral"
	end
	self:addIcon(require("assets.spr.scripts.IcoEmitter"))
end

function ModEmitter:tick( dt )
	if Game:getTicks() % 60 == 0 then
		local newShot = ObjShot(self.x,self.y,self)
		newShot.faction = self.faction
		self:preProcessProjectile(newShot)
		if self.user and self.user.preProcessProjectile then
			self.user:preProcessProjectile(newShot)
		end
		newShot.firePointX = math.random(-128,128)
		newShot.firePointY =  math.random(-128,128)
		Game:add(newShot)
		self:postProcessProjectile(newShot)
		if self.user and self.user.postProcessProjectile then
			self.user:postProcessProjectile(newShot)
		end
		newShot.range = newShot.range / 4
		newShot.damage = newShot.damage / 2
		laserSound:play()
	end
end

function ModEmitter:onRemove()
	self:removeIcon("assets/spr/emitter.png")
end
return ModEmitter