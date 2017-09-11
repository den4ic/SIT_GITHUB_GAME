function Drop(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
    local caster = keys.caster
    local point = keys.target_points[1]
       local itemsToDrop = {}
    for i=0,5 do
        local item = caster:GetItemInSlot(i)
            if item then
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
		   caster:DropItemAtPositionImmediate(item, origin)
		   item:LaunchLoot(false, 200, 0.75, origin + RandomVector(RandomFloat(110, 150)))
		--   print(k)
          -- DebugDrawCircle(point, Vector(255,0,0), 100, 50, true, 10)
       end
    end
end