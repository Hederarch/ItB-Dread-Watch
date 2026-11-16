local path = mod_loader.mods[modApi.currentMod].resourcePath
local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local scriptPath = mod.scriptPath

local customAnim = require(scriptPath.."/libs/customAnim")
local boardEvents = require(scriptPath.."/libs/boardEvents")
local tips = require(scriptPath.."/libs/tutorialTips")
local options = mod_loader.currentModContent[mod.id].options

require(scriptPath.."dialog")

modApi:appendAsset("img/weapons/passives/passive_dreadwatch.png", path .."img/weapons/passive_dreadwatch.png")
--==================================================================================================================================--

	DW_Wiretaps = PassiveSkill:new {
		Name = "Wire Taps",
		Description = "Mark a Building to destroy for Reputation in each mission. After each mission, gain 1 grid for each failed Reputation objective.",
		Passive = "DW_Wiretaps",
		Icon = "weapons/passives/passive_dreadwatch.png",
		PowerCost = 0,
		Upgrades = 2,
		UpgradeList = {"Shock & Awe",  "Power Sinks" },
		UpgradeCost = {1, 2},
		TipImage = {
			Unit = Point(0,3),
			Building = Point(2,2),
		}
	}
	
	function DW_Wiretaps:GetSkillEffect(p1, p2)
		local ret = SkillEffect()
		ret:AddScript([[Board:AddAnimation(Point(2,2),"dreadwatch_mark",ANIM_NO_DELAY)]])
		ret:AddDelay(1)
		local hit = SpaceDamage(Point(2,2),1)
		hit.bHide = true
		ret:AddArtillery(Point(2,5),hit,"effects/shotup_needles.png",FULL_DELAY)
		ret:AddDelay(0.5)
		ret:AddScript([[Board:AddAnimation(Point(2,2),"explo_star_fake",ANIM_NO_DELAY)]])
		ret:AddDelay(1.25)
		return ret
	end

	DW_Wiretaps_A = DW_Wiretaps:new{
		UpgradeDescription = "Gain 2 grid when destroying the CEO tower.",
		Passive = "DW_Wiretaps_A"
	}
	
	DW_Wiretaps_B = DW_Wiretaps:new{
		UpgradeDescription = "When gaining any Grid from failed objectives, gain 1 more.",
		Passive = "DW_Wiretaps_B"
	}
	
	DW_Wiretaps_AB = DW_Wiretaps:new{
		Passive = "DW_Wiretaps_AB"
	}

--==================================================================================================================================--

-- Objective(text,rep,potential,param1,param2,category)

tips:Add{id = "Dreadwatch_MarkedBuilding",title = "Marked Building",text = "Handler needs you to destroy this building to gain extra Reputation. Hit it early, or you may get denied by Grid Defense."}
tips:Add{id = "Dreadwatch_MarkedTower",title = "Marked Building",text = "In missions with a Corporate Tower, it is always your target. Destroy it to take control of the whole island."}

DW_Handler = Pawn:new{
	Name = "Handler",
	Health = 1,
	Image = "",
	MoveSpeed = 0,
	DefaultTeam = TEAM_PLAYER,
	SkillList = {},
	ImpactMaterial = IMPACT_METAL,
	SoundLocation = "/support/vip_truck/",
	Pushable = false,
	Massive = true,
	Neutral = true,
	Portrait = "dw_handler",
}
AddPawn("DW_Handler")

