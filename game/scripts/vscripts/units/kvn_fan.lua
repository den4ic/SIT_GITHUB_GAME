NO_MENU = 0
BASIC_MENU = 1
ADVANCED_MENU = 2
ADD_MENU = 3

NO_MENU_ABILITIES = {"open_basic_buildings_menu",
					 "open_advanced_buildings_menu",
					 "gather_lumber",
					 "repair",
					 "get_the_stone",
					 --"testmp", -- ЗАКОМПЕЛИРОВАН
	     			 "playerfood", 
					 "cold_aura",				 
					 --"hunger_aura_food", -- ЗАКОМПЕЛИРОВАН
					 "return_resources"}
BASIC_MENU_ABILITIES = {"build_petri_sawmill",
                        "burn_fire",
                        "close_basic_buildings_menu"}
ADVANCED_MENU_ABILITIES = {"create_wood",
						   "sniper_assassinate_wars", 
             			   "ant_ulti",						   
						   "close_advanced_buildings_menu"} 

ADD_MENU_ABILITIES = {"ant_ulti_test"}
						   

function GivePermissionToBuild( keys )
	local caster = keys.caster
	local target = keys.target
	local caster_team = caster:GetTeamNumber()
	local player = caster:GetPlayerOwnerID()
	local ability = keys.ability

	if CheckAreaClaimers(target, caster.currentArea.claimers) == true then return false end

	if caster.currentArea ~= nil and caster.currentArea.claimers ~= nil then
		if target.currentArea == caster.currentArea then
			if caster.currentArea.claimers[0] == caster then
				caster.currentArea.claimers[#caster.currentArea.claimers + 1] = target
			end
		end
	end
end
  
--function Blink(keys)
--	local point = keys.target_points[1]
--	local caster = keys.caster
--	local casterPos = caster:GetAbsOrigin()
--	local difference = point - casterPos
--	local ability = keys.ability
--	local range = ability:GetLevelSpecialValueFor("blink_range", (ability:GetLevel() - 1))
--
--	if difference:Length2D() > range then
--		point = casterPos + (point - casterPos):Normalized() * range
--	end
--
--	FindClearSpaceForUnit(caster, point, false)	
--end

function GetLumberAbilityName(caster)
	local lumberAbility = "gather_lumber"
	if caster:HasModifier("modifier_gathering_lumber") or caster:HasModifier("modifier_returning_resources") then lumberAbility = "return_resources" end
	return lumberAbility
end

function CloseAllMenus(entity)
	local keys = {}
	keys.caster = entity
	if entity.currentMenu == 1 then
		CloseBasicBuildingsMenu(keys)
	elseif entity.currentMenu == 2 then
		CloseAdvancedBuildingsMenu(keys)
	end
end

function OpenBasicBuildingsMenu(keys)
	local caster = keys.caster

	caster.currentMenu = 1

	for i=1, table.getn(BASIC_MENU_ABILITIES) do
		caster:AddAbility(BASIC_MENU_ABILITIES[i])
    end

	    isyhitkostor(caster)
		NotInit1(caster)
		NotInit2(caster)
	--InitAbilities(caster)

	for i=1, table.getn(BASIC_MENU_ABILITIES) do
		if NO_MENU_ABILITIES[i] == "gather_lumber" then
			caster:SwapAbilities(GetLumberAbilityName(caster), BASIC_MENU_ABILITIES[i], false, true)
		else
			caster:SwapAbilities(NO_MENU_ABILITIES[i], BASIC_MENU_ABILITIES[i], false, true)
		end
    end
end

function CloseBasicBuildingsMenu(keys)
	local caster = keys.caster

	local lumberAbility = GetLumberAbilityName(caster)

	caster.currentMenu = 0

	for i=1, table.getn(BASIC_MENU_ABILITIES) do
		if NO_MENU_ABILITIES[i] == "gather_lumber" then
			caster:SwapAbilities(GetLumberAbilityName(caster), BASIC_MENU_ABILITIES[i], true, false)
		else
			caster:SwapAbilities(NO_MENU_ABILITIES[i], BASIC_MENU_ABILITIES[i], true, false)
		end
    end

	for i=1, table.getn(BASIC_MENU_ABILITIES) do
		caster:RemoveAbility(BASIC_MENU_ABILITIES[i])
    end
end


function Spawn( event )
	-- thisEntity:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK) -- Fix Bugs fish1 
	
	-- for i=0, thisEntity:GetAbilityCount()-1 do
		-- if thisEntity:GetAbilityByIndex(i) ~= nil then
			-- thisEntity:RemoveAbility(thisEntity:GetAbilityByIndex(i):GetName())
		-- end
		-- if thisEntity:GetAbilityByIndex(i):GetName() ~= "ant_ulti_test" then
		-- thisEntity:RemoveAbility(thisEntity:GetAbilityByIndex(i):GetName())
		-- end
    --end
	
		for i=0, thisEntity:GetAbilityCount()-1 do
			if thisEntity:GetAbilityByIndex(i) ~= nil and thisEntity:GetAbilityByIndex(i):GetName() ~="ant_ulti_test" 
			and thisEntity:GetAbilityByIndex(i):GetName() ~="sniper_assassinate_wars_test" 
			and thisEntity:GetAbilityByIndex(i):GetName() ~="burn_fire_activated" then
				thisEntity:RemoveAbility(thisEntity:GetAbilityByIndex(i):GetName())		
					
			end
		end
		
		-- Либо если чутка не так сформулировал что нужно то,

		-- for i=0, thisEntity:GetAbilityCount()-1 do
			-- if thisEntity:GetAbilityByIndex(i) ~= nil and i ~= 2 then
				-- thisEntity:RemoveAbility(thisEntity:GetAbilityByIndex(i):GetName())		
					
			-- end
		-- end
	
	for i=1, table.getn(NO_MENU_ABILITIES) do
		thisEntity:AddAbility(NO_MENU_ABILITIES[i])
    end
	
		-- if thisEntity:FindAbilityByName("repair") then
	-- for i=1, table.getn(ADD_MENU_ABILITIES) do
		-- thisEntity:AddAbility(ADD_MENU_ABILITIES[i])
    -- end
	-- end
	
	isyhitkostor(thisEntity)
    kinytkamen(thisEntity)
	bred(thisEntity)
	InitAbilities(thisEntity)
