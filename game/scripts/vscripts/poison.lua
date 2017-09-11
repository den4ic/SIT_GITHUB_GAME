

function poison(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pers = ability:GetLevelSpecialValueFor( "damage" , ability:GetLevel() - 1  )*0.01
	local damage = caster:GetMaxHealth()*pers
	 
	--if RollPercentage(10) then -- процент шанса
	ApplyDamage({victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE })
	--end
end