local function overthrowCEO()
	math.randomseed(os.time())
	local raid = SkillEffect()
	local vfx = SpaceDamage(Point(-1,-1),0)
	vfx.sSound = "/impact/generic/explosion"
	vfx.sAnimation = "explo_fire1"
	local vfx2 = SpaceDamage(Point(-1,-1),0)
	vfx2.iFire = EFFECT_CREATE
	vfx2.sSound = "/impact/generic/ricochet"
	vfx2.sAnimation = "dreadwatch_mark"
	raid:AddAirstrike(Point(math.random(0,7),math.random(0,7)),"effects/glider_flyby.png")
	
	vfx.loc = Point(math.random(0,7),math.random(0,7))
	vfx.sAnimation = "explo_fire1"
	raid:AddDamage(vfx)
	vfx2.loc = Board:GetRandomBuilding(true)
	raid:AddDamage(vfx2)
	raid:AddDelay(0.1)
	vfx.loc = Point(math.random(0,7),math.random(0,7))
	vfx.sAnimation = "ExploArt2"
	raid:AddDamage(vfx)
	raid:AddDelay(0.1)
	vfx.loc = Point(math.random(0,7),math.random(0,7))
	vfx.sAnimation = "explo_fire1"
	raid:AddDamage(vfx)
	vfx2.loc = Board:GetRandomBuilding(true)
	raid:AddDamage(vfx2)
	raid:AddDelay(0.1)
	
	raid:AddReverseAirstrike(Point(math.random(0,7),math.random(0,7)),"effects/glider_flyby.png")
	
	vfx.loc = Point(math.random(0,7),math.random(0,7))
	vfx.sAnimation = "ExploArt2"
	raid:AddDamage(vfx)
	vfx2.loc = Board:GetRandomBuilding(true)
	raid:AddDamage(vfx2)
	raid:AddDelay(0.1)
	vfx.loc = Point(math.random(0,7),math.random(0,7))
	vfx.sAnimation = "explo_fire1"
	raid:AddDamage(vfx)
	raid:AddDelay(0.1)
	vfx.loc = Point(math.random(0,7),math.random(0,7))
	vfx.sAnimation = "ExploArt2"
	raid:AddDamage(vfx)
	vfx2.loc = Board:GetRandomBuilding(true)
	raid:AddDamage(vfx2)
	raid:AddDelay(0.1)
	
	raid:AddAirstrike(Point(math.random(0,7),math.random(0,7)),"effects/glider_flyby.png")
	
	vfx.loc = Point(math.random(0,7),math.random(0,7))
	vfx.sAnimation = "explo_fire1"
	raid:AddDamage(vfx)
	vfx2.loc = Board:GetRandomBuilding(true)
	raid:AddDamage(vfx2)
	raid:AddDelay(0.1)
	vfx.sAnimation = "ExploArt2"
	vfx.loc = Point(math.random(0,7),math.random(0,7))
	raid:AddDamage(vfx)
	raid:AddDelay(0.1)
	vfx.loc = Point(math.random(0,7),math.random(0,7))
	vfx.sAnimation = "explo_fire1"
	raid:AddDamage(vfx)
	vfx2.loc = Board:GetRandomBuilding(true)
	raid:AddDamage(vfx2)
	raid:AddDelay(0.1)

	Board:AddEffect(raid)
end

local nextIsland = function(corporation, island)
	GAME.DW_Damageless_Failed = false
	GAME.DW_Repless_Failed = false
end

local endIsland = function()
	if not modApi.achievements:isComplete("hedera_dread_watch", "dw_ach1") and Game:GetReputation() == 13 then -- Infamous
		modApi.achievements:trigger("hedera_dread_watch", "dw_ach1")
	end	
	if not modApi.achievements:isComplete("hedera_dread_watch", "dw_ach2") and not GAME.DW_Precision_Failed then -- Smooth Operator
		modApi.achievements:trigger("hedera_dread_watch", "dw_ach2")
	end	
	if not modApi.achievements:isComplete("hedera_dread_watch", "dw_ach4") and not GAME.DW_Repless_Failed then -- Blacklisted
		modApi.achievements:trigger("hedera_dread_watch", "dw_ach4")
	end	
	if not modApi.achievements:isComplete("hedera_dread_watch", "dw_ach5") and GAME.DW_Corp_Destroyed >= 4 then -- World Domination
		modApi.achievements:trigger("hedera_dread_watch", "dw_ach5")
	end	
end

local function addProxyDialog(tag)
	Board:AddPawn("DW_Handler")
	local target_id = -1
	local pawn_list = Board:GetPawns(TEAM_ANY)
	for i = 0,pawn_list:size() do
		local subject = Board:GetPawn(pawn_list:index(i))
		if subject ~= nil then
			if subject:GetType() == "DW_Handler" then
				target_id = pawn_list:index(i)
			end
		end
	end
	if target_id == -1 then
		LOG("DREAD WATCH DIALOG PROXY FAILED")
		return
	end
	local proxy = Board:GetPawn(target_id)
	proxy:SetSpace(Point(-1,-1))
	local cast = {}
	cast.main = proxy:GetId()
	modapiext.dialog:triggerRuledDialog(tag,cast)
	modApi:scheduleHook(10000, function() 
		Board:RemovePawn(proxy)
	end)
end

local oldClosingMessage = Mission.GetCeoClosing

function Mission:GetCeoClosing(ceo)
	if GAME.DW_CEO_OVERTHROW == true then
		GAME.DW_CEO_OVERTHROW = false
		return "<ANNOUNCING UNANIMOUS SURRENDER>"
	end
	return oldClosingMessage(self, ceo)
end

local missionEnd = function(mission)
	if mission == nil then return end 
	if GAME == nil then return end
	if IsPassiveSkill("DW_Wiretaps") then
		if mission.dw_looted ~= true then DW_Precision_Failed = true end
		 local reward = 0
		 for _,obj in pairs(mission:BaseCompletedObjectives()) do
			if obj.category == REWARD_REP then
				reward = reward + (obj.potential - obj.rep)
				if obj.rep > 1 then 
					GAME.DW_Repless_Failed = true 
				end
			end
		 end
		if reward > 0 and (IsPassiveSkill("DW_Wiretaps_B") or IsPassiveSkill("DW_Wiretaps_AB")) then
			reward = reward + 1
		end
		modApi:scheduleHook(10000, function() -- is there a good condition to replace this with? wait until the end mission stop hiding ui
			Game:AddGridPower(reward)
			if mission.BossMission == true then
				endIsland()		
			end
			if not modApi.achievements:isComplete("hedera_dread_watch", "dw_ach3") and mission.dw_onegrid == true and Game:GetGridPower() >= 4 then -- The Greater Good
				modApi.achievements:trigger("hedera_dread_watch", "dw_ach3")
			end	
		end)
	end
