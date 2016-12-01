local ModTemp = Class.create("ModTemp", Entity)
ModTemp.dependencies = {"ModPartEmitter", "ModActive","ModHitboxMaker","ModInteractive","ModShooter"}

function ModTemp:create()
	self.temp = 10
end

function ModTemp:tick( dt )
	self.temp = self.temp - dt
	if self.temp <= 0 then
		Game:del(self)
	end
end

return ModTemp