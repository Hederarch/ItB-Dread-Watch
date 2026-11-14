
local path = mod_loader.mods[modApi.currentMod].resourcePath

modApi:appendAsset("img/weapons/sledge_icon.png", path .."img/weapons/sledge_icon.png")
modApi:appendAsset("img/weapons/dislocator_icon.png", path .."img/weapons/dislocator_icon.png")
modApi:appendAsset("img/weapons/clawmissile_icon.png", path .."img/weapons/clawmissile_icon.png")

Weapon_Load_Up = Emitter:new{
	image = "combat/icons/icon_doubleshot_glow.png",
	x = -12,
	y = 5,
	max_alpha = 1.0,
	min_alpha = 1.0,
	angle = -90,
	rot_speed = 0,
	angle_variance = 0,
	random_rot = false,
	lifespan = 0.75,
	burst_count = 1,
	speed = 0.75,
	birth_rate = 0,
	gravity = false,
	layer = LAYER_FRONT
}

--==================================================================================================================================--

DW_TC_Repeater = TankDefault:new{ 
	Name = "Crasher Charge",
	Class = "Brute",
	Description = "Fire a shaped explosive which splits off an additional projectile.",
	Icon = "weapons/sledge_icon.png",
	LaunchSound = "/weapons/modified_cannons",
	Exploart = "explopush1_",
	ImpactSound = "",
	TwoClick = true,
--	ZoneTargeting = ZONE_DIR,
	Damage = 1,
	ZoneTargeting = ZONE_DIR,
	BuildingDamage = true,
	AllyDamage = true,
	Repeat = false,
	Split = false,
	Upgrades = 2,
	UpgradeList = { "Flak Catcher",  "Ally Immune"  },
	UpgradeCost = {2, 2},
	TipImage = {
		Unit = Point(1,3),
		Enemy = Point(1,1),
		Enemy2 = Point(3,1),
		Target = Point(1,1),
		Second_Click = Point(3,1),
	}
}

function DW_TC_Repeater:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  
	local damage = SpaceDamage(target, self.Damage, direction)
	if not self.AllyDamage and Board:IsPawnTeam(target, TEAM_PLAYER) then damage.iDamage = DAMAGE_ZERO 	end 
	if not self.BuildingDamage and Board:IsBuilding(target) then	damage.iDamage = DAMAGE_ZERO 	end 
	damage.sSound = "/impact/generic/ricochet"
	ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)--"effects/shot_mechtank")
		
	return ret
end

function DW_TC_Repeater:GetSecondTargetArea(p1, p2)
	local direction = GetDirection(p2 - p1)
	local ret = PointList()
	local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  
	--local dirs = {(direction + 1) % 4, (direction - 1) % 4}
	local dirs = {0,1,2,3}
	for j, dir in ipairs(dirs) do
		for i = 1, 8 do
			local curr = Point(target + DIR_VECTORS[dir] * i)
			if not Board:IsValid(curr) then
				break
			end
			ret:push_back(curr)
			if Board:IsBlocked(curr,PATH_PROJECTILE) then
				break
			end
		end
	end
	
	return ret	
end

--this is only used for touch controls, customizing what counts as the same "group" for targeting purposes
function DW_TC_Repeater:GetSecondTargetZone(points)	
	local origin = points:index(1)
	local p1 = points:index(2)
	local p2 = points:index(3)
	
	local targets = self:GetSecondTargetArea(origin, p1)
	local ret = PointList()
		
	local dir = GetDirection(p2-p1)
	for i = 1, targets:size() do
		if GetDirection(targets:index(i) - p1) == dir then
			ret:push_back(targets:index(i))
		end
	end

	return ret
end

function DW_TC_Repeater:TranslateFirstClick(p1, p2)
	return GetProjectileEnd(p1,p2,PATH_PROJECTILE)  
end

