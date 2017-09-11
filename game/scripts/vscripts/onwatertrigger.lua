function onwatertrigger(event)
    local unit = event.activator
	LinkLuaModifier("watercheck", "libraries/modifiers/watercheck.lua", LUA_MODIFIER_MOTION_NONE )
	-- LinkLuaModifier("die_chance", "libraries/modifiers/die_chance.lua", LUA_MODIFIER_MOTION_NONE )
	-- LinkLuaModifier("die_freeze", "libraries/modifiers/die_chance.lua", LUA_MODIFIER_MOTION_NONE )
	unit:AddNewModifier(unit, nil, "watercheck", {})
	-- unit:AddNewModifier(unit, nil, "die_chance", {})	
	
		
		-- Timers:CreateTimer(2.5,function()
		-- unit:AddNewModifier(unit, nil, "die_freeze", {})
		-- return nil
		-- end)
		
end

function onwatertrigger2(event)
    local unit = event.activator

	unit:RemoveModifierByName("watercheck")	
	-- unit:RemoveModifierByName("die_chance")	
	-- unit:RemoveModifierByName("die_freeze")	
end
