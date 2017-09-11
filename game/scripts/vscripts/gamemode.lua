-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode


-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false

if GameMode == nil then
    _G.GameMode = class({})
end
require('wearables')


require('libraries/timers')
require('libraries/physics')
require('libraries/projectiles')
require('libraries/notifications')
require('libraries/animations')

require('create_woodi')
require('libraries/FlashUtil')
require('libraries/buildinghelper')
require('buildings/bh_abilities')

require('settings')
require('internal/events')
require('events')
require('units/kvn_fan')
require('internal/gamemode')

function GameMode:PostLoadPrecache()
  DebugPrint("[BAREBONES] Performing Post-Load precache")    
  
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  DebugPrint("[BAREBONES] First Player has loaded")
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  DebugPrint("[BAREBONES] All Players have loaded into the game")
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]

function GameMode:OnHeroInGame(hero)
  DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())
  
  GameMode.assignedPlayerHeroes = GameMode.assignedPlayerHeroes or {}
  if hero:GetClassname() == "npc_dota_hero_wisp" and not GameMode.assignedPlayerHeroes[pID] then
  craft_menu:StartGame()
  hero:SetGold(0, false)
  
  local team = hero:GetTeamNumber()
  local player = hero:GetPlayerOwner()
  local pID = player:GetPlayerID()

    local newHero

    MoveCamera(pID, hero)

	Timers:CreateTimer(RandomInt(0, 100),function() -- на 3 сек
		  --endTime = 20
		    -- GameRules:SetTimeOfDay(math.random (0.26, 1))	
			local snow = ParticleManager:CreateParticle("particles/rain_fx/econ_snow.vpcf", PATTACH_EYES_FOLLOW, player) --newHero если встроить в team 2 или player 
		 
		 Timers:CreateTimer(300,function() -- складывание на +3 сек (будет идти) если есть рандом
			ParticleManager:DestroyParticle(snow, false)
			return nil
		end)
     end)
	 

	 Timers:CreateTimer(RandomInt(450, 850),function() -- от 16 сек до 24 сек запустится / RandomInt(126, 134)
		local rain = ParticleManager:CreateParticle("particles/rain_fx/econ_rain.vpcf", PATTACH_EYES_FOLLOW, player) --newHero если встроить в team 2 или player 
		MyMegaTimerLightning()
		Timers:CreateTimer(300,function() -- складывание на +4 сек / 120
			ParticleManager:DestroyParticle(rain, false)	
			Timers:RemoveTimer("timerlightning")
			return nil
		end)
     end)
	 
	 Timers:CreateTimer(RandomInt(1024, 1620),function() -- на 3 сек
		  --endTime = 20
		    -- GameRules:SetTimeOfDay(math.random (0.26, 1))	
			local snow = ParticleManager:CreateParticle("particles/rain_fx/econ_snow.vpcf", PATTACH_EYES_FOLLOW, player) --newHero если встроить в team 2 или player 
		 
		 Timers:CreateTimer(300,function() -- складывание на +3 сек (будет идти) если есть рандом
			ParticleManager:DestroyParticle(snow, false)
			return nil
		end)
     end)

 --   UTIL_Remove( hero )

     -- Init kvn fan
    if team == 2 then
      PrecacheUnitByNameAsync("npc_dota_hero_omniknight",
        function() 
          Notifications:Top(pID, {text="#start_game", duration=5, style={color="white", ["font-size"]="45px"}}) -- Багается дерево талантов, если убрать 

          newHero = PlayerResource:ReplaceHeroWith(pID,"npc_dota_hero_omniknight",0,0)
          InitAbilities(newHero)

          newHero:SetAbilityPoints(0)

      --  newHero:AddItemByName("item_snap_trap") -- item_mana_potion_small
      --  newHero:AddItemByName("item_meat")
      --  newHero:AddItemByName("item_net_hunting") --item_wood item_wood_damage
		  newHero:AddItemByName("item_rocket") -- item_rocket item_fishing_rod
	  --  newHero:AddItemByName("item_woods") -- item_wood_damage item_bow
	  --  newHero:AddItemByName("item_iron") -- item_wea
	      newHero:AddItemByName("item_canned_goods") -- item_wea item_quiver item_canned_goods
      --  newHero:AddItemByName("item_shield_of_heaven")
      --  newHero:AddItemByName("item_northern_wolf_shield") 
      --  newHero:AddItemByName("item_fly_vision_bonus") 

          newHero.spawnPosition = newHero:GetAbsOrigin()
		   
        --  mode:SetHUDVisible(4, false) -- DOTA_HUD_VISIBILITY_ACTION_MINIMAP - показывает/убирает миникарту
        --  mode:SetHUDVisible(6, false) -- DOTA_HUD_VISIBILITY_INVENTORY_SHOP - показывает/убирает кнопку магазина
       --  mode:SetHUDVisible(1, false) -- DOTA_HUD_VISIBILITY_TOP_HEROES - показывает/убирает список героев сверху   

          player.lumber = 100
          player.food = 100
        end, pID)
    end

     -- Init del team
    if team == 3 then
      PrecacheUnitByNameAsync("npc_dota_hero_brewmaster",
        function() 
          newHero = PlayerResource:ReplaceHeroWith(pID,"npc_dota_hero_brewmaster",0,0)

          newHero:SetAbilityPoints(4)

          newHero:SetGold(32, false)

          newHero.spawnPosition = newHero:GetAbsOrigin()

          if GameRules.explorationTowerCreated == nil then
            GameRules.explorationTowerCreated = true
            Timers:CreateTimer(0.2,
            function()
              CreateUnitByName( "npc_petri_exploration_tower" , Vector(784,1164,129) , true, nil, nil, DOTA_TEAM_BADGUYS )
              end)
          end
        end, pID)
    end

    player.food = 0
    player.maxFood = 100
    player.lumber = player.lumber or 0

    --Send lumber and food info to users
    CustomGameEventManager:Send_ServerToPlayer( player, "petri_set_ability_layouts", GameMode.abilityLayouts )
    --Update player's UI в панораме
    Timers:CreateTimer(0.03,
    function()
      local event_data =
      {
          gold = PlayerResource:GetGold(player:GetPlayerID()),
          lumber = player.lumber,
          food = player.food,
          maxFood = player.maxFood
      }
      CustomGameEventManager:Send_ServerToPlayer( player, "receive_resources_info", event_data )
      return 0.35
    end)
	
	-- Timers:CreateTimer(0.04,
    -- function()
      -- local event_datas =
      -- {
			-- ParticleManager:CreateParticle("particles/rain_fx/econ_rain.vpcf", PATTACH_EYES_FOLLOW, player)
      -- }
      -- CustomGameEventManager:Send_ServerToPlayer( player, "game_rules_state_change", event_datas )
      -- return 0.35
    -- end)
	
  end
