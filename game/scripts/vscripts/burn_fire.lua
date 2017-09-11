function BurnFire(keys)
	local campFire = EntIndexToHScript( keys.caster_entindex )
	for itemSlot = 0, 5, 1 do
			local Item = campFire:GetItemInSlot( itemSlot )
			if Item ~= nil and Item:GetName() == "item_wood_damage" then -- makes sure that the item exists and making sure it is the correct item
				campFire:RemoveItem(Item) -- finally, the item is removed from the original units inventory.
				campFire:SetHealth(100)
			end							
	end
end
function FireMeat(keys)
	local campFire = EntIndexToHScript( keys.caster_entindex )
	for itemSlot = 0, 5, 1 do
			local Item = campFire:GetItemInSlot( itemSlot )
			local meat = CreateItem("item_cooked_meat", nil, nil)
			local bread = CreateItem("item_health_potion_small", nil, nil)
			if Item ~= nil and Item:GetName() == "item_meat" then -- makes sure that the item exists and making sure it is the correct item
				campFire:RemoveItem(Item)
				campFire:AddItem(meat)
			elseif Item ~= nil and Item:GetName() == "item_mana_potion_big" then	
				campFire:RemoveItem(Item)
				campFire:AddItem(bread)
			end							
	end
end

function CookFood(keys)
    local building = keys.caster
    local range = keys.Range

    for _,item in pairs( Entities:FindAllByClassnameWithin("dota_item_drop", building:GetAbsOrigin(), range)) do
        local containedItem = item:GetContainedItem()
        if containedItem:GetAbilityName() == "item_meat" and not containedItem.dropped then
            building:EmitSound("Hero_Lina.attack")
            local newItem = CreateItem("item_cooked_meat", nil, nil)
            CreateItemOnPositionSync(item:GetAbsOrigin(), newItem)
            UTIL_Remove(containedItem)
            UTIL_Remove(item)
        end
    end
end

function AutoCookFood( event )
    local ability = event.ability
    local caster = event.caster

    if ability:GetAutoCastState() and ability:IsFullyCastable() and ability:IsActivated() then
        ability:CastAbility()
    end
end