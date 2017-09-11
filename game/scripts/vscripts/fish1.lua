--[[function fish1(event)
    local unit = event.activator
	local units = FindUnitsInRadius (event.activator:GetTeam(), event.activator:GetAbsOrigin(), nil, 0, 
	DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
   -- if event.activator:HasItemInInventory("item_meat") then
   
	   if units[1] then 
	if units[1]:IsHero() then
	--units[1]:AddNewModifier(units[1], nil, "modifier_invulnerable", {})
	if event.activator:HasItemInInventory("item_fishing_rod") then
	units[1]:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK) -- DOTA_UNIT_CAP_MELEE_ATTACK
	return 
	   else
	units[1]:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK) -- DOTA_UNIT_CAP_NO_ATTACK
	return
	 end
	end
  end
end

function fish2(event)
    local unit = event.activator
	local units = FindUnitsInRadius (event.activator:GetTeam(), event.activator:GetAbsOrigin(), nil, 0, 
	DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		
	   if units[1] then 
	if units[1]:IsHero() then
	units[1]:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	return
  end
 end
end]]

function fish1(event)
    local unit = event.activator
	LinkLuaModifier("triggercheck", "libraries/modifiers/triggercheck.lua", LUA_MODIFIER_MOTION_NONE )
	unit:AddNewModifier(unit, nil, "triggercheck", {})
end

function fish2(event)
    local unit = event.activator
	unit:RemoveModifierByName("triggercheck")
end

-- thisEntity:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK) -- Fix Bugs fish1 в spawn для героя


   	-- local stone = event.activator:FindAbilityByName("get_the_stone")	
	-- event.activator:CastAbilityOnPosition(event.activator:GetOrigin(), stone, -1 ) 	
	-- event.activator:AddItemByName("item_wood_damage")
	
		--units[1]:AddNewModifier(units[1], nil, "modifier_ursa_enrage", {})
		--units[1]:RemoveModifierByName("modifier_ursa_enrage")