end

function MyMegaTimerLightning()
    Timers:CreateTimer("timerlightning", {
	 useOldStyle = true,
	 endTime = GameRules:GetGameTime() + 1,
	 callback = function()
	
	local particle = ParticleManager:CreateParticle("particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_bolt_down.vpcf", PATTACH_CUSTOMORIGIN, nil) 
		
				first1 = true
				first2 = true
				first3 = true
				for playerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
				local hero = PlayerResource:GetSelectedHeroEntity(playerID)
				local teams = PlayerResource:GetTeam(playerID)	
				local vector_list = { [1] = Vector(-3264,-11648,32), -- -672,-736,160 544,32,160 -416,-64,160
									  [2] = Vector(-1728,11648,32),
									  [3] = Vector(-6912,-12608,160)}
			
				for i = 1, #vector_list do	
				 v1 = vector_list[1]	 		
				 v2 = vector_list[2]
				 v3 = vector_list[3]
				local r = RandomInt(1,100)
				if r >= 95 then
				if first1 then
				first2 = false
				first3 = false
			--	v2 = nil
			--	v3 = nil
					ParticleManager:SetParticleControl( particle, 0, v1	)		
				local uni = FindUnitsInRadius(teams, v1, nil, 150, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
				EmitSoundOnLocationWithCaster(v1, "Hero_Zuus.GodsWrath.Target", hero)
				for i, un in ipairs(uni) do
					if un:IsHero() then
						un:ForceKill(false)	
							ParticleManager:CreateParticle("particles/econ/items/zeus/arcana_chariot/zeus_tgw_screen_damage.vpcf", PATTACH_EYES_FOLLOW, hero) 
							GameRules:SendCustomMessage("#kill_lightning", playerID, 0)
						end
					end				
				end
				elseif r >= 90 then
				if first2 then
				first1 = false
				first3 = false
			--	v1 = nil
			--	v3 = nil
					ParticleManager:SetParticleControl( particle, 0, v2	)		
				local uni = FindUnitsInRadius(teams, v2, nil, 150, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
					EmitSoundOnLocationWithCaster(v2, "Hero_Zuus.GodsWrath.Target", hero)
					for i, un in ipairs(uni) do
					if un:IsHero() then
						un:ForceKill(false)	
							ParticleManager:CreateParticle("particles/econ/items/zeus/arcana_chariot/zeus_tgw_screen_damage.vpcf", PATTACH_EYES_FOLLOW, hero) 
							GameRules:SendCustomMessage("#kill_lightning", playerID, 0)														
						end
					end	
				end
				elseif r >= 80 then
				if first3 then
				first1 = false
				first2 = false
			--	v1 = nil
			--	v2 = nil
					ParticleManager:SetParticleControl( particle, 0, v3	)		
				local uni = FindUnitsInRadius(teams, v3, nil, 150, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
					EmitSoundOnLocationWithCaster(v3, "Hero_Zuus.GodsWrath.Target", hero)
					for i, un in ipairs(uni) do
					if un:IsHero() then
						un:ForceKill(false)
							ParticleManager:CreateParticle("particles/econ/items/zeus/arcana_chariot/zeus_tgw_screen_damage.vpcf", PATTACH_EYES_FOLLOW, hero) 
							GameRules:SendCustomMessage("#kill_lightning", playerID, 0)						  -- или EmitSoundOn("Hero_ElderTitan.EarthSplitter.Cast", hero) EmitGlobalSound("name_sound") для всех
						end
					 end	
				   end
			     end
		       end
	         end
		 	return GameRules:GetGameTime() + 2
		end
		})
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]

_G.currentcreeps = {
  fish = 0,
}

function GameMode:OnGameInProgress()
Timers:CreateTimer(10,function()
  EmitGlobalSound("sound_of_winter")
return nil
end)

  DebugPrint("[BAREBONES] The game has officially begun")

  --[[  CreateUnitByName("spider", Vector(160,-928,160), true, npc_owner, unit_owner, DOTA_TEAM_BADGUYS);
    CreateUnitByName("npc_fish", Vector(-1056,-288,160), true, npc_owner, unit_owner, DOTA_TEAM_BADGUYS);
    CreateUnitByName("Snow_Wolf", Vector(-480,1312,160), true, npc_owner, unit_owner, DOTA_TEAM_BADGUYS);
    CreateUnitByName("Northern_Wolf", Vector(896,-256,160), true, npc_owner, unit_owner, DOTA_TEAM_BADGUYS); 
    CreateUnitByName("npc_bear", Vector(-1667.98,-1526.27,160), true, npc_owner, unit_owner, DOTA_TEAM_BADGUYS); 
    CreateUnitByName("north_sheep", Vector(-201.729,-844.22,160), true, npc_owner, unit_owner, DOTA_TEAM_BADGUYS); 
    CreateUnitByName("Northern_Bear", Vector(1478.65,-1653.72,160), true, npc_owner, unit_owner, DOTA_TEAM_BADGUYS); 
    CreateUnitByName("npc_deer", Vector(1099.51,1222.89,160), true, npc_owner, unit_owner, DOTA_TEAM_BADGUYS); 
    CreateUnitByName("npc_boar", Vector(1058.71,1199.74,160), true, npc_owner, unit_owner, DOTA_TEAM_BADGUYS); --]]
	
	--[[local unit = CreateUnitByName("npc_fish",  Vector(-1056,-288,160), true, nil, nil, DOTA_TEAM_BADGUYS ) 
    unit:AddNewModifier(unit, nil, "modifier_invulnerable", {})  --]]

	--local unit = CreateUnitByName("lightning_trap",  Vector(-1056,-288,160), true, nil, nil, DOTA_TEAM_BADGUYS ) 
	--unit:AddNewModifier(unit, nil, "modifier_kill", {duration = 30.0})
	
	--10240 8640 128 models/props_structures/gate_entrance002.vmdl
	-- -1376 -11872 32
	--CreateUnitByName("npc_walls", Vector(-1376,-11872,32), true, nil, nil, DOTA_TEAM_BADGUYS ) 
	
	--local unit = CreateUnitByName("npc_walls", Vector(-1376,-11872,32), true, nil, nil, DOTA_TEAM_BADGUYS ) 


	-- -3296 -9952 32
	-- -2016 -11424 32
	-- -5408 -12256 32  -- fish
	-- -2400 -12576 32
	-- -736  -12704 32
	-- npc_fish
	
	local centr = Vector(-2236.24,-12671.7,32)
	
	CreateUnitByName("npc_fish", Vector(-3296,-9952,32), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_fish", Vector(-2016,-11424,32), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_fish", Vector(-5408,-12256,32), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_fish", Vector(-2400,-12576,32), true, nil, nil, DOTA_TEAM_BADGUYS )
	--local fish_right = CreateUnitByName("npc_fish", Vector(-736,-12704,32), true, nil, nil, DOTA_TEAM_BADGUYS )
	--fish_right:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
	
	for i=1,3 do
		local fish_right = CreateUnitByName("npc_fish", centr + RandomVector(RandomInt(0,10)), true, nil, nil, DOTA_TEAM_BADGUYS)
		fish_right:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
		currentcreeps["fish"] = currentcreeps["fish"] + 1
	end
	
	
	local centr_deer1 = Vector(10080,-6240,160)
	local centr_deer2 = Vector(4960,-11360,160)
	local centr_deer3 = Vector(-10208,3232,160)
	for i=1,4 do
		local fish_right = CreateUnitByName("npc_deer", centr_deer1 + RandomVector(RandomInt(0,10)), true, nil, nil, DOTA_TEAM_BADGUYS)
		fish_right:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
	end
	for i=1,4 do
		local fish_right = CreateUnitByName("npc_deer", centr_deer2 + RandomVector(RandomInt(0,10)), true, nil, nil, DOTA_TEAM_BADGUYS)
		fish_right:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
	end
	for i=1,4 do
		local fish_right = CreateUnitByName("npc_deer", centr_deer3 + RandomVector(RandomInt(0,10)), true, nil, nil, DOTA_TEAM_BADGUYS)
		fish_right:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
	end

	local centr_spider1 = Vector(2528,-1696,160)
	local centr_spider2 = Vector(-2464,6496,160)
	local centr_spider3 = Vector(-4832,-6688,160)
	for i=1,3 do
		local fish_right = CreateUnitByName("npc_spider", centr_spider1 + RandomVector(RandomInt(0,10)), true, nil, nil, DOTA_TEAM_BADGUYS)
		fish_right:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
	end
	for i=1,4 do
		local fish_right = CreateUnitByName("npc_spider", centr_spider2 + RandomVector(RandomInt(0,10)), true, nil, nil, DOTA_TEAM_BADGUYS)
		fish_right:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
	end
	for i=1,3 do
		local fish_right = CreateUnitByName("npc_spider", centr_spider3 + RandomVector(RandomInt(0,10)), true, nil, nil, DOTA_TEAM_BADGUYS)
		fish_right:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
	end
	
	
	CreateUnitByName("npc_deer", Vector(-10784, -11680,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_deer", Vector(-8288,-12832,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_deer", Vector(-2176,-10240,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_deer", Vector(-3552,-928,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_deer", Vector(2464,-11040,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_deer", Vector(5120,-12800,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_deer", Vector(1312,-6688,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("north_sheep", Vector(-3552,-6304,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("north_sheep", Vector(-8672,-8672,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("north_sheep", Vector(-10528,-12960,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("north_sheep", Vector(-2976,-5472,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("north_sheep", Vector(-1696,-1952,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-12640,-4640,160), true, nil, nil, DOTA_TEAM_BADGUYS ) 
	CreateUnitByName("Snow_Wolf", Vector(-9760,-2848,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-6368,-2016,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-7392,-416,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-11936,5088,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-12064,3552,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-9440,4832,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-9952,3104,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-12512,-4576,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-7648,-736,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Wolf", Vector(-6752,2400,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_spider", Vector(-6816,5024,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	
	CreateUnitByName("npc_bear", Vector(-8704,11328,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Brown_Bear", Vector(-12832,10144,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Brown_Bear", Vector(-8704,8448,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Bear", Vector(-11488,11936,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Bear", Vector(-6432,12576,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Bear", Vector(-3008,12480,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Wolf", Vector(-1824,8416,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Wolf", Vector(-4800,6592,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Wolf", Vector(-2528,5024,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Wolf", Vector(1792,2368,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Wolf", Vector(9824,-12832,160), true, nil, nil, DOTA_TEAM_BADGUYS )

	CreateUnitByName("npc_bear", Vector(2464,11744,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Bear", Vector(800,12640,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Brown_Bear", Vector(1056,10272,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Brown_Bear", Vector(3776,10048,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Brown_Bear", Vector(1120,7840,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Bear", Vector(3872,4576,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_bear", Vector(10272,7648,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_bear", Vector(5984,10656,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Wolf", Vector(7776,7648,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(6624,5664,160), true, nil, nil, DOTA_TEAM_BADGUYS )

	CreateUnitByName("Northern_Wolf", Vector(8608,2144,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Wolf", Vector(12832,4576,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Wolf", Vector(9760,4192,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Bear", Vector(12256,-1120,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Northern_Bear", Vector(12288,-6464,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	
	CreateUnitByName("Snow_Wolf", Vector(1952,-12640,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(5088,-11744,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(4256,-8864,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(1824,-4192,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(4288,-384,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(1824,-608,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(2400,3616,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-3104,4064,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(3712,896,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(7584,-7296,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(10208,-9408,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(10976,-7520,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(7520,-4576,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(9312,2656,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-11616,-12192,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("Snow_Wolf", Vector(-2400,-7264,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_spider", Vector(5088,-11616,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_spider", Vector(9056,-11744,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_spider", Vector(11360,-7648,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_spider", Vector(7392,-5344,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_spider", Vector(11744,-736,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	CreateUnitByName("npc_spider", Vector(8288,6368,160), true, nil, nil, DOTA_TEAM_BADGUYS )
	
	-- CreateUnitByName("", Vector(,,160), true, nil, nil, DOTA_TEAM_BADGUYS )

	local item_list = { [1] = "item_northern_mushroom",
						[2] = "item_cowberry",
						[3] = "item_blueberry",
						[4] = "item_northern_mushroom",
						[5] = "item_cowberry",
						[6] = "item_blueberry",
						[7] = "item_northern_mushroom",
						[8] = "item_cowberry",
						[9] = "item_blueberry",
						[10] = "item_northern_mushroo",
						[11] = "item_cowberry",
						[12] = "item_blueberry",
						[13] = "item_northern_mushroo",
						[14] = "item_cowberry",
						[15] = "item_blueberry",
						[16] = "item_northern_mushroo",
						[17] = "item_cowberry",
						[18] = "item_blueberry",
						[19] = "item_northern_mushroo",
						[20] = "item_cowberry",
						[21] = "item_blueberry",
						[22] = "item_northern_mushroo",
						[23] = "item_cowberry",
						[24] = "item_blueberry",
						[25] = "item_northern_mushroo",
						[26] = "item_cowberry",
						[27] = "item_blueberry",
						[28] = "item_northern_mushroo",
						[29] = "item_cowberry",
						[30] = "item_blueberry",
						[31] = "item_northern_mushroo",
						[32] = "item_cowberry",
						[33] = "item_blueberry",
						[34] = "item_northern_mushroo",
						[35] = "item_cowberry",
						[36] = "item_blueberry",
						[37] = "item_northern_mushroo",
						[38] = "item_cowberry",
						[39] = "item_blueberry",
						[40] = "item_northern_mushroo",
						[41] = "item_cowberry",
						[42] = "item_blueberry",
						[43] = "item_northern_mushroo",
						[44] = "item_cowberry",
						[45] = "item_blueberry",
						[46] = "item_northern_mushroo",
						[47] = "item_cowberry",
						[48] = "item_blueberry",
						[49] = "item_northern_mushroo",
						[50] = "item_cowberry"};
	                            
  local vector_list = { [1] = Vector(-6912,-12160,160),
						[2] = Vector(-10240,-12160,160),
						[3] = Vector(-12800,-13120,160),
						[4] = Vector(-13120,-12096,160),
						[5] = Vector(-10624,-10112,160),
						[6] = Vector(-7424,-9984,160),
						[7] = Vector(-5696,-8512,160),
						[8] = Vector(-4800,-9152,160),
						[9] = Vector(-1728,-8832,160),
						[10] = Vector(-2688,-10304,160),
						[11] = Vector(640,-9728,160),
						[12] = Vector(-2048,-4480,160),
						[13] = Vector(1408,-5376,160),
						[14] = Vector(2176,-4160,160),
						[15] = Vector(1600,-704,160),
						[16] = Vector(3520,832,160),
						[17] = Vector(64,2944,160),
						[18] = Vector(192,4480,160),
						[19] = Vector(-4096,5184,160),
						[20] = Vector(-1856,8512,160),
						[21] = Vector(-4736,6848,160),
						[22] = Vector(576,11200,160),
						[23] = Vector(2624,11648,160),
						[24] = Vector(2816,10048,160),
						[25] = Vector(-8448,8256,160),
						[26] = Vector(-11136,10752,160),
						[27] = Vector(-8384,11712,160),
						[28] = Vector(-4352,12224,160),
						[29] = Vector(5184,11328,160),
						[30] = Vector(6400,9408,160),
						[31] = Vector(8704,6784,160),
						[32] = Vector(11584,4480,160),
						[33] = Vector(9024,1984,160),
						[34] = Vector(6400,960,160),
						[35] = Vector(4992,-640,160),
						[36] = Vector(12992,896,160),
						[37] = Vector(11008,-448,160),
						[38] = Vector(11904,-3136,160),
						[39] = Vector(11136,-6336,160),
						[40] = Vector(9152,-5696,160),
						[41] = Vector(11200,-8000,160),
						[42] = Vector(9088,-8704,160),
						[43] = Vector(8128,-4608,160),
						[44] = Vector(7552,-5440,160),
						[45] = Vector(7104,-4672,160),
						[46] = Vector(7552,64,160),
						[47] = Vector(8448,6336,160),
						[48] = Vector(-9856,-3840,160),
						[49] = Vector(-8576,-2432,160),
						[50] = Vector(-2048,-1728,160)};

  -- local item_list = { [1] = "item_northern_mushroom", --item_blueberry
                      -- [2] = "item_cowberry", -- item_cosmetic_scythe  item_northern_mushroom
                      -- [3] = "item_blueberry"};
  -- local vector_list = { [1] = Vector(-672,-736,160),
                        -- [2] = Vector(544,32,160),
                        -- [3] = Vector(-416,160,160)};
  for i = 1, #item_list do
      local item = CreateItem(item_list[i], nil, nil);
      CreateItemOnPositionSync(vector_list[math.random(#vector_list)], item);
  end  

  Timers:CreateTimer(30, -- Start this timer 30 game-time seconds later
    function()
      DebugPrint("This function is called 30 seconds after the game begins, and every 30 seconds thereafter")
      return 30.0 -- Rerun this timer every 30 game-time seconds 
    end)
end

function GameMode:OnUnitSelected(args)
end

function GameMode:HasItemInInventory(itemName,bIncludeBackpack)
  local bIncludeBackpack = bIncludeBackpack or false
  local slots = bIncludeBackpack and 8 or 5

  for i = 0, slots do
    local item = self:GetItemInSlot(i)
    if item and item:GetAbilityName() == itemName then
      return true
    end
  end
  return false
end

function GameMode:InitGameMode()
  GameMode = self
  self.VoteTable = {}
  
  GameMode:_InitGameMode()
  SendToServerConsole( "dota_combine_models 0" )
 --ListenToGameEvent("dota_player_killed", Dynamic_Wrap(GameMode, "OnHeroKilled"), self)
  ListenToGameEvent("entity_killed", Dynamic_Wrap(GameMode, "OnHeroKilled"), self)
 -- ОТКЛЮЧЕНО ListenToGameEvent("dota_player_pick_hero", Dynamic_Wrap(GameMode, "OnHeroPicked"), self)
 -- 	print( "Template addon is loaded." )
  CustomGameEventManager:RegisterListener("event_test", Dynamic_Wrap(GameMode, 'OnTest'))			
  CustomGameEventManager:RegisterListener( "setting_vote", 	Dynamic_Wrap(GameMode, "OnSettingVote"))
  
  --CustomGameEventManager:RegisterListener("craft_axe_tree", Dynamic_Wrap(GameMode, 'Craft_Tree'))
  
  CustomGameEventManager:RegisterListener("on_ally", Dynamic_Wrap(GameMode,'OnAlly'))
  CustomGameEventManager:RegisterListener("off_ally", Dynamic_Wrap(GameMode,'OffAlly'))
  CustomGameEventManager:RegisterListener("window_ally", Dynamic_Wrap(GameMode,'Window'))  
 -- CustomGameEventManager:RegisterListener("BuyItem", Dynamic_Wrap(GameMode, 'BuyItem'))	
  
  LinkLuaModifier("die_chance", "libraries/modifiers/die_chance.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("die_freeze", "libraries/modifiers/die_chance.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("die_check", "libraries/modifiers/die_chance.lua", LUA_MODIFIER_MOTION_NONE )	
  LinkLuaModifier("die_chance_hunger", "libraries/modifiers/die_chance_hunger.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("die_freeze_hunger", "libraries/modifiers/die_chance_hunger.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("die_check_hunger", "libraries/modifiers/die_chance_hunger.lua", LUA_MODIFIER_MOTION_NONE )	  
  LinkLuaModifier("day_of_time_mana_regern", "libraries/modifiers/day_of_time_mana_regern.lua", LUA_MODIFIER_MOTION_NONE )	 
  LinkLuaModifier("night_of_time_mana_regern", "libraries/modifiers/day_of_time_mana_regern.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("modifier_shopkeeper_aura", "libraries/modifiers/modifier_shopkeeper.lua", LUA_MODIFIER_MOTION_NONE)
  LinkLuaModifier("modifier_shop", "libraries/modifiers/modifier_shopkeeper.lua", LUA_MODIFIER_MOTION_NONE)
  LinkLuaModifier( "ant_ulti_modifier", "ant_ulti.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier( "modifier_vision_ability", "libraries/modifiers/ability_speed1.lua", LUA_MODIFIER_MOTION_NONE ) 
  LinkLuaModifier( "modifier_speed_ability", "libraries/modifiers/ability_speed1.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier( "re_modifier_speed_ability", "libraries/modifiers/ability_speed1.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier( "modifier_damage_and_speed", "libraries/modifiers/ability_speed1.lua", LUA_MODIFIER_MOTION_NONE ) 
  LinkLuaModifier( "modifier_damage_and_speed_two", "libraries/modifiers/ability_speed1.lua", LUA_MODIFIER_MOTION_NONE ) 
  LinkLuaModifier( "modifier_damage_and_speed_three", "libraries/modifiers/ability_speed1.lua", LUA_MODIFIER_MOTION_NONE ) 
  LinkLuaModifier( "modifier_damage_and_speed_four", "libraries/modifiers/ability_speed1.lua", LUA_MODIFIER_MOTION_NONE ) 
  LinkLuaModifier( "modifier_damage_plus_speed_up", "libraries/modifiers/ability_speed1.lua", LUA_MODIFIER_MOTION_NONE ) 
  LinkLuaModifier( "modifier_damage_vision_agility_up", "libraries/modifiers/ability_speed1.lua", LUA_MODIFIER_MOTION_NONE )   
  LinkLuaModifier("deer_modifier", "libraries/modifiers/check_pets.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("sheep_modifier", "libraries/modifiers/check_pets.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("wolf_modifier", "libraries/modifiers/check_pets.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("fish_modifier", "libraries/modifiers/check_pets.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("bear_modifier", "libraries/modifiers/check_pets.lua", LUA_MODIFIER_MOTION_NONE )
  LinkLuaModifier("boar_modifier", "libraries/modifiers/check_pets.lua", LUA_MODIFIER_MOTION_NONE )	
  LinkLuaModifier("spider_modifier", "libraries/modifiers/check_pets.lua", LUA_MODIFIER_MOTION_NONE )	
  --GameRules.Wearables = LoadKeyValues("scripts/kv/wearables.kv") ХЗ РАБОТАЕТ ИЛИ НЕТ
  -- items = LoadKeyValues("scripts/kv/items.txt")
  -- costs = LoadKeyValues("scripts/kv/itemscosts.txt")
  -- ingredients = LoadKeyValues("scripts/kv/itemsingredients.txt")
   
   -- Find all ability layouts to send them to clients later
  local UnitKVs = LoadKeyValues("scripts/npc/npc_units_custom.txt")
  local HeroKVs = LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
  
  GameMode.abilityLayouts = {}
 -- GameRules:GetGameModeEntity():SetExecuteOrderFilter(GameMode.FilterExecuteOrder, self) -- FilterExecuteOrder
  GameRules:SetTreeRegrowTime(600)

  for i=1,2 do
    local t = UnitKVs
    if i == 2 then
      t = HeroKVs
    end
    for unit_name,unit_info in pairs(t) do
      if type(unit_info) == "table" then
        if i == 2 then
          GameMode.abilityLayouts[unit_info["override_hero"]] = unit_info["AbilityLayout"]
        else
          GameMode.abilityLayouts[unit_name] = unit_info["AbilityLayout"]
        end
      end
    end
  end

  BuildingHelper:Init()
end

--[[
-- ОТКЛЮЧЕНО
function GameMode:OnHeroPicked (event)
   	local hero = EntIndexToHScript(event.heroindex)
--	if hero then  
 --             RemoveWearables(hero)
  -- 	end

	print("Hero picked, hero:" .. hero:GetUnitName())
	PrecacheUnitByNameAsync(hero:GetUnitName(), function() end) -- это у меня в гейммоде требуется штука, у себя можешь убрать
end
-- ОТКЛЮЧЕНО
function RemoveWearables(hero)
    print('#RemoveWearables')
    local wearables = {} -- объявление локального массива на удаление
    local cur = hero:FirstMoveChild() -- получаем первый указатель над подобъект объекта hero ()

    while cur ~= nil do --пока наш текущий указатель не равен nil(пустота/пустой указатель)
        cur = cur:NextMovePeer() -- выбираем следующий указатель на подобъект нашего обьекта
        if cur ~= nil and cur:GetClassname() ~= "" and cur:GetClassname() == "dota_item_wearable" then -- проверяем, елси текущий указатель не пуст, название класса не пустое, и если этот класс есть класс "dota_item_wearable", то есть надеваемые косметические предметы
            table.insert(wearables, cur) -- добавляем в таблицу на удаление текущий предмет(сверху проверяли класс текущего объекта)
        end
    end
 
    for i = 1, #wearables do -- собственно цикл для удаления всего занесенного в массив на удаление
        UTIL_Remove(wearables[i]) -- удаляем объект
    end
end
]]

--     craft_axe_tree 		Craft_Tree
--[[function GameMode:Craft_Tree( keys )
	local caster = PlayerResource:GetSelectedHeroEntity(keys.playerID)

	if not caster:HasItemInInventory("item_iron") or not caster:HasItemInInventory("item_wood_damage") then
	Notifications:TopToAll({text="#no_item_axe", duration=3, style={color="red", ["font-size"]="45px"}})
	end
	
	local iron = nil
	local item = nil
	local charges = 0
	local charges_iron = 0
		
	for i = 0, 8 do	
		for g = 0, 8 do
			item = caster:GetItemInSlot(i)
			iron = caster:GetItemInSlot(g)
			if item ~= nil and iron ~= nil then	
			if item:GetAbilityName() == "item_iron" and iron:GetAbilityName() == "item_wood_damage" then				
				if item:IsStackable() == true and iron:IsStackable() == true then
						if item:GetCurrentCharges() > 3 and iron:GetCurrentCharges() > 2 then
						   charges = item:GetCurrentCharges()
						   item:SetCurrentCharges(charges-3)
						   charges_iron = iron:GetCurrentCharges()
						   iron:SetCurrentCharges(charges_iron-2)
						   caster:AddItemByName("item_axe_tree")					
						else				
						if iron:GetCurrentCharges() <= 2 then
						charges = item:GetCurrentCharges()		
						item:SetCurrentCharges(charges-3)
							caster:RemoveItem(iron)	
						end		
						if item:GetCurrentCharges() <= 3 then	
						charges_iron = iron:GetCurrentCharges()							
						iron:SetCurrentCharges(charges_iron-2)							
							caster:RemoveItem(item)														
						end
						caster:AddItemByName("item_axe_tree")								
						end
					end
				end
			end				
		end	
	end		
end]]

function GameMode:OnSettingVote(keys)
	--print("Custom Game Settings Vote.")
	--PrintTable(keys)

	local pID 	= keys.PlayerID
	local mode 	= GameRules.GameMode

	-- VoteTable is initialised in InitGameMode()
	if not mode.VoteTable[keys.category] then mode.VoteTable[keys.category] = {} end
	mode.VoteTable[keys.category][pID] = keys.vote

	PrintTable(mode.VoteTable)
end

function GameMode:Window(keys)
	local hero = PlayerResource:GetSelectedHeroEntity(keys.playerID)
	
	-- if hero:HasModifier("modifier_invoker_retro_betrayal") then
	   
	-- end
	
  for k,v in pairs(keys) do
    print(k,v)
  end
end


function GameMode:OnAlly(keys)
  Notifications:TopToAll({text="#you_were_offered_ally", duration=3, style={color="green", ["font-size"]="45px"}})
  for k,v in pairs(keys) do
    print(k,v)
  end
end

function GameMode:OffAlly(keys)
	local hero = PlayerResource:GetSelectedHeroEntity(keys.playerID)
	if hero:HasModifier("modifier_invoker_retro_betrayal") then
	   hero:RemoveModifierByName("modifier_invoker_retro_betrayal")
	end
  --Notifications:TopToAll({text="#you_refused_union", duration=3, style={color="red", ["font-size"]="45px"}})
  for k,v in pairs(keys) do
    print(k,v)
  end
end


function GameMode:OnTest( keys )
  for k,v in pairs(keys) do
    print(k,v)
  end
end

-- This is an example console command
function GameMode:ExampleConsoleCommand()
  print( '******* Example Console Command ***************' )
  local cmdPlayer = Convars:GetCommandClient()
  if cmdPlayer then
    local playerID = cmdPlayer:GetPlayerID()
    if playerID ~= nil and playerID ~= -1 then
      -- Do something here for the player who called this command
      PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_wisp", 1000, 1000)
    end
  end

  print( '*********************************************' )
end


-- function GameMode:FilterExecuteOrder(filterTable)
  -- for k, v in pairs(filterTable) do 
    -- print(k, v)
  -- end
  -- return true 
-- end