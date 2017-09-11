if modifier_vision_ability == nil then
modifier_vision_ability = class({})
end

function modifier_vision_ability:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BONUS_DAY_VISION,
        MODIFIER_PROPERTY_BONUS_NIGHT_VISION
    }

    return funcs
end

function modifier_vision_ability:GetBonusDayVision()
    return 300
end

function modifier_vision_ability:GetBonusNightVision()
    return 200
end

function modifier_vision_ability:IsHidden()
    return true
end

function modifier_vision_ability:RemoveOnDeath()
	return false
end

			--	"MODIFIER_PROPERTY_BONUS_DAY_VISION"	"300"
			--	"MODIFIER_PROPERTY_BONUS_NIGHT_VISION"  "200"
			--	"MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT"   "10"
			
if modifier_speed_ability == nil then
modifier_speed_ability = class({})
end

function modifier_speed_ability:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }

    return funcs
end

function modifier_speed_ability:GetModifierMoveSpeedBonus_Constant()
    return 5
end

function modifier_speed_ability:IsHidden()
    return true
end

function modifier_speed_ability:RemoveOnDeath()
	return false
end





if re_modifier_speed_ability == nil then
re_modifier_speed_ability = class({})
end

function re_modifier_speed_ability:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }

    return funcs
end

function re_modifier_speed_ability:GetModifierMoveSpeedBonus_Constant()
    return 10
end

function re_modifier_speed_ability:IsHidden()
    return true
end

function re_modifier_speed_ability:RemoveOnDeath()
	return false
end





if modifier_damage_and_speed == nil then
modifier_damage_and_speed = class({})
end

function modifier_damage_and_speed:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }

    return funcs
end

function modifier_damage_and_speed:GetModifierPreAttack_BonusDamage()
    return 1
end

function modifier_damage_and_speed:GetModifierMoveSpeedBonus_Constant()
    return 15
end

function modifier_damage_and_speed:IsHidden()
    return true
end

function modifier_damage_and_speed:RemoveOnDeath()
	return false
end


--60/45

if modifier_damage_and_speed_two == nil then
modifier_damage_and_speed_two = class({})
end

function modifier_damage_and_speed_two:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }

    return funcs
end

function modifier_damage_and_speed_two:GetModifierPreAttack_BonusDamage()
    return 2
end

function modifier_damage_and_speed_two:GetModifierMoveSpeedBonus_Constant()
    return 20
end

function modifier_damage_and_speed_two:IsHidden()
    return true
end

function modifier_damage_and_speed_two:RemoveOnDeath()
	return false
end

--80/60

if modifier_damage_and_speed_three == nil then
modifier_damage_and_speed_three = class({})
end

function modifier_damage_and_speed_three:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }

    return funcs
end

function modifier_damage_and_speed_three:GetModifierPreAttack_BonusDamage()
    return 3
end

function modifier_damage_and_speed_three:GetModifierMoveSpeedBonus_Constant()
    return 25
end

function modifier_damage_and_speed_three:IsHidden()
    return true
end

function modifier_damage_and_speed_three:RemoveOnDeath()
	return false
end

--100/75

if modifier_damage_and_speed_four == nil then
modifier_damage_and_speed_four = class({})
end

function modifier_damage_and_speed_four:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }

    return funcs
end

function modifier_damage_and_speed_four:GetModifierPreAttack_BonusDamage()
    return 4
end

function modifier_damage_and_speed_four:GetModifierMoveSpeedBonus_Constant()
    return 30
end

function modifier_damage_and_speed_four:IsHidden()
    return true
end

function modifier_damage_and_speed_four:RemoveOnDeath()
	return false
end


--55/43

if modifier_damage_plus_speed_up == nil then
modifier_damage_plus_speed_up = class({})
end

function modifier_damage_plus_speed_up:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }

    return funcs
end

function modifier_damage_plus_speed_up:GetModifierPreAttack_BonusDamage()
    return 4
end

function modifier_damage_plus_speed_up:GetModifierMoveSpeedBonus_Constant()
    return 35
end

function modifier_damage_plus_speed_up:IsHidden()
    return true
end

function modifier_damage_plus_speed_up:RemoveOnDeath()
	return false
end

--63\60

if modifier_damage_vision_agility_up == nil then
modifier_damage_vision_agility_up = class({})
end

function modifier_damage_vision_agility_up:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	    MODIFIER_PROPERTY_BONUS_DAY_VISION,
        MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }

    return funcs
end

function modifier_damage_vision_agility_up:GetModifierPreAttack_BonusDamage()
    return 7
end

function modifier_damage_vision_agility_up:GetModifierMoveSpeedBonus_Constant()
    return 35
end

function modifier_damage_vision_agility_up:GetBonusDayVision()
    return 350
end

function modifier_damage_vision_agility_up:GetBonusNightVision()
    return 250
end

function modifier_damage_vision_agility_up:GetModifierBonusStats_Agility()
    return 10
end

function modifier_damage_vision_agility_up:IsHidden()
    return true
end

function modifier_damage_vision_agility_up:RemoveOnDeath()
	return false
end

