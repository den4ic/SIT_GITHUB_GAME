if deer_modifier == nil then
deer_modifier = class({})
end

function deer_modifier:IsHidden()
	return false
end

function deer_modifier:RemoveOnDeath()
	return true
end

if sheep_modifier == nil then
sheep_modifier = class({})
end

function sheep_modifier:IsHidden()
	return false
end

function sheep_modifier:RemoveOnDeath()
	return true
end

if wolf_modifier == nil then
wolf_modifier = class({})
end

function wolf_modifier:IsHidden()
	return false
end

function wolf_modifier:RemoveOnDeath()
	return true
end

if fish_modifier == nil then
fish_modifier = class({})
end

function fish_modifier:IsHidden()
	return false
end

function fish_modifier:RemoveOnDeath()
	return true
end

if bear_modifier == nil then
bear_modifier = class({})
end

function bear_modifier:IsHidden()
	return false
end

function bear_modifier:RemoveOnDeath()
	return true
end

if boar_modifier == nil then
boar_modifier = class({})
end

function boar_modifier:IsHidden()
	return false
end

function boar_modifier:RemoveOnDeath()
	return true
end

if spider_modifier == nil then
spider_modifier = class({})
end

function spider_modifier:IsHidden()
	return false
end

function spider_modifier:RemoveOnDeath()
	return true
end