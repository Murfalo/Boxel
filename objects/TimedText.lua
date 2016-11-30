local Text = require("xl.Text")
local TimedText = Class.create("TimedText", Entity)
--[[
Description: Text intended to appear when you activate a spell, shows the name of the spell
 and floats upwards, fading slowly.

Required Parameters:
"text": the text that is displayed
x: x coordinate the object is drawn
y: y coordinate the object is drawn
]]

function TimedText:init( text, x, y, ptSize)
	self.x = x
	self.y = y
	self.text = text
	self.ptSize = ptSize
end

function TimedText:create()
	-- lume.trace(#self.text)
	self.x = self.x - (#self.text * self.ptSize)/4
	self.textObj = Text(self.text, self.x, self.y, 9000, true)
	self.textObj:setPtsize(self.ptSize or 24)
	Game.scene:insert(self.textObj)
	self.alpha = 255
end

function TimedText:tick(dt)
	self.textObj:setPosition(self.textObj.x, self.textObj.y - 0.5)
	self.alpha = self.alpha - 1.4
	self.textObj:setColor(255,255,255,self.alpha)
	if self.alpha < 10 then
		Game:del(self)
	end
end

function TimedText:destroy()
	Game.scene:remove(self.textObj)
end

return TimedText