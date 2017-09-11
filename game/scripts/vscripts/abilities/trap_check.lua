
function Check(data)
	--print("Check")
	local caster = data.caster

        local target = data.target
        local ability = data.ability
        local durationstun = ability:GetSpecialValueFor('stun_times')
	
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 150,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		
	if units[1] then 
		if units[1]:IsCreep() then --IsHero
		local damage = {
			victim = units[1],
			attacker = data.caster,
			damage = 20,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = data.caster:FindAbilityByName("trap_check"),
		}
	 	ability:ApplyDataDrivenModifier(caster,units[1],'modifier_stoped_stune',{duration = durationstun})
		ApplyDamage( damage )
		--ParticleManager:CreateParticle("particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_bolt_down.vpcf", PATTACH_ABSORIGIN, units[1])

		
		-- local id0 = ParticleManager:CreateParticle("particles/world_destruction_fx/tree_dire_destroy.vpcf", PATTACH_ABSORIGIN, units[1])
			-- EmitSoundOn("DOTA_Item.Maim", data.caster)
		 end

		data.caster:ForceKill(false)
	end
end





