-- WEAPONS
bDEBUGDRAW = false

function Rifle_Shoot( args )
        local caster = args.caster
        local target = args.target
        local ability = args.ability
        local durationstun = ability:GetSpecialValueFor('stun_time')

        local projectile = {
          EffectName = "particles/mirana_spell_crescent_arrow_rock12.vpcf",  -- "particles/sniper_bullet.vpcf"
          vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
          fDistance = args.FixedDistance,
          fStartRadius = args.StartRadius,
          fEndRadius = args.EndRadius,
          Source = caster,
          vVelocity = caster:GetForwardVector() * args.MoveSpeed,
          UnitBehavior = PROJECTILES_DESTROY,
          bMultipleHits = false,
          bIgnoreSource = true,
          TreeBehavior = PROJECTILES_DESTROY,
          bCutTrees = true,
          WallBehavior = PROJECTILES_NOTHING,
          GroundBehavior = PROJECTILES_NOTHING,
          fGroundOffset = 80,
          nChangeMax = 1,
          bRecreateOnChange = true,
          bZCheck = false,
          bGroundLock = true,
          draw = bDEBUGDRAW,
          bProvidesVision = true,
          iVisionRadius = args.VisionRadius,
          UnitTest = function(self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= caster:GetTeamNumber() or unit:GetUnitName() == "npc_bear" end,
          OnUnitHit = function(self, unit)
                local totalDamage = args.Damage
                local target = unit
                local damageTable = {
                                victim = target,
                                attacker = caster,
                                damage = totalDamage,
                                damage_type = DAMAGE_TYPE_PHYSICAL,
                        }
                ApplyDamage(damageTable)
                ability:ApplyDataDrivenModifier(caster,target,'modifier_stoped_stun',{duration = durationstun})
                if unit:GetUnitName() == "npc_dota_hero_omniknight" then 
--[[                    ParticleManager:CreateParticle("particles/items2_fx/hand_of_midas.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)   ]]
                        ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
--[[            elseif unit:GetUnitName() == "npc_bear" then
                        ParticleManager:CreateParticle("particles/newplayer_fx/npx_wood_break.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
                        unit:EmitSound("Item_Sniper.WoodBreak")  ]]
                end
          end
        }

        Projectiles:CreateProjectile(projectile)
end
