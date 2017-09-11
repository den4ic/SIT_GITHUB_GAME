function build( keys )
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local caster = keys.caster
    local hero = player:GetAssignedHero() -- local hero = PlayerResource:GetSelectedHeroEntity(pID)
	local ability = keys.ability
	
	local gold_cost = ability:GetGoldCost(1)
	local lumber_cost = ability:GetLevelSpecialValueFor("lumber_cost", ability:GetLevel()-1)
	local food_cost = ability:GetLevelSpecialValueFor("food_cost", ability:GetLevel()-1)

	local enough_lumber
	local enough_food
	
	
	-- Cancel building
	if player.waitingForBuildHelper == true then
		PlayerResource:ModifyGold(pID, gold_cost,false,0)

	    player.activeCallbacks.onConstructionCancelled()
	      
	    player.activeBuilder:ClearQueue()
	    player.activeBuilding = nil
	    player.activeBuilder:Stop()
	    player.activeBuilder.ProcessingBuilding = false

	    player.waitingForBuildHelper = false

	    CustomGameEventManager:Send_ServerToPlayer(player, "building_helper_force_cancel", {} )
		return
	end

	if gold_cost ~= nil then
		player.lastSpentGold = gold_cost
	end

	if lumber_cost ~= nil then
		enough_lumber = CheckLumber(player, lumber_cost,true)
	else
		enough_lumber = true
	end

	if food_cost ~= nil and food_cost ~= 0 then
		enough_food = CheckFood(player, food_cost,true)
	else
		enough_food = true
	end

	
	
	if enough_food ~= true or enough_lumber ~= true then
		return
	else
		SpendLumber(player, lumber_cost)
		SpendFood(player, food_cost)
	end

	player.waitingForBuildHelper = true
	
	local returnTable = BuildingHelper:AddBuilding(keys)

	keys:OnBuildingPosChosen(function(vPos)
		--print("OnBuildingPosChosen")
		-- in WC3 some build sound was played here.
	end)

	keys:OnConstructionStarted(function(unit)
	--[[	if unit:GetUnitName() == "npc_petri_exit" then
			Notifications:TopToAll({text="#exit_construction_is_started", duration=10, style={color="blue"}, continue=false})

			local tower = Entities:FindByClassname(nil, "npc_petri_exploration_tower")
			if tower ~= nil then
				tower:GetAbilityByIndex(0):CreateVisibilityNode(unit:GetAbsOrigin()+Vector(0,0,500), 1200, 5)
			end
		end]]

		-- Unit is the building be built.
		-- Play construction sound
		-- FindClearSpace for the builder
		FindClearSpaceForUnit(keys.caster, keys.caster:GetAbsOrigin(), true)
		unit.foodSpent = food_cost
		-- Very bad solution
		-- But when construction is started there is no way of cancelling it so...
		player.activeBuilder.work.callbacks.onConstructionCancelled = nil

		if caster:GetUnitName() == "npc_dota_hero_omniknight" then
			if caster.currentMenu == 1 then
				caster:CastAbilityNoTarget(caster:FindAbilityByName("close_basic_buildings_menu"), pID)
			elseif caster.currentMenu == 2 then
				caster:CastAbilityNoTarget(caster:FindAbilityByName("close_advanced_buildings_menu"), pID)
			end
		end
		
			if hero:FindAbilityByName("burn_fire_activated") then
			unit:RemoveAbility("burn_active")		
			end
			if hero:FindAbilityByName("sniper_assassinate_wars_test") then
			unit:RemoveAbility("create_woodii")		
			end
			if hero:FindAbilityByName("ant_ulti_test") then
			unit:RemoveAbility("create_woodi")		
			end
			
			if hero:FindModifierByName("modifier_vision_ability") then
			unit:RemoveAbility("vision_mod")
			end 
			if hero:FindModifierByName("modifier_speed_ability") then
			unit:RemoveAbility("speed_mod")
			end 
			
			if hero:HasModifier("modifier_speed_ability") and hero:HasModifier("modifier_vision_ability") then
			unit:AddAbility("re_speed_mod"):SetLevel(1)
			end
			
			if hero:FindModifierByName("re_modifier_speed_ability") then
			unit:RemoveAbility("re_speed_mod")
			unit:RemoveAbility("speed_mod")
			end 
			
			if hero:FindModifierByName("re_modifier_speed_ability") then
			unit:AddAbility("damage_and_speed_mod"):SetLevel(1)
			end
			
			if hero:FindModifierByName("modifier_damage_and_speed") then
			unit:RemoveAbility("re_speed_mod")
			unit:RemoveAbility("speed_mod")
			end 		
			
			if hero:FindModifierByName("modifier_damage_and_speed_two") then
			unit:RemoveAbility("speed_mod")
			end
			
			if hero:FindModifierByName("modifier_damage_and_speed_three") then
			unit:RemoveAbility("speed_mod")
			end
			
			if hero:FindModifierByName("modifier_damage_and_speed_four") then
			unit:RemoveAbility("speed_mod")
			end
			
			-- damage_plus_speed_up
			if hero:FindModifierByName("modifier_damage_plus_speed_up") then
			unit:RemoveAbility("speed_mod")
			end
			
			-- damage_vision_agility_up
			if hero:FindModifierByName("modifier_damage_vision_agility_up") then
			unit:RemoveAbility("speed_mod")
			unit:RemoveAbility("vision_mod")
			end	
			
			-- 1 do 4
			if hero:FindModifierByName("modifier_damage_and_speed") then
			unit:AddAbility("damage_and_speed_mod_two"):SetLevel(1)
			end
			
			if hero:FindModifierByName("modifier_damage_and_speed_two") then
			unit:AddAbility("damage_and_speed_mod_three"):SetLevel(1)
			end
			
			if hero:FindModifierByName("modifier_damage_and_speed_three") then
			unit:AddAbility("damage_and_speed_mod_four"):SetLevel(1)
			end
			
			-- damage_plus_speed_up
		    if hero:FindModifierByName("modifier_damage_and_speed_four") then
			unit:AddAbility("damage_plus_speed_up"):SetLevel(1)
			end
			
			-- damage_vision_agility_up
			if hero:FindModifierByName("modifier_damage_plus_speed_up") then
			unit:AddAbility("damage_vision_agility_up"):SetLevel(1)
			end
			
		if hero:FindAbilityByName("ant_ulti_test") and hero:FindAbilityByName("sniper_assassinate_wars_test") then
		unit:AddAbility("petri_empty1"):SetLevel(1) 
		end
			
		unit:SetMana(0)
		unit.tempManaRegen = unit:GetManaRegen()
		unit:SetBaseManaRegen(0.0)
	end)
	keys:OnConstructionCompleted(function(unit)
		--[[if unit:GetUnitName() == "npc_petri_exit" then
			Notifications:TopToAll({text="#kvn_win", duration=100, style={color="green"}, continue=false})

			for i=1,10 do
				PlayerResource:SetCameraTarget(i-1, unit)
			end

			Timers:CreateTimer(5.0,
		    function()
		      GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS) 
		    end)
		end]]

		-- Play construction complete sound.
		-- Give building its abilities
		-- add the mana
		unit:SetMana(unit:GetMaxMana())
		unit:SetBaseManaRegen(unit.tempManaRegen)
		unit.tempManaRegen = nil
	--	unit:AddNewModifier(unit, nil, "modifier_kill", {duration = 120.0})  -- модификатор время жизни юнита
	
		if unit.controllableWhenReady then
			unit:SetControllableByPlayer(keys.caster:GetPlayerOwnerID(), true)
		end

		InitAbilities(unit)
		
		if caster.currentArea ~= nil then
			if CheckAreaClaimers(caster, keys.caster.currentArea.claimers) or caster.currentArea.claimers == nil then

				if caster.currentArea.claimers == nil then 
					Notifications:Top(pID, {text="#area_claimed", duration=4, style={color="white"}, continue=true})
				end

				keys.caster.currentArea.claimers = keys.caster.currentArea.claimers or {}
				if keys.caster.currentArea.claimers[0] == nil then keys.caster.currentArea.claimers[0] = keys.caster end
			else
				Notifications:Top(pID, {text="#you_cant_build", duration=4, style={color="white"}, continue=false})
				
				ReturnLumber(player)
				ReturnGold(player)
				ReturnFood( player )

				-- Destroy unit
				DestroyEntityBasedOnHealth(caster,unit)
			end
		end
	end)

	-- These callbacks will only fire when the state between below half health/above half health changes.
	-- i.e. it won't unnecessarily fire multiple times.
	keys:OnBelowHalfHealth(function(unit)
	end)

	keys:OnAboveHalfHealth(function(unit)

	end)

	keys:OnConstructionFailed(function( building )
		ReturnLumber(player)
		ReturnGold(player)
		ReturnFood( player )
	end)

	keys:OnConstructionCancelled(function( building )
		ReturnLumber(player)
		ReturnGold(player)
		ReturnFood( player )
	end)

	-- Have a fire effect when the building goes below 50% health.
	-- It will turn off it building goes above 50% health again.
--	keys:EnableFireEffect("modifier_jakiro_liquid_fire_burn")

  	if caster:GetUnitName() then
		local basicMenu = caster:FindAbilityByName("close_basic_buildings_menu")
		local advancedMenu = caster:FindAbilityByName("close_advanced_buildings_menu")

		if basicMenu ~= nil then
			caster:CastAbilityNoTarget(basicMenu, pID)
		else
			caster:CastAbilityNoTarget(advancedMenu, pID)
		end
	end	
end

function building_canceled( keys )
	BuildingHelper:CancelBuilding(keys)
end

function create_building_entity( keys )
	BuildingHelper:InitializeBuildingEntity(keys)
end

function builder_queue( keys )
  local ability = keys.ability
  local caster = keys.caster  

  if caster.ProcessingBuilding ~= nil then
    -- caster is probably a builder, stop them
    player = PlayerResource:GetPlayer(caster:GetMainControllingPlayer())
    player.activeBuilder:ClearQueue()
    player.activeBuilding = nil
    player.activeBuilder:Stop()
    player.activeBuilder.ProcessingBuilding = false
  end
end