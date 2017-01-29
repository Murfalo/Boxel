local Entity = require "objects.Entity"
local ObjMusicStarter = Class.create("ObjMusicStarter", Entity)
	
function ObjMusicStarter:create()
	if self.pause then 
		Game.bgTheme:pause()
	else
		Game.bgTheme:play()
	end
end

return ObjMusicStarter
