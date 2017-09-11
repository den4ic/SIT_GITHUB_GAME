require('units/kvn_fan')
----------------
--@By Den4icccc
----------------
-- function create_woodeg(keys)
   -- local player = keys.caster:GetPlayerOwner()
   -- local pID = player:GetPlayerID()
   -- local caster = keys.caster
   -- local ability =  keys.ability
   -- local hero = player:GetAssignedHero()
   -- local save = {}
   -- local rally_spawn_position = hero:AddAbility("ant_ulti_test")
   -- if rally_spawn_position then
   
    -- table.insert(save, rally_spawn_position) 
      -- else
        -- print("Fail, no rally point position, this shouldn't happen")
    -- end
	-- return save
-- end


-- function create_woodeg(keys)
   -- local player = keys.caster:GetPlayerOwner()
   -- local pID = player:GetPlayerID()
   -- local caster = keys.caster
   -- local ability =  keys.ability
   -- local hero = player:GetAssignedHero()
   
   -- if hero:FindAbilityByName("ant_ulti") then
   
	  -- hero:RemoveAbility("ant_ulti")
	  -- hero:AddAbility("ant_ulti_test")
	  
   -- else
   -- if hero:FindAbilityByName("ant_ulti_test") then
	  -- hero:RemoveAbility("ant_ulti_test")
	  -- hero:AddAbility("ant_ulti")
   
      -- end
   -- end
-- end

-- function create_woodeg(keys)
-- local caster = keys.caster
-- local player = keys.caster:GetPlayerOwner()
-- local pID = player:GetPlayerID()
-- local hero = player:GetAssignedHero()
-- InitAntUlti(hero)
-- end

--InitAbil(caster)
--InitAntUlti(caster)

function create_woodeg(keys)
	local player = keys.caster:GetPlayerOwner()
    local pID = player:GetPlayerID()
    local hero = player:GetAssignedHero()
    local caster = keys.caster
	
	-- если у локального героя нет абилки ant_ulti_test значит добавляет её 
	if not hero:FindAbilityByName("ant_ulti_test") then
	hero:AddAbility("ant_ulti_test")
	end
	
	--caster:AddAbility("petri_empty1")
	
	-- if hero:FindAbilityByName("ant_ulti_test" and "sniper_assassinate_wars_test") then -- 03.09.2017 off
	-- caster:AddAbility("petri_upgrade_sawmill"):SetLevel(1) 
	-- end
	
	caster:RemoveAbility("create_woodi")
	-- if hero:FindAbilityByName("ant_ulti_test") then
	-- caster:RemoveAbility("create_woodi")
    -- end
end

-- function create_woodeg(keys)
	-- local player = keys.caster:GetPlayerOwner()
    -- local pID = player:GetPlayerID()
    -- local hero = player:GetAssignedHero()
    -- local caster = keys.caster

	
   -- local ability = hero:FindAbilityByName("repair")
   -- local level = ability:GetLevel()
   -- local ability = 1
   -- if ability == 1 then
   -- ability = hero:AddAbility("ant_ulti_test") 
   -- ability:SetLevel(level)
   -- -- elseif ability > 1 then
	-- -- return
	-- end
	
-- end

-- function create_woodeg(keys)
	-- local player = keys.caster:GetPlayerOwner()
    -- local pID = player:GetPlayerID()
    -- local hero = player:GetAssignedHero()
    -- local caster = keys.caster


	
   -- local ability = hero:FindAbilityByName("repair")
   -- local level = ability:GetLevel()

   -- if not rank then
    -- rank = 1
	-- elseif rank > 1 then
	-- local ability = rank-1
   -- ability = hero:AddAbility("ant_ulti_test") 
   -- ability:SetLevel(level)

	-- elseif rank == 1 then
	-- ability:SetLevel(rank)
	-- end
-- end

function swap(keys)
   local caster = keys.caster
   local ability = caster:FindAbilityByName("repair")
   local level = ability:GetLevel()
   caster:RemoveAbility("repair")
   ability = caster:AddAbility("ant_ulti")
   ability:SetLevel(level)
end

function ult_swap(keys)
   local caster = keys.caster
   local ability = caster:FindAbilityByName("ant_ulti")
   local level = ability:GetLevel()
   caster:RemoveAbility("ant_ulti")
   ability = caster:AddAbility("repair")
   ability:SetLevel(level)
end


function InitAbilities(hero)       -- lvlup all ability
  for i=0, hero:GetAbilityCount()-1 do
    local abil = hero:GetAbilityByIndex(i)
    if abil ~= nil then
      if hero:IsHero() and hero:GetAbilityPoints() > 0 then
        hero:UpgradeAbility(abil)
      else
        abil:SetLevel(1)
      end
    end
  end
end

function InitAbil1( hero ) 
    for i=0,15 do
        local ability = hero:GetAbilityByIndex(i)
        if ability ~= nil and ability:GetName() == "close_advanced_buildings_menu" then
            ability:SetLevel(ability:GetMaxLevel())
        end
    end
end

------------------
----@By Den4icccc
------------------
--function create_wood(keys)
--
--	local player = keys.caster:GetPlayerOwner()
--	local pID = player:GetPlayerID()
--	local caster = keys.caster
--
--	local ability = keys.ability
--	
--	caster:RemoveAbility("create_woodi")
--	caster:AddAbility("build_petri_tower_basic"):SetLevel(1)
--	if caster:FindAbilityByName("build_petri_tower_basic" and "ant_ulti") then
--	caster:AddAbility("petri_upgrade_sawmill"):SetLevel(1) 
--	end
--end




-- function create_wood(keys)


	-- local player = keys.caster:GetPlayerOwner()
    -- local pID = player:GetPlayerID()
    -- local hero = player:GetAssignedHero()
    -- local abilityname = keys.abilityname
	-- local caster = keys.caster
    -- local overpower = ParticleManager:CreateParticle("particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_calldown_explosion_fireworks.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        
    -- if player then
		-- hero:AddAbility("repair")
    -- print("its player")
        -- if abilityname == "repair" then

            -- print("its juggernaut omni slash")

            -- EmitSoundOn("Hero_QueenOfPain.ScreamOfPain", player)
          
            -- ParticleManager:SetParticleControl(overpower, 0, hero:GetAbsOrigin())
            -- ParticleManager:SetParticleControl(overpower, 3, hero:GetAbsOrigin())

            -- else
            -- print("not juggernaut omni slash")
            -- ParticleManager:SetParticleControl(overpower, 0, hero:GetAbsOrigin())
            -- ParticleManager:SetParticleControl(overpower, 3, hero:GetAbsOrigin())

            -- end
    -- else
    -- print("not a player")   
    -- end 
	-- end