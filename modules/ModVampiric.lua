local ModVampiric = Class.create("ModVampiric", Entity)
ModVampiric.dependencies = {"ModActive", "ModHitboxMaker"}
ModVampiric.removable = true

function ModVampiric:create()
	self:addIcon(require("assets.spr.scripts.IcoVampire"))
end

function ModVampiric:setHitState(stunTime, forceX, forceY, damage, element,faction,hitbox)
	if element == "light" then
		self:setHealth(0)
	end
end

function ModVampiric:onHitConfirm(target, hitType, hitbox) 
	self:setHealth(self.health+5)
end

function ModVampiric:onRemove()
	self:removeIcon("assets/spr/vampiric.png")
end

return ModVampiric