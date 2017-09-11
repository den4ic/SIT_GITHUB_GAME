----------------
--@By Den4icccc
----------------
function mod_damage_plus_speed_up(keys)
	local player = keys.caster:GetPlayerOwner()
    local pID = player:GetPlayerID()
    local hero = player:GetAssignedHero()
--	local hero = PlayerResource:GetSelectedHeroEntity(pID)
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
		if not hero:HasModifier("modifier_damage_plus_speed_up") then
		hero:RemoveModifierByName("modifier_damage_and_speed_four")
		hero:AddNewModifier(hero, nil, "modifier_damage_plus_speed_up", {})
		SpendLumber(player, lumber_cost)	
    else 
		if hero:HasModifier("modifier_damage_plus_speed_up") then
			ReturnGold(player, gold_cost)
			end
		end
	end
	
	-- if not hero:HasModifier("modifier_damage_and_speed") then
		-- hero:AddNewModifier(hero, nil, "modifier_damage_and_speed", {})
    -- end
	
	caster:AddAbility("damage_vision_agility_up"):SetLevel(1)
	caster:RemoveAbility("damage_plus_speed_up")
end