local mod = modApi:getCurrentMod()
local resourcePath = mod.resourcePath

modApi:appendAsset("img/portraits/dw_handler.png", resourcePath .."img/effects/handler.png")
modApi:appendAsset("img/effects/glider_flyby.png", resourcePath .."img/effects/glider_flyby.png")
modApi:appendAsset("img/effects/shotup_needles.png", resourcePath .."img/effects/shotup_needles.png")

modApi:appendAsset("img/effects/neon_outline.png", resourcePath .."img/effects/neon_outline.png")
ANIMS["neon_outline"] = Animation:new{
	Image = "effects/neon_outline.png",
	NumFrames = 10,
	Time = 0.15,
	PosX = -30, 
	PosY = 0,
	Loop = true,
	Layer = ANIMS.LAYER_FLOOR,
}

modApi:appendAsset("img/effects/dreadwatch_mark.png", resourcePath .."img/effects/dreadwatch_mark.png")
ANIMS["dreadwatch_mark"] = Animation:new{
	Image = "effects/dreadwatch_mark.png",
	NumFrames = 16,
	Time = 0.10,
	PosX = -25, ---15
	PosY = -15,	--10
	Loop = false,
	Layer = ANIMS.LAYER_FRONT,
}

modApi:appendAsset("img/effects/explo_star_fake.png", resourcePath .."img/effects/explo_star_fake.png")
ANIMS["explo_star_fake"] = Animation:new{
	Image = "effects/explo_star_fake.png",
	NumFrames = 21,
	Time = 0.13,
	PosX = -18, ---15
	PosY = -15,	--10
	Loop = false,
	Layer = ANIMS.LAYER_FRONT,
}

modApi:appendAsset("img/effects/drone_target_lock.png", resourcePath .."img/effects/drone_target_lock.png")

ANIMS.DroneTriLock = Animation:new{
	Image = "effects/drone_target_lock.png",
	NumFrames = 18,
	Time = 0.08,
	
	PosX = -15,	
	PosY = 4,
}