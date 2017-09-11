----------------
--@By Den4icccc
----------------
function create_wood(keys)

	local player = keys.caster:GetPlayerOwner()
    local pID = player:GetPlayerID()
    local hero = player:GetAssignedHero()
    local caster = keys.caster
	
	-- если у локального героя нет абилки ant_ulti_test значит добавляет её 
	if not hero:FindAbilityByName("sniper_assassinate_wars_test") then
	hero:AddAbility("sniper_assassinate_wars_test")
	end
	
	--caster:AddAbility("petri_empty2")
	
	-- if hero:FindAbilityByName("sniper_assassinate_wars_test" and "ant_ulti_test") then -- 03.09.2017 off
	-- caster:AddAbility("petri_upgrade_sawmill"):SetLevel(1) 
	-- end
	
	caster:RemoveAbility("create_woodii")
	-- local player = keys.caster:GetPlayerOwner()
	-- local pID = player:GetPlayerID()
	-- local caster = keys.caster

	-- local ability = keys.ability
	
	-- local gold_cost = ability:GetGoldCost(1)
	-- local lumber_cost = ability:GetLevelSpecialValueFor("lumber_cost", ability:GetLevel()-1)
	-- local food_cost = ability:GetLevelSpecialValueFor("food_cost", ability:GetLevel()-1)

	-- local enough_lumber
	-- local enough_food

	-- local create_woods = EntIndexToHScript( keys.caster_entindex )
			
	-- if gold_cost ~= nil then
		-- player.lastSpentGold = gold_cost
	-- end

	-- if lumber_cost ~= nil then
		-- enough_lumber = CheckLumber(player, lumber_cost,true)
	-- else
		-- enough_lumber = true
	-- end

	-- if food_cost ~= nil and food_cost ~= 0 then
		-- enough_food = CheckFood(player, food_cost,true)
	-- else
		-- enough_food = true
	-- end
	
	-- if enough_food ~= true or enough_lumber ~= true then
		-- return
	-- else
		-- for itemSlot = 0, 1, 2 do 
			-- local Item = create_woods:GetItemInSlot( itemSlot )
			-- create_woods:AddItemByName("item_wood_damage")
			-- SpendLumber(player, lumber_cost)
			-- SpendFood(player, food_cost)
		-- end
	-- end
	
	-- caster:RemoveAbility("create_woodii")
	-- caster:AddAbility("ant_ulti"):SetLevel(1)
	-- if caster:FindAbilityByName("ant_ulti" and "build_petri_tower_basic") then
	-- caster:AddAbility("petri_upgrade_sawmill"):SetLevel(1) 
	-- end
	
end
