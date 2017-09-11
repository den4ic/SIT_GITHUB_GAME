function QuickDrop(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
    local caster = keys.caster
    local point = keys.target_points[1]
    local itemsToDrop = {}
    for i=0,5 do
        local item = caster:GetItemInSlot(i)
		local charges = 0
		
		local meat = CreateItem("item_cooked_meat", nil, nil)
            if item ~= nil and item:GetName() == "item_meat" then
			  if item:IsStackable() == true then
				if item:GetCurrentCharges() >= 1 then
				charges = item:GetCurrentCharges()
				meat:SetCurrentCharges(charges+0)
			table.insert(itemsToDrop, item)
        end
    end

	
    local itemCount = #itemsToDrop
	
        if itemCount > 0 then
        local origin = caster:GetAbsOrigin()
        local rotate_pos = point + Vector(1,0,0) * 50
        local angle = 360 / itemCount
        for k,item in pairs(itemsToDrop) do
            local position = RotatePosition(point, QAngle(0, angle*k, 0), rotate_pos)
              caster:RemoveItem(item)
			  caster:AddItem(meat)
			  caster:DropItemAtPositionImmediate(meat, origin) --Drops the item where the unit is standing
			  meat:LaunchLoot(false, 200, 0.75, origin + RandomVector(RandomFloat(80, 150))) --Drop position
            -- DropLaunch(caster, item, 0.75, position)
            -- print(k)
            -- DebugDrawCircle(point, Vector(255,0,0), 100, 50, true, 10)
        end
    end
	
	local itemsToDropes = {}
    for i=0,5 do
        local items = caster:GetItemInSlot(i)
            if items then
            table.insert(itemsToDropes, items)
        end
    end
	
    local itemCount = #itemsToDropes
	
        if itemCount > 0 then
        local origin = caster:GetAbsOrigin()
        local rotate_pos = point + Vector(1,0,0) * 50
        local angle = 360 / itemCount
        for k,items in pairs(itemsToDropes) do
            local position = RotatePosition(point, QAngle(0, angle*k, 0), rotate_pos)
			  caster:DropItemAtPositionImmediate(items, origin) --Drops the item where the unit is standing
			  items:LaunchLoot(false, 200, 0.75, origin + RandomVector(RandomFloat(80, 150))) --Drop position
            -- DropLaunch(caster, item, 0.75, position)
            -- print(k)
            -- DebugDrawCircle(point, Vector(255,0,0), 100, 50, true, 10)
        end
    end
	
end
	end
	end
	