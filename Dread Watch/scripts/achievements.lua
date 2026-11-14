
--Libraries
local mod = modApi:getCurrentMod()

--Constants
local squad_id = "hedera_dread_watch"

--Save data
local function achievementData()

	local game = GAME or {}	-- GAME may not be initialized in the hangar menu. Use a dummy

	--Establish achievement data
	if game.hedera_dw_ach == nil then
		game.hedera_dw_ach = {}
	end

	if game.hedera_dw_ach.achievementData == nil then
		game.hedera_dw_ach.achievementData = {}
	end

	--Establish achievement data values
	local gameData = game.hedera_dw_ach.achievementData

	return gameData
end


local function check_mastery_status()
	if modApi.achievements:isComplete(squad_id,"dw_ach1") and modApi.achievements:isComplete(squad_id,"dw_ach2") and modApi.achievements:isComplete(squad_id,"dw_ach3") and modApi.achievements:isComplete(squad_id,"dw_ach4") and modApi.achievements:isComplete(squad_id,"dw_ach5") then
		modApi.achievements:trigger(squad_id,"dw_final")
	end
end



--Achievement 1
local dw_ach1 = modApi.achievements:add{
	--Required
	id = "dw_ach1",
	name = "Infamous",
	image = mod.resourcePath.."img/achievements/dreadwatch_chievo1.png",

	--Optional
	tooltip = "Get 13 Reputation in one Island.",
	squad = squad_id,
	addReward = check_mastery_status,
	remReward = check_mastery_status,
}

--Achievement 2
local dw_ach2 = modApi.achievements:add{
	--Required
	id = "dw_ach2",
	name = "Smooth Operator",
	image = mod.resourcePath.."img/achievements/dreadwatch_chievo2.png",

	--Optional
	tooltip = "Destroy every marked Building in an Island and no unmarked ones.",
	squad = squad_id,
	addReward = check_mastery_status,
	remReward = check_mastery_status,
}

--Achievement 3
local dw_ach3 = modApi.achievements:add{
	--Required
	id = "dw_ach3",
	name = "The Greater Good",
	image = mod.resourcePath.."img/achievements/dreadwatch_chievo3.png",

	--Optional
	tooltip = "Start a mission at 1 Grid and end it at 4 or higher.",
	squad = squad_id,
	addReward = check_mastery_status,
	remReward = check_mastery_status,
}

--Achievement 4
local dw_ach4 = modApi.achievements:add{
	--Required
	id = "dw_ach4",
	name = "Blacklisted",
	image = mod.resourcePath.."img/achievements/dreadwatch_chievo4.png",

	--Optional
	tooltip = "Fail every Reputation mission objective in an Island.",
	squad = squad_id,
	addReward = check_mastery_status,
	remReward = check_mastery_status,
}


--Achievement 5
local dw_ach5 = modApi.achievements:add{
	--Required
	id = "dw_ach5",
	name = "World Domination",
	image = mod.resourcePath.."img/achievements/dreadwatch_chievo5.png",

	--Optional
	tooltip = "Destroy all 4 Corporate Towers in one game.",
	squad = squad_id,
	addReward = check_mastery_status,
	remReward = check_mastery_status,
}

--Achievement Final
local dw_final = modApi.achievements:add{
	--Required
	id = "dw_final",
	name = "Dread Watch Mastery",
	image = mod.resourcePath.."img/achievements/dreadwatch_mastery.png",

	--Optional
	tooltip = "Unlock all Dread Watch achievements.",
	squad = squad_id,
}
