local ModIrresistable = Class.create("ModIrresistable", Entity)
ModIrresistable.dependencies = {"ModPartEmitter", "ModInteractive"}

ModIrresistable.trackFunctions = {"onCollide"}
ModIrresistable.removable = true

function ModIrresistable:create()
	-- self:addEmitter("fire" , "assets/spr/fire.png")
	-- self:setRandomDirection("fire" , 3 * 32)
	-- self:setRandRotation("fire",32,0,1)
	-- local fire = self.psystems["fire"]
	-- fire:setParticleLifetime(1, 2);
	-- self:setAreaSpread("fire","normal",8,8)
	-- self.bombCoolDown = 0
	-- self:setFade("fire")
	self.users = {}
	self.refreshTime = 1
end

function ModIrresistable:tick( dt )
	--self:emit("fire",14)
	for k,v in pairs(self.users) do
		self.users[k] = v - dt
		if v < 0 then
			self.users[k] = nil
		end
	end
end
function ModIrresistable:onCollide(other, collision)
	if other ~= nil and other ~= self.attacker then
		for k,v in pairs(self.users) do
			if k == other then
				return
			end
		end
		if Class.istype(other, "ObjBase")  and other:hasModule("ModActive") then
			self.users[other] = self.refreshTime
			self:onPlayerInteract(other)
		end
	end
end

return ModIrresistable