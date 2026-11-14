local mod = modApi:getCurrentMod()

local palette = {
    id = mod.id,
    name = "Xenochrome", 
    image = "img/units/player/baron_mech.png", --change MyMech by the name of the mech you want to display
    colorMap = {
        lights =         { 229, 173, 34 }, --PlateHighlight
        main_highlight = { 136, 69,  151 }, --PlateLight
        main_light =     {  97,  47,  125 }, --PlateMid
        main_mid =       {  45,  25,  69 }, --PlateDark
        main_dark =      {  16,  8,  26 }, --PlateOutline
        metal_light =    { 158,  182,  190 }, --BodyHighlight
        metal_mid =      {  72,  83,  108 }, --BodyColor
        metal_dark =     {  31, 26, 43 }, --PlateShadow
    },
}

modApi:addPalette(palette)

 