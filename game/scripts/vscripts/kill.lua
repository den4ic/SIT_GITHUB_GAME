function hunger_aura_kill(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local ability = keys.ability
	local caster = keys.caster
	local hero = PlayerResource:GetSelectedHeroEntity(pID)
	local food_cost = ability:GetLevelSpecialValueFor("food_cost", ability:GetLevel()-1)
	local enough_food
 
	if player.food then
	if player.food == 100 then
	Notifications:Top(pID, {text="#Satiety", duration=3, style={color="green", ["font-size"]="45px"}})
	elseif player.food == 50 then
	Notifications:Top(pID, {text="#Hunger", duration=3, style={color="yellow", ["font-size"]="45px"}})
	end
	if player.food == 20 then
	Notifications:Top(pID, {text="#Terrible_hunger", duration=3, style={color="red", ["font-size"]="45px"}})
	end
	 
    if player.food > 100 and not caster:HasModifier("modifier_speed") then
    ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_speed", {})
	elseif player.food <= 100 and caster:HasModifier("modifier_speed") then
	caster:RemoveModifierByName("modifier_speed")
	end
	
	if food_cost ~= nil and food_cost ~= 0 then
	   enough_food = CheckFood(player, food_cost,true)
	else
	   enough_food = true
	end
	-- if enough_food ~= true then
	   -- return
	-- else 	 
	if not hero:HasModifier("die_check") then
	    if player.food >= 1 and hero:IsAlive() then
		  SpendFood(player, food_cost)
	    end	 	 	 	 
		elseif hero:HasModifier("die_check") then
		  SpendFood(player, 0)			
		end
		
	if player.food <= 2 then
	 if not hero:HasModifier("die_freeze_hunger") then
	 hero:AddNewModifier(hero, nil, "die_check_hunger", {})
	end
	end
	if player.food <= 1 then
    if hero:HasModifier("die_check_hunger") then 
		if not hero:HasModifier("die_chance_hunger") then
		Timers:CreateTimer(0.88,function()
		Notifications:Bottom(pID, {text="#die_hunger", duration=8, style={color="#afeeee", ["font-size"]="35px"}})
		GameRules:SendCustomMessage("#forcekill_hunger", pID, 0)
		hero:AddNewModifier(hero, nil, "die_chance_hunger", {})
		player.food = 50
		end)
			Timers:CreateTimer(3.3,function()
				hero:AddNewModifier(hero, nil, "die_freeze_hunger", {})
			end)
		end
	end
	elseif player.food > 50 then
		if hero:HasModifier("die_freeze_hunger") then
		caster:RemoveModifierByName("die_freeze_hunger")	
		if hero:HasModifier("die_chance_hunger") then
		caster:RemoveModifierByName("die_chance_hunger")
		if hero:HasModifier("die_check_hunger") then
		caster:RemoveModifierByName("die_check_hunger")
		end
	end	
   end
  end	
  	if player.food == 0 then
	caster:ForceKill(false)
	end
	if not caster:IsAlive() then
	player.food = 100
	end 
 end
end
