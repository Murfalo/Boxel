local ane = {}

local pce = {
	name = "weapon",
	path = "assets/spr/sword.png",
	width = 48,
	height = 16,
	imgX = 24,
	imgY = 8,
	originX = 8,
	originY = 8,
	attachPoints = {
			grip1 = {x = 8,y=8}
		},
	connectSprite = "body",
	connectPoint = "hand1",
	connectMPoint = "grip1",
	animations = ane
}

return pce