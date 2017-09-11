function Upgrade (event)
	local player = event.caster:GetPlayerOwner()
    local pID = player:GetPlayerID()
	local caster = event.caster
	local ability = event.ability

	local sawmill_level = ability:GetLevel()

    local hero = player:GetAssignedHero()
	
	if sawmill_level == 1 then
		caster:SetOriginalModel(GetModelNameForLevel(sawmill_level))
		caster:SetModel(GetModelNameForLevel(sawmill_level))
		caster:SetModelScale(0.7)

		
	--    caster:SwapAbilities("train_petri_peasant", "petri_empty1", true, false)

    --    caster:AddAbility("ant_ulti"):SetLevel(1)

     --   if caster:FindAbilityByName("create_wood") then
        	caster:AddAbility("create_woodi"):SetLevel(1)
		--	caster:AddAbility("create_woodii"):SetLevel(1)
		--	caster:AddAbility("burn_active"):SetLevel(1)
   --     	caster:AddAbility("petri_upgrade_sawmill"):SetLevel(0)
   --     	caster:AddItemByName("item_wood")
     --   end
           	caster:RemoveAbility("petri_upgrade_sawmill")
	
		-- if caster:FindAbilityByName("build_petri_tower_basic") then
		   -- caster:AddAbility("ant_ulti"):SetLevel(1)
        -- end
		
		
	-- elseif sawmill_level == 2 then 
		-- caster:SetOriginalModel(GetModelNameForLevel(sawmill_level))
		-- caster:SetModel(GetModelNameForLevel(sawmill_level))
		-- caster:SetModelScale(0.5)

		-- caster:GetPlayerOwner().sawmill_3 = true

		-- caster:SwapAbilities("train_petri_super_peasant", "petri_empty2", true, false)
	
	-- local cooldown = ability:GetLevelSpecialValueFor( "cooldown" , ability:GetLevel() - 1  )
	
		if hero:FindAbilityByName("ant_ulti_test") then
	       caster:RemoveAbility("create_woodi")
		end
		
		-- if hero:FindAbilityByName("sniper_assassinate_wars_test") then
	       -- caster:RemoveAbility("create_woodii")
		-- end
		
		-- if hero:FindAbilityByName("burn_fire_activated") then
	       -- caster:RemoveAbility("burn_active")
		-- end
		
	 end
end

function GetModelNameForLevel(level)
	if level == 1 then
		return "models/tent.vmdl"
	 -- elseif level == 2 then 
		 -- return "models/props_structures/good_ancient001.vmdl"
	 end
end

-- petri_upgrade_sawmill

-- Forces an ability to level 0
-- function SetLevel0( event )
--    local ability = event.ability
--    if ability:GetLevel() == 1 then
--        ability:SetLevel(0) 
--    end
-- end

-- create_woodi

-- caster:RemoveAbility("  ")