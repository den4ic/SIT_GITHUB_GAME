if item_rocket == nil then 
item_rocket = class({}) 
end

fvPointOrigin = 0
function item_rocket:GetConceptRecipientType()
	return DOTA_SPEECH_USER_ALL
end
local vPoint
function item_rocket:SpeakTrigger()
	return DOTA_ABILITY_SPEAK_CAST
end

function item_rocket:GetChannelTime()
	return 1
end

function item_rocket:OnAbilityPhaseStart()
	if IsServer() then
		self.vPoint = self:GetCursorPosition()
	end

	return true
end

function item_rocket:OnSpellStart()
    if IsServer() then

    end
end

function item_rocket:OnChannelFinish( bInterrupted )
	if bInterrupted == false then
        local vDirection = self.vPoint - self:GetCaster():GetOrigin()
        vDirection = vDirection:Normalized()

        self.speed = 3000/25
        self.leap_z = 0
        self.traveled = 0
        self.start_pos = self:GetCaster():GetAbsOrigin()
        self.distance = (self.vPoint - self:GetCaster():GetOrigin()):Length2D()

        fvPointOrigin = self.vPoint
        self.info = {
            Ability = self,
            vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
            fStartRadius = 320,
            fEndRadius = 320,
            vVelocity = vDirection * (self:GetSpecialValueFor("arrow_speed") + 2000),
            fDistance = self.distance,
            Source = self:GetCaster(),
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
            iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
            bProvidesVision = true,
            iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
            iVisionRadius = 400,
        }
        self.nProjID = ProjectileManager:CreateLinearProjectile( self.info )

        self.nParticleFXIndex = ParticleManager:CreateParticle( "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_sparks.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetCaster() )
        ParticleManager:SetParticleAlwaysSimulate( self.nParticleFXIndex )

    --  EmitSoundOn( "Ability.Powershot.Alt" , self:GetCaster() )
    --  EmitSoundOn( "Hero_Windrunner.Powershot.FalconBow" , self:GetCaster() )
    --  EmitSoundOn( "Ability.Powershot" , self:GetCaster() )
    --  EmitSoundOn( "Hero_AbyssalUnderlord.Pit.TargetHero" , self:GetCaster() )
    end
end

function item_rocket:OnProjectileHit( hTarget, vLocation ) -- item_rocket:OnProjectileHit_ExtraData( hTarget, vLocation, table ) ДЛЯ АБИЛИТИ ЛУА
    if hTarget == nil then
        local hCaster = self:GetCaster()
        local nFXIndex = ParticleManager:CreateParticle( "particles/econ/items/clockwerk/clockwerk_paraflare/clockwerk_para_rocket_flare_illumination.vpcf", PATTACH_CUSTOMORIGIN, nil );
        ParticleManager:SetParticleControl( nFXIndex, 0, vLocation);
        ParticleManager:SetParticleControl( nFXIndex, 1, Vector(self:GetSpecialValueFor("arrow_width"), self:GetSpecialValueFor("arrow_width"), 0));
        ParticleManager:SetParticleControl( nFXIndex, 3, vLocation);
        ParticleManager:SetParticleControl( nFXIndex, 5, Vector(350, 350, 0));
        ParticleManager:ReleaseParticleIndex( nFXIndex );

        EmitSoundOnLocationWithCaster(vLocation, "Hero_ElderTitan.EarthSplitter.Cast", hCaster)
	--  EmitSoundOnLocationWithCaster(vLocation, "Hero_EarthShaker.EchoSlamSmall", hCaster)
	--  EmitSoundOnLocationWithCaster(vLocation, "PudgeWarsClassic.echo_slam", hCaster)

        ParticleManager:DestroyParticle(self.nParticleFXIndex, true)
	--  EmitSoundOn( "Hero_ObsidianDestroyer.SanityEclipse", self:GetCaster() )
        
		local nFXIndex = ParticleManager:CreateParticle( "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf", PATTACH_CUSTOMORIGIN, nil )
        ParticleManager:SetParticleControl(nFXIndex, 0, vLocation)
        ParticleManager:SetParticleControl(nFXIndex, 1, Vector(self:GetSpecialValueFor("arrow_width"), self:GetSpecialValueFor("arrow_width"), 0))
        ParticleManager:SetParticleControl(nFXIndex, 2, vLocation)
        ParticleManager:SetParticleControl(nFXIndex, 3, vLocation)
        ParticleManager:ReleaseParticleIndex(nFXIndex)

        AddFOWViewer(self:GetCaster():GetTeamNumber(), vLocation, 1200, 20, false) -- true off tree vision  1200 20
		hCaster:RemoveItem(self)
        return nil
    end
end

function item_rocket:OnProjectileThink( vLocation )
    if self.traveled < self.distance/2 then
		-- Go up
		-- This is to memorize the z point when it comes to cliffs and such although the division of speed by 2 isnt necessary, its more of a cosmetic thing
		self.leap_z = self.leap_z + (self.speed/2)
		-- Set the new location to the current ground location + the memorized z point
        ParticleManager:SetParticleControl( self.nParticleFXIndex, 0, vLocation + Vector(0, 0, self.leap_z))
        ParticleManager:SetParticleControl( self.nParticleFXIndex, 1, vLocation + Vector(0, 0, self.leap_z))
        ParticleManager:SetParticleControl( self.nParticleFXIndex, 2, vLocation + Vector(0, 0, self.leap_z))
        ParticleManager:SetParticleControl( self.nParticleFXIndex, 3, vLocation + Vector(0, 0, self.leap_z))
        ParticleManager:SetParticleControl( self.nParticleFXIndex, 4, vLocation + Vector(0, 0, self.leap_z))
	else
		-- Go down
		self.leap_z = self.leap_z - (self.speed/2)
		ParticleManager:SetParticleControl( self.nParticleFXIndex, 0, vLocation + Vector(0, 0, self.leap_z))
        ParticleManager:SetParticleControl( self.nParticleFXIndex, 1, vLocation + Vector(0, 0, self.leap_z))
        ParticleManager:SetParticleControl( self.nParticleFXIndex, 2, vLocation + Vector(0, 0, self.leap_z))
        ParticleManager:SetParticleControl( self.nParticleFXIndex, 3, vLocation + Vector(0, 0, self.leap_z))
        ParticleManager:SetParticleControl( self.nParticleFXIndex, 4, vLocation + Vector(0, 0, self.leap_z))
	end
    self.traveled = (vLocation - self.start_pos):Length2D()
end

function item_rocket:GetAbilityTextureName() return self.BaseClass.GetAbilityTextureName(self) end 
