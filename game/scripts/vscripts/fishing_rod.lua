function rod(keys)
    local caster = keys.caster
		 
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 250,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )

	
	   if units[1] then 
	if units[1]:IsCreep() then
	if units[1]:GetUnitName() == "npc_fish" then
	--units[1]:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK) -- DOTA_UNIT_CAP_NO_ATTACK DOTA_UNIT_CAP_MELEE_ATTACK
	units[1]:ForceKill(false)
		else
	if units[1]:IsCreep() then
	Notifications:Bottom(caster:GetPlayerID(), {text="#need_cost_fish", duration=1, style={color="red", ["font-size"]="35px"}})
  --  caster:Stop() 
   end	
  end
 end
end
end
