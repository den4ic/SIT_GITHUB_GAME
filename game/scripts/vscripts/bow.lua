function food(args)
		local player = args.caster:GetPlayerOwner()
		local pID = player:GetPlayerID()
        local caster = args.caster
        local target = args.target
        local ability = args.ability

        local projectile = {
          EffectName = "particles/units/heroes/hero_mirana/mirana_spell_arrow.vpcf",  -- "particles/sniper_bullet.vpcf"
          vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
          fDistance = args.FixedDistance,
          fStartRadius = args.StartRadius,
          fEndRadius = args.EndRadius,
          Source = caster,
          vVelocity = caster:GetForwardVector() * args.MoveSpeed,
          UnitBehavior = PROJECTILES_DESTROY,
          bMultipleHits = false,
          bIgnoreSource = true,
        -- TreeBehavior = PROJECTILES_DESTROY,
        -- bCutTrees = true,
          WallBehavior = PROJECTILES_NOTHING,
          GroundBehavior = PROJECTILES_NOTHING,
          fGroundOffset = 80,
          nChangeMax = 1,
          bRecreateOnChange = true,
          bZCheck = false,
          bGroundLock = true,
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
                if unit:GetUnitName() == "npc_dota_hero_omniknight" then 
--[[                    ParticleManager:CreateParticle("particles/items2_fx/hand_of_midas.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)   ]]
                        ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
--[[            elseif unit:GetUnitName() == "npc_bear" then
                        ParticleManager:CreateParticle("particles/newplayer_fx/npx_wood_break.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
                        unit:EmitSound("Item_Sniper.WoodBreak")  ]]
                end
          end
        }
		
		if caster:HasItemInInventory("item_quiver") then
        Projectiles:CreateProjectile(projectile)

			local item = nil
			local charges = 0
			local first = 0
				for i = 0, 8 do
					item = caster:GetItemInSlot(i)
					if item ~= nil then
						if item:GetAbilityName() == "item_quiver" and first == 0 then
							if item:IsStackable() == true then
								if item:GetCurrentCharges() > 1 then
									charges = item:GetCurrentCharges()
									item:SetCurrentCharges(charges-1)
								else
									caster:RemoveItem(item)
								end
							else
								caster:RemoveItem(item)			
							end
							first = 1
						end
					end
				end	
				
				elseif not caster:HasItemInInventory("item_quiver") then
					Notifications:Bottom(player:GetPlayerID(), {text="#need_item_quiver", duration=2, style={color="red", ["font-size"]="35px"}})
				end																
end
