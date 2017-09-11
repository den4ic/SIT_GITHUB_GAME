function droper_weapon(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local ability = keys.ability
	local caster = keys.caster
	
	local droper={"item_wood_damage",
			"item_fishing_rod",
		    "item_wea",
		    "item_bone_sharpening_easy",
		    "item_bone_sharpening_heavy",
		    "item_bow",
		    "item_sword_damage",
			"item_claws_wolf",
			"item_claws_bear"}
			 
	for i=1, table.getn(droper) do
		if caster:HasItemInInventory(droper[i]) then
			Notifications:Bottom(player:GetPlayerID(), {text="#need_drop_item", duration=1, style={color="red", ["font-size"]="35px"}})
			Timers:CreateTimer(0.1,function()
				caster:DropItemAtPositionImmediate(ability, caster:GetAbsOrigin())
			end)
		end
	end
end

function droper_hhi(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local ability = keys.ability
	local caster = keys.caster
	
	local droper={"item_axe_iron",
			"item_axe_tree",
			"item_scalp"}
			 
	for i=1, table.getn(droper) do
		if caster:HasItemInInventory(droper[i]) then
			Notifications:Bottom(player:GetPlayerID(), {text="#need_drop_item", duration=1, style={color="red", ["font-size"]="35px"}})
			Timers:CreateTimer(0.1,function()
				caster:DropItemAtPositionImmediate(ability, caster:GetAbsOrigin())
			end)
		end
	end
end

function droper_clothes(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local ability = keys.ability
	local caster = keys.caster
	
	local droper={"item_northern_wolf_shield",
			"item_shield_of_heaven",
			"item_rough_bear_armor",
			"item_warm_bear_armor"}
			 
	for i=1, table.getn(droper) do
		if caster:HasItemInInventory(droper[i]) then
			Notifications:Bottom(player:GetPlayerID(), {text="#need_drop_item", duration=1, style={color="red", ["font-size"]="35px"}})
			Timers:CreateTimer(0.1,function()
				caster:DropItemAtPositionImmediate(ability, caster:GetAbsOrigin())
			end)
		end
	end
end



-- -item item_shield_of_heaven Грубый волчий доспех
-- -item item_northern_wolf_shield
-- -item item_rough_bear_armor Грубый медвежий доспех 
-- -item item_warm_bear_armor


--[[function droper_clothes(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local ability = keys.ability
	local caster = keys.caster

	local droper = { [1] = "item_northern_wolf_shield",
					 [2] = "item_shield_of_heaven",
					 [3] = "item_rough_bear_armor",
					 [4] = "item_warm_bear_armor"}
					 

	for i = 0,8 do
	local Item = caster:GetItemInSlot(i)
	if Item ~= nil then
		if Item:GetName() == "item_northern_wolf_shield" then
			print('1')
			SwapWearable(caster, "models/heroes/omniknight/cape.vmdl", "models/items/omniknight/grey_night_back/grey_night_back.vmdl")
			SwapWearable(caster, "models/heroes/omniknight/shoulder.vmdl", "models/items/omniknight/grey_night_shoulders/grey_night_shoulders.vmdl")
		end
		if Item:GetName() == "item_shield_of_heaven" then
			print('2')
		--	SwapWearable(caster, "models/heroes/omniknight/cape.vmdl", "models/items/omniknight/grey_night_back/grey_night_back.vmdl")
		--	SwapWearable(caster, "models/heroes/omniknight/shoulder.vmdl", "models/items/omniknight/grey_night_shoulders/grey_night_shoulders.vmdl")
		end
		if Item:GetName() == "item_rough_bear_armor" then
			print('3')
		--	SwapWearable(caster, "models/heroes/omniknight/cape.vmdl", "models/items/omniknight/grey_night_back/grey_night_back.vmdl")
		--	SwapWearable(caster, "models/heroes/omniknight/shoulder.vmdl", "models/items/omniknight/grey_night_shoulders/grey_night_shoulders.vmdl")
		end
		if Item:GetName() == "item_warm_bear_armor" then
			print('4')
		--	SwapWearable(caster, "models/heroes/omniknight/cape.vmdl", "models/items/omniknight/grey_night_back/grey_night_back.vmdl")
		--	SwapWearable(caster, "models/heroes/omniknight/shoulder.vmdl", "models/items/omniknight/grey_night_shoulders/grey_night_shoulders.vmdl")
		end
	  end
	end
end]]
	