
function hunger(keys) 
		local caster = keys.caster
		local ability = keys.ability
        local hp_remove = ability:GetLevelSpecialValueFor( "hp_remove" , ability:GetLevel() - 1  )*0.01
		local cooldown = ability:GetLevelSpecialValueFor( "cooldown" , ability:GetLevel() - 1  )
		local passives = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 3500, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
 
		for i = 1, #passives do
			local vic = passives[i]
					ApplyDamage({victim = vic, attacker = caster, damage = vic:GetHealth()*hp_remove, damage_type = DAMAGE_TYPE_PURE})
		end
end




--function refresh_cooldowns( event )
--    print("refreshing cooldowns")

--    local hero = event.caster

--   for i=0,4 do
--        local ability = hero:GetAbilityByIndex(i)
--        ability:EndCooldown()
--    end
--end


--		ability:StartCooldown(cooldown)
--		if caster:GetHealth() < 180 then ability:ToggleAbility() caster:ForceKill(false) return nil end
--      IsAlive()
-- EndCooldown()


--    caster:Interrupt()
--   ability:EndCooldown()
--   caster:GiveMana(ability:GetManaCost(-1)) -- -1 defaults to current ability le
--   if caster:GetHealth() < 180 then ability:EndCooldown()  caster:GiveMana(ability:GetManaCost(-1))    return nil end


function DamageInSec(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local cooldown = ability:GetLevelSpecialValueFor( "cooldown" , ability:GetLevel() - 1  )
	local pers = ability:GetLevelSpecialValueFor( "damage" , ability:GetLevel() - 1  )*0.01
	local damage = caster:GetMaxHealth()*pers
	local mana = caster:GetMana() / caster:GetMaxMana()  

	ApplyDamage({victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE })
--	ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "energy", {duration = 1})
 
 end
 
 