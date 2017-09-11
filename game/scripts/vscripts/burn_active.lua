----------------
--@By Den4icccc
----------------
function activated(keys)

	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
    local hero = player:GetAssignedHero()
    local caster = keys.caster
	
	local ability = keys.ability
	
    local gold_cost = ability:GetGoldCost(1)
	local lumber_cost = ability:GetLevelSpecialValueFor("lumber_cost", ability:GetLevel()-1)

	local enough_lumber

	--local hero = EntIndexToHScript( keys.caster_entindex )
			

	if gold_cost ~= nil then
		player.lastSpentGold = gold_cost
	end
	
	if lumber_cost ~= nil then
		enough_lumber = CheckLumber(player, lumber_cost,true)
	else
		enough_lumber = true
	end
	
	if gold_cost ~= true and enough_lumber ~= true then
		ReturnGold(player, gold_cost)
		return
	else	
		if not hero:FindAbilityByName("burn_fire_activated") then
				hero:AddAbility("burn_fire_activated")
				SpendLumber(player, lumber_cost)	
    else 
		if hero:FindAbilityByName("burn_fire_activated") then
			ReturnGold(player, gold_cost)
			end
		end
	end
	caster:RemoveAbility("burn_active")
end


	-- if not hero:FindAbilityByName("burn_fire_activated") then
	-- hero:AddAbility("burn_fire_activated")
	-- end
	
	