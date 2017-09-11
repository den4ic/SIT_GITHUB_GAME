if die_chance_hunge == nil then
die_chance_hunger = class({})
end

function die_chance_hunger:IsHidden()
	return true
end

function die_chance_hunger:DeclareFunctions()
    local func = {
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION 
    }
    return func
end

function die_chance_hunger:GetTexture()
    return "brewmaster_drunken_haze"
end

function die_chance_hunger:GetOverrideAnimation()
	return ACT_DOTA_DIE
end

-- function die_chance_hunger:CheckState()
	-- local state = {
	-- [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	-- [MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	-- [MODIFIER_STATE_STUNNED] = true,
    -- }
    -- return state
-- end

function die_chance_hunger:RemoveOnDeath()
	return true
end

if die_freeze_hunger == nil then
die_freeze_hunger = class({})
end

function die_freeze_hunger:IsHidden()
	return true
end

function die_freeze_hunger:CheckState()
    local state = {
    [MODIFIER_STATE_FROZEN] = true,
    }
    return state
end

function die_freeze_hunger:RemoveOnDeath()
	return true
end

if die_check_hunger == nil then
die_check_hunger = class({})
end

function die_check_hunger:IsHidden()
	return true
end

function die_check_hunger:CheckState()
	local state = {
	[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	[MODIFIER_STATE_STUNNED] = true,
    }
    return state
end

function die_check_hunger:RemoveOnDeath()
	return true
end
