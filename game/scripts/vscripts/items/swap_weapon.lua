function EquipWeapon(keys)


	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local caster = keys.caster
	local ability = keys.ability
	--local hero = player:GetAssignedHero()
	local hero = PlayerResource:GetSelectedHeroEntity(pID)
	
	SwapWearable(caster, "models/heroes/omniknight/shoulder.vmdl", "models/items/omniknight/shoulder_crusader.vmdl")
	SwapWearable(caster, "models/heroes/omniknight/cape.vmdl", "models/items/omniknight/cape_crusader.vmdl")

	SwapWearable(caster, "models/heroes/omniknight/cape.vmdl", "models/items/omniknight/grey_night_back/grey_night_back.vmdl")
	SwapWearable(caster, "models/heroes/omniknight/shoulder.vmdl", "models/items/omniknight/grey_night_shoulders/grey_night_shoulders.vmdl")
--	SwapWearable(caster, "models/heroes/omniknight/hammer.vmdl", "models/items/omniknight/dingus_hammer.vmdl")
	
end

function UnequipWeapon(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local caster = keys.caster
	local ability = keys.ability
	--local hero = player:GetAssignedHero()
	local hero = PlayerResource:GetSelectedHeroEntity(pID)
	

	SwapWearable(caster, "models/items/omniknight/shoulder_crusader.vmdl", "models/heroes/omniknight/shoulder.vmdl")
	SwapWearable(caster, "models/items/omniknight/cape_crusader.vmdl", "models/heroes/omniknight/cape.vmdl")	
	
	SwapWearable(caster, "models/items/omniknight/grey_night_back/grey_night_back.vmdl", "models/heroes/omniknight/cape.vmdl")
	SwapWearable(caster, "models/items/omniknight/grey_night_shoulders/grey_night_shoulders.vmdl", "models/heroes/omniknight/shoulder.vmdl")
--	SwapWearable(caster, "models/items/omniknight/dingus_hammer.vmdl", "models/heroes/omniknight/hammer.vmdl")
end