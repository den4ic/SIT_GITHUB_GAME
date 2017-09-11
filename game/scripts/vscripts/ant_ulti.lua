ant_ulti = class({})
LinkLuaModifier( "ant_ulti_modifier", "ant_ulti.lua", LUA_MODIFIER_MOTION_NONE )

function ant_ulti:GetCastRange( vLocation, hTarget )
    if self:GetCaster():HasScepter() then
        return 1000
    end

    return 600
end
function ant_ulti:GetCooldown( nLevel )
    if self:GetCaster():HasScepter() then
        return 10
    end

    return self.BaseClass.GetCooldown( self, nLevel )
end
--------------------------------------------------------------------------------

function ant_ulti:OnSpellStart()
    local hTarget = self:GetCursorTarget()
    if hTarget ~= nil then
        local target = hTarget
        local caster = self:GetCaster()
        local ability = self
        self.dur = self:GetSpecialValueFor( "duration" )
        -- self.strng = self:GetSpecialValueFor( "arm" )
        -- self.damage = self:GetSpecialValueFor( "dmg" )
		
		if not caster:HasItemInInventory("item_meat") then
		self:EndCooldown()
		--self:RefundManaCost()
		Notifications:Bottom(caster:GetPlayerID(), {text="#need_item_meat", duration=1, style={color="red", ["font-size"]="35px"}})
		  else
		if RollPercentage(self:GetSpecialValueFor( "chance" )) then -- процент шанса
        if caster:HasItemInInventory("item_meat") then
        caster:EmitSound("Hero_Chen.HolyPersuasionCast")
        local spawn_location = target:GetAbsOrigin()
        local npc = CreateUnitByName( target:GetUnitName(), spawn_location, true, caster, caster:GetOwner(), caster:GetTeamNumber())
        npc:SetControllableByPlayer(caster:GetPlayerID(), false)
        -- local currModel = npc:GetModelScale()
        -- npc:SetModelScale(currModel*2)
        npc:AddNewModifier(caster, self, "ant_ulti_modifier", {duration = self.dur}) 
	    -- self.dur = math.random (200, 400)   
        npc:AddNewModifier(caster, self, "modifier_kill", {duration = self.dur}) 
			
		if npc:GetUnitName() == "npc_deer" then 
		caster:AddNewModifier(caster, self, "deer_modifier", {duration = self.dur}) --модиф для героя с таймером
		end
		
		if npc:GetUnitName() == "north_sheep" then 
		caster:AddNewModifier(caster, self, "sheep_modifier", {duration = self.dur})
		end
		
		if npc:GetUnitName() == "npc_fish" then 
		caster:AddNewModifier(caster, self, "fish_modifier", {duration = self.dur})
		end
		
		if npc:GetUnitName() == "Brown_Bear" then 
		caster:AddNewModifier(caster, self, "bear_modifier", {duration = self.dur})
		end
		
		if npc:GetUnitName() == "npc_boar" then 
		caster:AddNewModifier(caster, self, "boar_modifier", {duration = self.dur})
		end
		
		if npc:GetUnitName() == "Snow_Wolf" then 
		caster:AddNewModifier(caster, self, "wolf_modifier", {duration = self.dur})
		end
		
		if npc:GetUnitName() == "npc_spider" then 
		caster:AddNewModifier(caster, self, "spider_modifier", {duration = self.dur})
		end
		
		
        target:RemoveSelf()
		for i = 0,5 do
			local Item = caster:GetItemInSlot(i)
			if Item ~= nil and Item:GetName() == "item_meat" then 
				caster:RemoveItem(Item) 	
			end							
	     end
      end
  end
end
end
end

function ant_ulti:GetAbilityTextureName()
  return self.BaseClass.GetAbilityTextureName( self )
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

ant_ulti_modifier = class({})
function ant_ulti_modifier:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }

    return funcs
end
function ant_ulti_modifier:OnCreated( kv )
    self.strng = self:GetAbility():GetSpecialValueFor( "arm" )
    self.damage = self:GetAbility():GetSpecialValueFor( "dmg" )
    if IsServer() then
        local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
        ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_head", self:GetCaster():GetOrigin(), true )
        self:AddParticle( nFXIndex, false, false, -1, false, true )
    end
end
function ant_ulti_modifier:OnRefresh( kv )
    self.strng = self:GetAbility():GetSpecialValueFor( "arm" )
    self.damage = self:GetAbility():GetSpecialValueFor( "dmg" )
end

--------------------------------------------------------------------------------
function ant_ulti_modifier:GetModifierPhysicalArmorBonus( params )
    return self.strng
end

--------------------------------------------------------------------------------

function ant_ulti_modifier:	GetModifierHealthBonus( params )
    return self.strng
end
--------------------------------------------------------------------
--------------------------------------------------------------------------------

function ant_ulti_modifier:GetModifierPreAttack_BonusDamage( params )
    return self.damage
end
function ant_ulti_modifier:IsBuff()
    return true
end

function ant_ulti_modifier:IsHidden()
    return false
end

function ant_ulti_modifier:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function ant_ulti_modifier:RemoveOnDeath()
	return true
end