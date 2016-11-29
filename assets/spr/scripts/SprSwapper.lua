local ane = {
	unactive = {
		row = 1,
		range = 1,
		delay = 0.1,
		priority = 1,
		attachMod = {{{angle=0,x=0,y=0}}}
	},
	active = {
		row = 1,
		range = 2,
		delay = 0.1,
		priority = 1
	}
}
local pce = {
	name = "shot",
	path = "assets/spr/swapper.png",
	width = 32,
	height = 32,
	imgX = 16,
	imgY = 16,
	originX = 16,
	originY = 16,
	attachPoints = 
		{
			center = {x = 16,y = 16}
		},
	animations = ane
}

return pce