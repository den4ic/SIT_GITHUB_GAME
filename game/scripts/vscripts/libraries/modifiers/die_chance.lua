if die_chance == nil then
die_chance = class({})
end

function die_chance:IsHidden()
	return true
end

function die_chance:DeclareFunctions()
    local func = {
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION 
    }
    return func
end

function die_chance:GetTexture()
    return "brewmaster_drunken_haze"
end

function die_chance:GetOverrideAnimation()
	return ACT_DOTA_DIE
end

-- function die_chance:CheckState()
	-- local state = {
	-- [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	-- [MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	-- [MODIFIER_STATE_STUNNED] = true,
    -- }
    -- return state
-- end

function die_chance:RemoveOnDeath()
	return true
end

if die_freeze == nil then
die_freeze = class({})
end

function die_freeze:IsHidden()
	return true
end

function die_freeze:CheckState()
    local state = {
    [MODIFIER_STATE_FROZEN] = true,
    }
    return state
end

function die_freeze:RemoveOnDeath()
	return true
end

if die_check == nil then
die_check = class({})
end

function die_check:IsHidden()
	return true
end

function die_check:CheckState()
	local state = {
	[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	[MODIFIER_STATE_STUNNED] = true,
    }
    return state
end

function die_check:RemoveOnDeath()
	return true
end