--strange ordering of events needed to make sure the projectile bounces immediately and isn't delayed
--by the push animation. WHY ISN'T THIS NEEDED FOR ARTILLERY PROJECTILES!?
function DW_TC_Repeater:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local first_dir = GetDirection(p2 - p1)
	local first_tar = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  

	local second_dir = GetDirection(p3 - p2)
	local second_reverse = GetDirection(p2 - p3)
	local second_tar = GetProjectileEnd(p2,p3,PATH_PROJECTILE)  
	local reverse_tar = GetProjectileEnd(p2,p2 + DIR_VECTORS[second_reverse],PATH_PROJECTILE)
	
	local pushdam = SpaceDamage(p1,0)
	pushdam.sAnimation = "airpush_"..first_dir
	ret:AddDamage(pushdam)
	
	ret:AddProjectile(SpaceDamage(first_tar), self.ProjectileArt)
	
	if Board:IsValid(p3) then
		local damage = SpaceDamage(second_tar,self.Damage,second_dir)
		damage.sSound = "/impact/generic/explosion"
		damage.sAnimation = self.Exploart..second_dir
		--[[if not self.AllyDamage and Board:IsPawnTeam(second_tar, TEAM_PLAYER) then 
			damage.iDamage = DAMAGE_ZERO 	
			damage.sAnimation = "airpush_"..second_dir
		end
--]]		
		ret:AddProjectile(p2, damage, self.ProjectileArt, NO_DELAY)
		
		if self.Split then
			local second_damage = SpaceDamage(reverse_tar,self.Damage,second_reverse)
			second_damage.sSound = "/impact/generic/explosion"
			second_damage.sAnimation = self.Exploart..second_reverse
			ret:AddProjectile(p2, second_damage, self.ProjectileArt, 0.25)
		end
	end
	
	local damage = SpaceDamage(first_tar, self.Damage, second_reverse)
	damage.sSound = "/impact/generic/ricochet"
	damage.sAnimation = self.Exploart..second_reverse
	if not self.AllyDamage and Board:IsPawnTeam(first_tar, TEAM_PLAYER) or (not self.BuildingDamage and Board:IsBuilding(first_tar)) then 
		damage.iDamage = DAMAGE_ZERO 	
		damage.sAnimation = "airpush_"..second_reverse
	end 
	ret:AddDamage(damage)
	
	if self.Repeat and second_tar == p1 then
		ret:AddScript(string.format("local target = Point(%d,%d) local pawn = Board:GetPawn(target) Board:Ping(target,GL_Color(75, 250, 75, 0.75)) pawn:SetActive(true) pawn:SetMovementSpent(true)", p1.x, p1.y))
		ret:AddBurst(p1,"Weapon_Load_Up",DIR_NONE)
	end
	
	return ret
end

DW_TC_Repeater_A = DW_TC_Repeater:new{
	UpgradeDescription = "When shooting yourself, shoot again.",
	Repeat = true,
	TipImage = {
		Unit = Point(2,1),
		Enemy2 = Point(2,3),
		Target = Point(2,3),
		Second_Click = Point(2,1),
	}
}

DW_TC_Repeater_B = DW_TC_Repeater:new{
	UpgradeDescription = "The first hit can pass through allies and buildings. The next hit still damages everyone.",
	AllyDamage = false,
	BuildingDamage = false,
	TipImage = {
		Unit = Point(1,3),
		Building = Point(1,1),
		Enemy2 = Point(3,1),
		Target = Point(1,1),
		Second_Click = Point(3,1),
	}
}

DW_TC_Repeater_AB = DW_TC_Repeater:new{
	Repeat = true,
	AllyDamage = false,
	BuildingDamage = false,
	TipImage = {
		Unit = Point(2,1),
		Building = Point(2,3),
		Target = Point(2,3),
		Second_Click = Point(2,1),
	}
}

--==================================================================================================================================--

DW_Telepunch = Skill:new{  
	Name = "Dislocator",
	Class = "Prime",
	Description = "Project a force to strike close and distant targets.",
	Icon = "weapons/dislocator_icon.png",
	Rarity = 3,
	LaunchSound = "/weapons/force_swap",
	PathSize = INT_MAX,
	Damage = 1,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Phasing",  "+1 Damage"  },
	UpgradeCost = { 1 , 2 },
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,3),
		Enemy2 = Point(2,1),
		Target = Point(2,1),
	}
}
			
function DW_Telepunch:GetTargetArea(p1)

	local ret = PointList()

	for dir = DIR_START, DIR_END do
		for i = 2, 8 do
			local curr = Point(p1 + DIR_VECTORS[dir] * i)
			if not Board:IsValid(curr) then
				break
			end
			
			ret:push_back(curr)
			
			if Board:IsBlocked(curr,PATH_PROJECTILE) then
				break
			end
		end
	end

	return ret
	
end
			
