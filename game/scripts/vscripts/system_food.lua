 function food(keys)
	local target = keys.target
	 local player = keys.target:GetPlayerOwner()
	 local pID = player:GetPlayerID()
	 local ability = keys.ability
	
	
	 local food_cost = ability:GetLevelSpecialValueFor("food_cost", ability:GetLevel()-1)
	
	 local enough_food

	 if food_cost ~= nil and food_cost ~= 0 then
	 	enough_food = CheckFood(player, food_cost,true)
	 else
	 	enough_food = true
	 end

	 if enough_food ~= true then
	 	return
	 else 
	 	 SpendFood(player, food_cost)
	 end
end

--    -createhero omnik