end

function OpenAdvancedBuildingsMenu(keys)
	local caster = keys.caster

	caster.currentMenu = 2

	for i=1, table.getn(ADVANCED_MENU_ABILITIES) do
		caster:AddAbility(ADVANCED_MENU_ABILITIES[i])
    end

	--InitAbilities(caster)
    InitAbil(caster)
	--InitAntUlti(caster)
	--InitAntUlti(caster)
	bred(caster)
	--test(caster)
	kinytkamen(caster)
	woods_process(caster)
	
    for i=1, table.getn(ADVANCED_MENU_ABILITIES) do
		if NO_MENU_ABILITIES[i] == "gather_lumber" then
			caster:SwapAbilities(GetLumberAbilityName(caster), ADVANCED_MENU_ABILITIES[i], false, true)
		else
			caster:SwapAbilities(NO_MENU_ABILITIES[i], ADVANCED_MENU_ABILITIES[i], false, true)
		end
    end
end

function bred(hero)
 if hero:FindAbilityByName("ant_ulti_test") then
  for i=0, hero:GetAbilityCount()-1 do
    local abil = hero:GetAbilityByIndex(i)
    if abil ~= nil and abil:GetName() == "ant_ulti"  then
      if hero:IsHero() and hero:GetAbilityPoints() > 0 then
         hero:UpgradeAbility(abil)
      else
        abil:SetLevel(1)
      end
    end
  end
 end
end


function kinytkamen(hero)
 if hero:FindAbilityByName("sniper_assassinate_wars_test") then
  for i=0, hero:GetAbilityCount()-1 do
    local abil = hero:GetAbilityByIndex(i)
    if abil ~= nil and abil:GetName() == "sniper_assassinate_wars"  then
      if hero:IsHero() and hero:GetAbilityPoints() > 0 then
         hero:UpgradeAbility(abil)
      else
        abil:SetLevel(1)
      end
    end
  end
 end
