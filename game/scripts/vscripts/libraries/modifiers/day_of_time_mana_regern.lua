if day_of_time_mana_regern == nil then
   day_of_time_mana_regern = class({})
end

function day_of_time_mana_regern:IsHidden()
	return true
end

function day_of_time_mana_regern:DeclareFunctions()
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT  }
end

function day_of_time_mana_regern:GetTexture()
    return "brewmaster_drunken_haze"
end

function day_of_time_mana_regern:GetModifierConstantManaRegen()
    return -1.0
end

function day_of_time_mana_regern:RemoveOnDeath()
	return false
end


if night_of_time_mana_regern == nil then
   night_of_time_mana_regern = class({})
end

function night_of_time_mana_regern:IsHidden()
	return true
end

function night_of_time_mana_regern:DeclareFunctions()
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT  }
end

function night_of_time_mana_regern:GetTexture()
    return "brewmaster_drunken_haze"
end

function night_of_time_mana_regern:GetModifierConstantManaRegen()
    return -1.2
end

function night_of_time_mana_regern:RemoveOnDeath()
	return false
end
