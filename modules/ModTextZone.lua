local ModTextZone = Class.create("ModTextZone",Entity)
local Scene = require "xl.Scene"
local TimedText = require "objects.TimedText"

function ModTextZone:create()
	self.wrapCheckSpeedZone = lume.fn(ModTextZone.mCheckSpeedZone, self)
	self.modSpeedX = self.modSpeedX or -0.5
	self.modSpeedY = self.modSpeedY or self.modSpeedX
	self.speedModObjs = {}
	self.boundQuads = {self.x, self.y , self.x + self.width, self.y + self.height}
	local drawFunc = function()
		local floor = math.floor
		local loveGraphics = love.graphics
		loveGraphics.push()
		loveGraphics.setColor(50, 200, 50)
		loveGraphics.rectangle("fill",self.boundQuads[1],self.boundQuads[2],self.width,self.height)
		loveGraphics.setColor(255, 255, 255)
		loveGraphics.pop()
    end
	local node = Scene.wrapNode({draw = drawFunc}, 9900)
	--Game.scene:insert(node)
	self.text = self.text or "No Text Specified"
end

function ModTextZone:tick( dt )
	Game.world:queryBoundingBox( self.boundQuads[1],self.boundQuads[2],self.boundQuads[3],self.boundQuads[4] , self.wrapCheckSpeedZone)
	for i,v in ipairs(self.speedModObjs) do
		self:outOfZone(v)
	end
end

function ModTextZone:addInZone(other)
	self.newText = TimedText(self.text, self.x + 64, self.y, 10)
	self.newText.scrollSpeed = 0
	self.newText.alphaSpeed = 0
	Game:add(self.newText)
	table.insert(self.speedModObjs, other)

end

function ModTextZone:mCheckSpeedZone(fixture, x, y, xn, yn, fraction )
	if fixture then
		local other = fixture:getBody():getUserData()
		local category = fixture:getCategory()
		if other ~= nil and Class.istype(other,"ObjBase") and other:hasModule("ModControllable") and other ~= self  then
			if not util.hasValue(self.speedModObjs,other) and xl.inRect({x=other.x,y=other.y},self.boundQuads) then
				self:addInZone(other)
			end
		end
	end
	return 1
end

function ModTextZone:outOfZone( object )
	local x, y = object.body:getPosition()
	if not xl.inRect({x=x,y=y},self.boundQuads) then
		self.newText.alpha = 0
		util.deleteFromTable(self.speedModObjs,object)
	end
end

return ModTextZone