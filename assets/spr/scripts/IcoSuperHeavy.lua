local ane = {}

local pce = {
	name = "shot",
	path = "assets/spr/superHeavy.png",
	width = 32,
	height = 32,
	imgX = 16,
	imgY = 16,
	attachPoints = 
		{
			center = {x = 16,y = 16},
			nextIco = {x=16,y=0},
			prevIco = {x = 16, y = 32}

		},
	animations = ane,
	connectPoint = "nextIco",
	connectMPoint = "prevIco"
}

return pce