triggercheck = class({})
function triggercheck:IsHidden()
	return true
end
function triggercheck:GetTexture()
    return "brewmaster_drunken_haze"
end
function triggercheck:RemoveOnDeath()
	return true
end