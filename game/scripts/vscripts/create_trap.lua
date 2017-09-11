----------------
--@By Den4icccc
----------------
function create_trap(keys)

	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local caster = keys.caster

	local ability = keys.ability
	
    local gold_cost = ability:GetGoldCost(1)
	local lumber_cost = ability:GetLevelSpecialValueFor("lumber_cost", ability:GetLevel()-1)

	local enough_lumber

	local create_woods = EntIndexToHScript( keys.caster_entindex )
			

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
		for itemSlot = 0, 1, 2 do 
			local Item = create_woods:GetItemInSlot( itemSlot )
			create_woods:AddItemByName("item_snap_trap")
			SpendLumber(player, lumber_cost)
		end
	end
end