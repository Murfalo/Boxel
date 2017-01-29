local ModDelicious = Class.create("ModDelicious", Entity)
ModDelicious.dependencies = {"ModPartEmitter","ModActive", "ModInteractive"}
ModDelicious.removable = true

function ModDelicious:create()
	self:setDeliciousness(25)
	self:addEmitter("crumb" , "assets/spr/crumb.png")
	self:setRandomDirection("crumb" , 3 * 32)
	self:setRandRotation("crumb",32,0,1)
	local crumb = self.psystems["crumb"]
	crumb:setParticleLifetime(1, 2);
	self:setFade("crumb")
	self:addIcon(require("assets.spr.scripts.IcoDelicious"))
end

function ModDelicious:onPlayerInteract(player) 
	self:emit("crumb",3)
	self:setHitState(0, nil, nil, self.deliciousness, nil,nil)
	player:setHealth( player.health + self.deliciousness )
end

function ModDelicious:setDeliciousness( deliciousness )
	self.deliciousness = deliciousness
end

function ModDelicious:onRemove()
	self:removeIcon("assets/spr/delicious.png")
end

return ModDelicious