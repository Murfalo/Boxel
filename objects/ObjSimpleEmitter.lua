local ObjBase = require "ObjBase"
local ObjSimpleEmitter = Class.create("ObjSimpleEmitter", ObjBase)
local ModPartEmitter = require "modules.ModPartEmitter"

function ObjSimpleEmitter:init( x,y )
	self.x = x
	self.y = y
end
function ObjSimpleEmitter:create()
	self:addModule(ModPartEmitter)
end

function ObjSimpleEmitter:setDestroyAfterTimer( timer )
	self.timer = timer
end
function ObjSimpleEmitter:setDestroyAfterEmpty( destroyOnEmpty )
	self.destroyOnEmpty = destroyOnEmpty
end

function ObjSimpleEmitter:tick( dt )
	ModPartEmitter.tick(self,dt)
	if self.destroyOnEmpty then
		local toDestroy = true
		for k,v in pairs(self.psystems) do
			if k:count() > 0 then
				toDestroy = false
				break
			end
		end
		if toDestroy == true then
			lume.trace()
			Game:del(self)
		end
	end
	if self.timer then
		self.timer = self.timer - dt
		if self.timer <= 0 then
			Game:del(self)
		end
	end
end


return ObjSimpleEmitter