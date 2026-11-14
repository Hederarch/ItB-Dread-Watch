
-- Squad Template by Hedera, built fron Lemonymous' Mech Template mod

local mod = {
	id = "hedera_dread_watch", --replace this, make it unique! it's only internal so it doesn't really matter.
	name = "The Dread Watch", -- this name is what shows up in the mod list 
	version = "1.0.0", 
	dependencies = {
        modApiExt = "1.24",
		memedit = "1.2.2",
        redactedrice_memhack = "1.4.1",
    },
	modApiVersion = "2.3.0",
	icon = "img/mod_icon.png"
}

function mod:init() -- these are the files that the modloader will load
	require(self.scriptPath .."palettes")
	require(self.scriptPath .."animations")
	require(self.scriptPath .."achievements")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."weapons")
	require(self.scriptPath .."passive")
end
	-- this adds your weapons to the weapon deck so other squads can use them
    --modApi:addWeaponDrop("TT_BigBlaster")
    --modApi:addWeaponDrop("TT_GroupLoader")
    --modApi:addWeaponDrop("TT_SiloDrop")

function mod:metadata()
	modApi:addGenerationOption(
		"resetTutorials",
		"Reset Tutorial Tooltips",
		"Check to reset all tutorial tooltips for this profile.",
		{ enabled = false }
	)
	modApi:addGenerationOption(
		"noOverthrowEffects",
		"Remove Overthrow Effects",
		"Suppresses the additional board effects when destroying the CEO tower.",
		{ enabled = false }
	)
end

function mod:load(options, version)
	
	if options.resetTutorials and options.resetTutorials.enabled then
		require(self.scriptPath .."libs/tutorialTips"):ResetAll()
		options.resetTutorials.enabled = false
	end
	
	modApi:addSquad( 
		{
			id = mod.id,
			"Dread Watch",	--this name is what shows up in the hangar
			"DW_BaronMech",			
			"DW_TripodMech",			
			"DW_SledgeMech"			
		},
		"Dread Watch", -- this name is what shows up in the squad list
		"An elite strike squad for an unknown mastermind intent on taking the islands for itself.", -- description when moused over
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod
