local ane = {}

local pce = {
	name = "weapon",
	path = "assets/spr/gun.png",
	width = 64,
	height = 16,
	imgX = 32,
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