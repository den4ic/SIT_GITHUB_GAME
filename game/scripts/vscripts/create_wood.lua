----------------
--@By Den4icccc
----------------
function create_wood(keys)

	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local caster = keys.caster

	local ability = keys.ability
	
	local gold_cost = ability:GetGoldCost(1)
	local lumber_cost = ability:GetLevelSpecialValueFor("lumber_cost", ability:GetLevel()-1)
	local food_cost = ability:GetLevelSpecialValueFor("food_cost", ability:GetLevel()-1)

	local enough_lumber
	local enough_food

	local create_woods = EntIndexToHScript( keys.caster_entindex )
			
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
		for itemSlot = 0, 1, 2 do 
			local Item = create_woods:GetItemInSlot( itemSlot )
			create_woods:AddItemByName("item_woods")
			SpendLumber(player, lumber_cost)
			SpendFood(player, food_cost)
		end
	end
	
end