end


function isyhitkostor(hero)
 if hero:FindAbilityByName("burn_fire_activated") then
  for i=0, hero:GetAbilityCount()-1 do
    local abil = hero:GetAbilityByIndex(i)
    if abil ~= nil and abil:GetName() == "burn_fire"  then
      if hero:IsHero() and hero:GetAbilityPoints() > 0 then
         hero:UpgradeAbility(abil)
      else
        abil:SetLevel(1)
      end
    end
  end
 end
end

function NotInit1( hero )       -- lvlup all ability
  for i=0, hero:GetAbilityCount()-1 do
    local abil = hero:GetAbilityByIndex(i)
    if abil ~= nil and abil:GetName() == "build_petri_sawmill" then
      if hero:IsHero() and hero:GetAbilityPoints() > 0 then
         hero:UpgradeAbility(abil)
      else
        abil:SetLevel(1)
      end
    end
  end
end	

function NotInit2( hero )       -- lvlup all ability
  for i=0, hero:GetAbilityCount()-1 do
    local abil = hero:GetAbilityByIndex(i)
    if abil ~= nil and abil:GetName() == "close_basic_buildings_menu"  then
      if hero:IsHero() and hero:GetAbilityPoints() > 0 then
         hero:UpgradeAbility(abil)
      else
        abil:SetLevel(1)
      end
    end
  end
end	

function woods_process(hero)
  for i=0, hero:GetAbilityCount()-1 do
    local abil = hero:GetAbilityByIndex(i)
    if abil ~= nil and abil:GetName() == "create_wood"  then
      if hero:IsHero() and hero:GetAbilityPoints() > 0 then
        hero:UpgradeAbility(abil)
      else
        abil:SetLevel(1)
      end
    end
  end
end

-- function bred(hero)
-- local ability
-- if ability then 
   -- ability = 1
 -- if hero:FindAbilityByName("ant_ulti_test") then
  -- for i=0, hero:GetAbilityCount()-1 do
    -- local abil = hero:GetAbilityByIndex(i)
    -- if abil ~= nil and abil:GetName() == "ant_ulti"  then
      -- if hero:IsHero() and hero:GetAbilityPoints() > 0 then
         -- hero:UpgradeAbility(abil)
      -- else
        -- abil:SetLevel(1)
      -- end
    -- end
  -- end
 -- end
 -- elseif ability > 1 then
-- abil:SetLevel(0)
-- end
-- end


function CloseAdvancedBuildingsMenu(keys)
	local caster = keys.caster

	local lumberAbility = GetLumberAbilityName(caster)

	caster.currentMenu = 0

	for i=1, table.getn(ADVANCED_MENU_ABILITIES) do
		if NO_MENU_ABILITIES[i] == "gather_lumber" then
			caster:SwapAbilities(GetLumberAbilityName(caster), ADVANCED_MENU_ABILITIES[i], true, false)
		else
			caster:SwapAbilities(NO_MENU_ABILITIES[i], ADVANCED_MENU_ABILITIES[i], true, false)
		end
    end

	for i=1, table.getn(ADVANCED_MENU_ABILITIES) do
		caster:RemoveAbility(ADVANCED_MENU_ABILITIES[i])
    end
end

function SpawnGoldBag( keys )
	local caster = keys.caster

	local bag = CreateUnitByName("npc_petri_gold_bag", caster:GetAbsOrigin(), true, nil, caster, DOTA_TEAM_GOODGUYS)
	bag:SetControllableByPlayer(caster:GetPlayerOwnerID(), false)
end

function Deny(keys)
	local caster = keys.caster
	local target = keys.target

	local damageTable = {
		victim = target,
		attacker = caster,
		damage = target:GetMaxHealth(),
		damage_type = DAMAGE_TYPE_PURE,
	}
 
	if target:HasAbility("petri_building") == true and target:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
		ApplyDamage(damageTable)
	end
end