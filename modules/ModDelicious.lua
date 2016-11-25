local ModDelicious = Class.create("ModDelicious", Entity)
ModDelicious.dependencies = {"ModActive", "ModInteractive"}
ModDelicious.removable = true

function ModInteractive:create()
	self:setdeliciousness(20)
end
function ModInteractive:onPlayerInteract(player) 
	self:setHitState(0, nil, nil, self.deliciousness, nil,nil)
	player.health = player.health + self.deliciousness
end

function ModDelicious:setdeliciousness( deliciousness )
	self.deliciousness = deliciousness
end

return ModDelicious