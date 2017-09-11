function DamageInSec(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	--local hero = player:GetAssignedHero()
	local hero = PlayerResource:GetSelectedHeroEntity(pID)

	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local cooldown = ability:GetLevelSpecialValueFor( "cooldown" , ability:GetLevel() - 1  )
	local pers = ability:GetLevelSpecialValueFor( "damage" , ability:GetLevel() - 1  )*0.01
	local damage = caster:GetMaxHealth()*pers
	local mana = caster:GetMana() / caster:GetMaxMana()  
	
	if not hero:HasModifier("die_check_hunger") then
	if GameRules:IsDaytime() then
		hero:AddNewModifier(hero, nil, "day_of_time_mana_regern", {})
	if caster:HasModifier("night_of_time_mana_regern") then caster:RemoveModifierByName("night_of_time_mana_regern")
    end
	elseif not GameRules:IsDaytime() then
		hero:AddNewModifier(hero, nil, "night_of_time_mana_regern", {})
	if caster:HasModifier("day_of_time_mana_regern") then caster:RemoveModifierByName("day_of_time_mana_regern")
        end
	end
	elseif hero:HasModifier("die_check_hunger") then
		if hero:HasModifier("day_of_time_mana_regern") then 
		caster:RemoveModifierByName("day_of_time_mana_regern")	
		elseif hero:HasModifier("night_of_time_mana_regern") then	
		caster:RemoveModifierByName("night_of_time_mana_regern")
		end
	end
	
    if mana == 0 then
	hero:ForceKill(false)
	GameRules:SendCustomMessage("#forcekill_pid", pID, 0)
		if player.food then
			if not caster:IsAlive() then
			player.food = 100
		end 
	end
	-- ApplyDamage({victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE })
	-- ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "cold", {duration = 1})
    end
	
	if mana < 0.060 then
	 if not hero:HasModifier("die_freeze") then
	 hero:AddNewModifier(hero, nil, "die_check", {})
	-- caster:Stop()
	end
	 end
	if mana <= 0.050 then
   if hero:HasModifier("die_check") then 
	--if not hero:HasModifier("modifier_chopping_wood") then
		if not hero:HasModifier("die_chance") then
			 ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "cold", {})
		Timers:CreateTimer(0.88,function()
		Notifications:Bottom(pID, {text="#dead_text", duration=8, style={color="#afeeee", ["font-size"]="35px"}})
			--	Gamerules:SendCustomMessage("#DOTA_Chat_dead_text", pID, 0)
		 GameRules:SendCustomMessage("#player_kill", pID, 0)
		hero:AddNewModifier(hero, nil, "die_chance", {})
		hero:SetMana(50)
		--	return nil	
			end)
			Timers:CreateTimer(3.3,function()
				hero:AddNewModifier(hero, nil, "die_freeze", {})
			--	return nil	
			end)
		end
	end
	elseif mana > 0.5 then
		if hero:HasModifier("die_freeze") then
		caster:RemoveModifierByName("die_freeze")	
		if hero:HasModifier("die_chance") then
		caster:RemoveModifierByName("die_chance")
		if hero:HasModifier("die_check") then
		caster:RemoveModifierByName("die_check")
		if hero:HasModifier("cold") then
		caster:RemoveModifierByName("cold")
		end
		end
	end	
end
end	
end

-- The player %s1 died of cold.
-- The player %s1 fell into a cold faint. He will die, if no one will help him.
--  "Игрок %s1 умер от холода."
--	"Игрок <font color='#ff0000'>%s1</font> упал в холодный обморок. Он умрёт, если никто ему не поможет."
--  Notifications:Bottom(pID, {text="#DOTA_Chat_dead_text", duration=8, style={color="white", ["font-size"]="35px"}})
--	Gamerules:SendCustomMessage("#DOTA_Chat_dead_text", pID, 0)
--  GameRules:SendCustomMessage("#DOTA_Chat_dead_text %s1", pID, 0)


	--[[if mana < 0.96 then
		   hero:AddNewModifier(hero, nil, "die_check", {})
	end
	if mana <= 0.95 then
   if hero:HasModifier("die_check") then 
	--if not hero:HasModifier("modifier_chopping_wood") then
		if not hero:HasModifier("die_chance") then
		Timers:CreateTimer(1.0,function()
		hero:AddNewModifier(hero, nil, "die_chance", {})
		--	return nil	
			end)
			Timers:CreateTimer(2.6,function()
				hero:AddNewModifier(hero, nil, "die_freeze", {})
			--	return nil	
			end)
		end
	end
	elseif mana > 0.96 then
		if hero:HasModifier("die_freeze") then
		hero:RemoveModifierByName("die_freeze")	
		if hero:HasModifier("die_chance") then
		hero:RemoveModifierByName("die_chance")
		if hero:HasModifier("die_check") then
		hero:RemoveModifierByName("die_check")
		end
		end
	end	
end
end	]]



		--[[if mana < 0.96 then
				if not hero:HasModifier("die_check") then
					hero:AddNewModifier(hero, nil, "die_check", {})
				end
			end

			if mana <= 0.94 then
		   if hero:HasModifier("die_check") then 
			--if not hero:HasModifier("modifier_chopping_wood") then
				if not hero:HasModifier("die_chance") then
				hero:AddNewModifier(hero, nil, "die_chance", {})
					Timers:CreateTimer(2.5,function()
						hero:AddNewModifier(hero, nil, "die_freeze", {})
						return nil
					end)
				end
			end
			elseif mana > 0.96 then
				if hero:HasModifier("die_freeze") then
				hero:RemoveModifierByName("die_freeze")	
				if hero:HasModifier("die_chance") then
				hero:RemoveModifierByName("die_chance")
				if hero:HasModifier("die_check") then
				hero:RemoveModifierByName("die_check")
				end
				end
			end	
		end
		end]]


 	-- if GameRules:IsDaytime() then	
    -- if mana <= 1.0 then
	-- ApplyDamage({victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE })
	-- ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "cold", {duration = 1})
	-- end
	-- elseif not GameRules:IsDaytime() then
	-- if mana <= 1.0 then
	-- ApplyDamage({victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE })
	-- ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "cold", {duration = 1})
    -- end
	-- end