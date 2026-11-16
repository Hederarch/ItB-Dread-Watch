
local mod = modApi:getCurrentMod()
local autoOffset = 0 -- this and the function below sets the default squad palette to the colors in palettes.lua

local id = modApi:getPaletteImageOffset(mod.id)
if id ~= nil then
	autoOffset = id
end

-- pulled out of the filepaths for easier editing
-- put the folder names for each mech here
local mech1 = "baron"
local mech2 = "tripod"
local mech3 = "wedge"

DW_BaronMech = Pawn:new{ -- look at the base game pawns.lua for examples!
	Name = "Baron Mech",
	Class = "Prime",
	Health = 2,
	MoveSpeed = 3,
	Massive = true,
	Flying = true,
	Image = mech1 .. "_mech", 
	
	ImageOffset = autoOffset, -- this is the default palette, keep it on autoOffset to make it use yours

	SkillList = { "DW_Telepunch","DW_Wiretaps"}, -- this is the weapon ID(s) they start with
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

DW_TripodMech = Pawn:new{
	Name = "Tripod Mech",
	Class = "Ranged",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Image = mech2 .. "_mech", 
	
	ImageOffset = autoOffset,

	SkillList = {"DW_Rockets"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

DW_SledgeMech = Pawn:new{
	Name = "Sledge Mech",
	Class = "Brute",
	Health = 4,
	MoveSpeed = 3,
	Massive = true,
	Image = mech3 .. "_mech", 
	
	ImageOffset = autoOffset,

	SkillList = {"DW_TC_Repeater"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

 -- everything below here adds the images from /units/
 -- if your images are misaligned (and they will be) adjust the PosX and PosY to fix them
 -- PosX negative is left, PosX positive is right; PosY negative is up, PosY positive is down

local path = mod_loader.mods[modApi.currentMod].resourcePath

local files = {
	"mech.png", -- default, with shadow
	"mech_a.png", -- animated sprite sheet
	"mech_w.png", -- in water
	"mech_w_broken.png", -- dead in water
	"mech_broken.png", -- dead on land
	"mech_ns.png", -- no shadow, used in menus
	"mech_h.png" -- shading for hangar, inherits PosX PosY from mech_a, adding 8 rows to the bottom of the sprite can help alignment
}

local mechPath = path .."img/units/" .. mech1 .. "/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/" .. mech1 .. "_".. file, mechPath .. file)
end

local a = ANIMS
a[mech1 .. "_mech"] =			a.MechUnit:new{Image = "units/player/" .. mech1 .. "_mech.png", PosX = -30, PosY = -12}
a[mech1 .. "_mecha"] =			a.MechUnit:new{Image = "units/player/" .. mech1 .. "_mech_a.png", PosX = -27, PosY = -10, NumFrames = 4 }
a[mech1 .. "_mechw"] =			a.MechUnit:new{Image = "units/player/" .. mech1 .. "_mech_w.png", PosX = -27, PosY = -2 }
a[mech1 .. "_mech_broken"] =	a.MechUnit:new{Image = "units/player/" .. mech1 .. "_mech_broken.png", PosX = -27, PosY = -9 }
a[mech1 .. "_mechw_broken"] =	a.MechUnit:new{Image = "units/player/" .. mech1 .. "_mech_w_broken.png", PosX = -27, PosY = -2 }
a[mech1 .. "_mech_ns"] =		a.MechIcon:new{Image = "units/player/" .. mech1 .. "_mech_ns.png"}

mechPath = path .."img/units/" .. mech2 .. "/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/" .. mech2 .. "_".. file, mechPath .. file)
end

a[mech2 .. "_mech"] =			a.MechUnit:new{Image = "units/player/" .. mech2 .. "_mech.png", PosX = -30, PosY = -12}
a[mech2 .. "_mecha"] =			a.MechUnit:new{Image = "units/player/" .. mech2 .. "_mech_a.png", PosX = -25, PosY = -6, NumFrames = 4 }
a[mech2 .. "_mechw"] =			a.MechUnit:new{Image = "units/player/" .. mech2 .. "_mech_w.png",PosX = -25, PosY = 0 }
a[mech2 .. "_mech_broken"] =	a.MechUnit:new{Image = "units/player/" .. mech2 .. "_mech_broken.png", PosX = -25, PosY = -6 }
a[mech2 .. "_mechw_broken"] =	a.MechUnit:new{Image = "units/player/" .. mech2 .. "_mech_w_broken.png", PosX = -25, PosY = 0 }
a[mech2 .. "_mech_ns"] =		a.MechIcon:new{Image = "units/player/" .. mech2 .. "_mech_ns.png"}


mechPath = path .."img/units/" .. mech3 .. "/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/" .. mech3 .. "_".. file, mechPath .. file)
end

a[mech3 .. "_mech"] =			a.MechUnit:new{Image = "units/player/" .. mech3 .. "_mech.png", PosX = -30, PosY = -12}
a[mech3 .. "_mecha"] =			a.MechUnit:new{Image = "units/player/" .. mech3 .. "_mech_a.png", PosX = -27, PosY = -12, NumFrames = 4 }
a[mech3 .. "_mechw"] =			a.MechUnit:new{Image = "units/player/" .. mech3 .. "_mech_w.png", PosX = -25, PosY = -4 }
a[mech3 .. "_mech_broken"] =	a.MechUnit:new{Image = "units/player/" .. mech3 .. "_mech_broken.png", PosX = -27, PosY = -12 }
a[mech3 .. "_mechw_broken"] =	a.MechUnit:new{Image = "units/player/" .. mech3 .. "_mech_w_broken.png", PosX = -25, PosY = -4 }
a[mech3 .. "_mech_ns"] =		a.MechIcon:new{Image = "units/player/" .. mech3 .. "_mech_ns.png"}
