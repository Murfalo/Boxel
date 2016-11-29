local ModDelicious = Class.create("ModDelicious", Entity)
ModDelicious.dependencies = {"ModActive", "ModInteractive"}
ModDelicious.removable = true

function ModDelicious:create()
	self:setDeliciousness(20)
	self:addIcon(require("assets.spr.scripts.IcoDelicious"))
end

function ModDelicious:onPlayerInteract(player) 
	lume.trace(self.health)
	self:setHitState(0, nil, nil, self.deliciousness, nil,nil)
	player.health = player.health + self.deliciousness
end

function ModDelicious:setDeliciousness( deliciousness )
	self.deliciousness = deliciousness
end

return ModDelicious