----------------
--@By Den4iccc
----------------
function stone(keys)
	local player = keys.caster:GetPlayerOwner()
	local pID = player:GetPlayerID()
	local caster = keys.caster
	local ability = keys.ability
	--local hero = player:GetAssignedHero()
	local hero = PlayerResource:GetSelectedHeroEntity(pID)
	local iron = CreateItem("item_iron", nil, nil)
	--caster:AddItemByName("item_iron")
	local pos = caster:GetAbsOrigin()
	
	if hero:HasItemInInventory("item_axe_iron") then
	local gold = PlayerResource:ModifyGold(pID, math.random (7, 12), true, 0)
	if RollPercentage(40) then
		if caster:HasModifier("triggercheck") then
		CreateItemOnPositionSync(pos, iron)
		iron:LaunchLoot(false, 100, 0.75, pos + RandomVector(RandomFloat(80, 100)))
		Notifications:Bottom(player:GetPlayerID(), {text="#iron_found", duration=1, style={color="#32CD32", ["font-size"]="35px"}})
		end
	end
	POPUP_SYMBOL_PRE_PLUS = 0 
	local pfxPath = string.format("particles/msg_fx/msg_damage.vpcf", pfx)
	local pidx = ParticleManager:CreateParticle(pfxPath, PATTACH_ABSORIGIN_FOLLOW, caster)
	local color = Vector(192, 192, 192) --silver
	local lifetime = 3.0
	local digits = #tostring(gold) + 1  
	ParticleManager:SetParticleControl(pidx, 1, Vector( POPUP_SYMBOL_PRE_PLUS, gold, 0 ) )
	ParticleManager:SetParticleControl(pidx, 2, Vector(lifetime, digits, 0))
	ParticleManager:SetParticleControl(pidx, 3, color)
	elseif not hero:HasItemInInventory("item_axe_iron") then
	local gold = PlayerResource:ModifyGold(pID, math.random (4, 10), true, 0)
	if RollPercentage(20) then 
		if caster:HasModifier("triggercheck") then
		CreateItemOnPositionSync(pos, iron)
		iron:LaunchLoot(false, 100, 0.75, pos + RandomVector(RandomFloat(80, 100)))
		Notifications:Bottom(player:GetPlayerID(), {text="#iron_found", duration=1, style={color="#32CD32", ["font-size"]="35px"}})
		end
	end
	POPUP_SYMBOL_PRE_PLUS = 0 
	local pfxPath = string.format("particles/msg_fx/msg_damage.vpcf", pfx)
	local pidx = ParticleManager:CreateParticle(pfxPath, PATTACH_ABSORIGIN_FOLLOW, caster)
	local color = Vector(192, 192, 192) --silver
	local lifetime = 3.0
	local digits = #tostring(gold) + 1	    
	ParticleManager:SetParticleControl(pidx, 1, Vector( POPUP_SYMBOL_PRE_PLUS, gold, 0 ) )
	ParticleManager:SetParticleControl(pidx, 2, Vector(lifetime, digits, 0))
	ParticleManager:SetParticleControl(pidx, 3, color)
	end
end
	
 
 
 
	--[[local gold = PlayerResource:ModifyGold(pID, math.random (4, 10), true, 0)
	
	POPUP_SYMBOL_PRE_PLUS = 0 
	local pfxPath = string.format("particles/msg_fx/msg_damage.vpcf", pfx)
	local pidx = ParticleManager:CreateParticle(pfxPath, PATTACH_ABSORIGIN_FOLLOW, caster)
	local color = Vector(192, 192, 192) --silver
	local lifetime = 3.0
	local digits = #tostring(gold) + 1
		    
	ParticleManager:SetParticleControl(pidx, 1, Vector( POPUP_SYMBOL_PRE_PLUS, gold, 0 ) )
	ParticleManager:SetParticleControl(pidx, 2, Vector(lifetime, digits, 0))
	ParticleManager:SetParticleControl(pidx, 3, color)]]
	