function DW_Telepunch:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local fake = SpaceDamage(p1 + DIR_VECTORS[direction], 0)
	fake.bHide = true
	ret:AddMelee(p1,fake)
	
	local damage = SpaceDamage(p1 + DIR_VECTORS[direction], self.Damage, direction)
	damage.sAnimation = "explopunch1_"..direction
	local copy = SpaceDamage(p2, self.Damage, direction)
	copy.sAnimation = "explopunch1_"..direction
	ret:AddDamage(copy)
	if p1:Manhattan(p2) == 2 then -- 'distant' target is next to adjacent
	ret:AddDelay(0.25) -- wait until space is clear, prevent bump
	end
	ret:AddDamage(damage)
	return ret
end	

DW_Telepunch_A = DW_Telepunch:new{
	UpgradeDescription = "Can project punches past multiple obstacles.",
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,3),
		Enemy2 = Point(2,1),
		Enemy3 = Point(2,2),
		Target = Point(2,1),
	}
}

function DW_Telepunch_A:GetTargetArea(point)
	local ret = PointList()
	
	for dir = DIR_START, DIR_END do
		for i = 2, 8 do
			local curr = Point(point + DIR_VECTORS[dir] * i)
			if not Board:IsValid(curr) then
				break
			end
			ret:push_back(curr)
		end
	end
	
	return ret
end

DW_Telepunch_B = DW_Telepunch:new{
	UpgradeDescription = "Increases damage by 1.",
	Damage = 2,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,3),
		Enemy2 = Point(2,1),
		Target = Point(2,1),
	}
}

DW_Telepunch_AB = DW_Telepunch_A:new{
	Damage = 2,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,3),
		Enemy2 = Point(2,1),
		Enemy3 = Point(2,2),
		Target = Point(2,1),
	}
}
--==================================================================================================================================--

DW_Rockets = ArtilleryDefault:new{
	Name = "Claw Rockets",
	Description = "Fire two rockets which pull their targets.",
	Class = "Ranged",
	Icon = "weapons/clawmissile_icon.png",
	Rarity = 1,
	Explosion = "",
	ExploArt = "explopush1_",
	Damage = 2,
	BounceAmount = 2,
	PowerCost = 1, --AE Change
	Upgrades = 2,
	UpgradeCost = {2,2},
	UpgradeList = { "+1 Damage","+1 Damage" },
	LaunchSound = "/weapons/dual_missiles",
	ImpactSound = "/impact/generic/explosion",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(1,1),
		Enemy2 = Point(3,1),
		Target = Point(2,1)
	}
}		

function DW_Rockets:GetSkillEffect(p1, p2)	
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local pull = GetDirection(p1 - p2)
	
	local damage = SpaceDamage(p2 + DIR_VECTORS[(direction+1)%4], self.Damage, pull)
	local damage2 = SpaceDamage(p2 + DIR_VECTORS[(direction-1)%4], self.Damage, pull)
	
	
	ret:AddBounce(p1, 1)
	--this is not the most elegant script ever.
	
	---dummy artillery shots for the visual
	---it has actual art when fired, but hidden when aiming
	local dummy = SpaceDamage(damage.loc)
	dummy.bHide = true
	dummy.sAnimation = self.ExploArt..pull
	ret:AddArtillery(dummy,"effects/shotup_needles.png",NO_DELAY)
	dummy.loc = damage2.loc
	ret:AddArtillery(dummy,"effects/shotup_needles.png",NO_DELAY)
	
	--invisible artillery shot for actual damage and projectile pathing
	--it has no art when fired, but visuals when aiming
	ret:AddArtillery(SpaceDamage(p2),"")
	ret:AddDamage(damage)
	ret:AddDamage(damage2)
	
	ret:AddBounce(p2 + DIR_VECTORS[(direction+1)%4], self.BounceAmount)
	ret:AddBounce(p2 + DIR_VECTORS[(direction-1)%4], self.BounceAmount)
	return ret
end		

DW_Rockets_A = DW_Rockets:new{
	Damage = 3,
	ExploArt = "explopush2_",
	BounceAmount = 3,
	UpgradeDescription = "Increases damage by 1."
}

DW_Rockets_B = DW_Rockets:new{
		Damage = 3,
		ExploArt = "explopush2_",
		BounceAmount = 3,
		UpgradeDescription = "Increases damage by 1."
}

DW_Rockets_AB = DW_Rockets:new{
		Damage = 4,
		ExploArt = "explopush2_",
		BounceAmount = 4,
}