end

local function isCorpoAsset(str)
	return string.lower(str):find("^str_tower") ~= nil
end

local function isCorpoMission(mission)
	local mission = mission or GetCurrentMission()

	return true
		and mission ~= nil
		and isCorpoAsset(mission.AssetId)
end

local function getTargetBuilding()
	local candidates = {}
	for j = 0, 7 do
		for i = 0, 7 do
			local curr = Point(i, j)
			if Board:IsBuilding(curr) then
				if isCorpoAsset(Board:GetUniqueBuilding(curr)) then
					return curr -- always prioritize ceo tower
				elseif not Board:IsUniqueBuilding(curr) then -- allow no other unique buildings
					candidates[#candidates + 1] = curr
				end
			end
		end
	end
	if #candidates < 1 then return end
	return table.remove(candidates, math.random(1, #candidates))
end

local function EVENT_OnBuildingHurt(point, damage)
	local mission = GetCurrentMission()
	if mission == nil then return end
	if IsPassiveSkill("DW_Wiretaps") then
		if point == mission.dw_building_loot then
			mission.dw_looted = true
			if isCorpoAsset(Board:GetUniqueBuilding(point)) then -- CEO OVERTHROW
				GAME.DW_CEO_OVERTHROW = true
				addProxyDialog("DW_LOOT_CEO")
				Board:StartShake(3.5)
				Board:SetFire(point,true)
				
				if options.noOverthrowEffects and not options.noOverthrowEffects.enabled then overthrowCEO() end
				
				if IsPassiveSkill("DW_Wiretaps_A") or IsPassiveSkill("DW_Wiretaps_AB") then Game:AddGridPower(2) end
				if GAME.DW_Corp_Destroyed == nil then 
					GAME.DW_Corp_Destroyed = 1 
				else 
					GAME.DW_Corp_Destroyed = GAME.DW_Corp_Destroyed + 1 
				end
			else
				addProxyDialog("DW_LOOT")
			end
			Game:AddReputation(1)
			Board:AddAnimation(point,"explo_star_fake",ANIM_NO_DELAY)
			customAnim:rem(point, "neon_outline")
		else
			GAME.DW_Precision_Failed = true
			addProxyDialog("DW_LOOT_WRONG")
		end
	end
end
-------------------------------------[ Hex Pilots Compatibility ]-----------------------------
local function GetDelta()
	if Board == nil then
		return false
	end
	for i = 0, 2 do
		local mech = Board:GetPawn(i)
		if mech then
			if mech:IsAbility("MantaSupport") then
				return true
			end
		end
	end
	return false
end

local function PawnKilled(mission, pawn)
	if pawn:GetType() == "Deploy_Manta" then
		addProxyDialog("DW_DRONE_DIES")
	end
end
-----------------------------------------------------------------------------------------------
local missionStart = function(mission)
	if mission == nil then return end 
	if GAME == nil then return end
	if Game:GetGridPower() == 1 then mission.dw_onegrid = true end -- The Greater Good
	if IsPassiveSkill("DW_Wiretaps") then
		local building = getTargetBuilding()
		mission.dw_building_loot = building
		--Board:AddBurst(building,"Rep_Gain",DIR_NONE)
		if building ~= nil then
			Board:AddAnimation(building,"dreadwatch_mark",ANIM_NO_DELAY)
			
			customAnim:add(building, "neon_outline")
		end
		if mission.MapTags[1] == "final_island" then
			addProxyDialog("DW_MISSIONSTART_FINAL")
		elseif mission.BossMission then
			addProxyDialog("DW_MISSIONSTART_CEO")
		elseif GetDelta() then
			addProxyDialog("DW_MISSIONSTART_DELTA")
		else
			addProxyDialog("DW_MISSIONSTART")
		end
	end
end



local function nextTurn(mission)
	if mission ~= nil and mission.dw_building_loot ~= nil then
		if isCorpoAsset(Board:GetUniqueBuilding(mission.dw_building_loot)) then
			tips:Trigger("Dreadwatch_MarkedTower", mission.dw_building_loot)
		else 
			tips:Trigger("Dreadwatch_MarkedBuilding", mission.dw_building_loot)
		end
	end
end



local function EVENT_OnModsLoaded()
	modApi:addMissionStartHook(missionStart)
	modApi:addMissionEndHook(missionEnd)
	modApi:addNextTurnHook(nextTurn)
	modApi:addPreIslandSelectionHook(nextIsland)
	modapiext:addPawnKilledHook(PawnKilled)
end

boardEvents.onBuildingDamaged:subscribe(EVENT_OnBuildingHurt)
modApi.events.onModsLoaded:subscribe(EVENT_OnModsLoaded)
