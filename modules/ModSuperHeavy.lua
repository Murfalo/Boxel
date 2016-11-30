local ModSuperHeavy = Class.create("ModSuperHeavy", Entity)
ModSuperHeavy.dependencies = {"ModActive","ModHitboxMaker"}

ModSuperHeavy.trackFunctions = {"onCollide"}
ModSuperHeavy.removable = true

function ModSuperHeavy:create( ... )
	self.smashTime = 0
	self.fallTime = 0
	self:addIcon(require("assets.spr.scripts.IcoSuperHeavy"))
end

function ModSuperHeavy:tick( dt )
	self.smashTime = self.smashTime - dt
	if self.velY > 6 * 32 then
		self.fallTime = self.fallTime + dt
	else
		self.fallTime = 0
	end

end
function ModSuperHeavy:onCollide(other, collision)
	if other ~= nil and other ~= self.attacker then
		if self.fallTime > 0.2 and self.smashTime <= 0 then
			local danger = math.floor(self.velY - (6 * 32))
			self.smashTime = 1.5
			self:createHitbox({stun=0.2,damage=danger,forceX=32,forceY=(danger+7*32),XOffset = 0,YOffset = -64,persistence = 5})
		end
	end
end

function ModSuperHeavy:onRemove()
	self:removeIcon("assets/spr/superHeavy.png")
end
return ModSuperHeavy