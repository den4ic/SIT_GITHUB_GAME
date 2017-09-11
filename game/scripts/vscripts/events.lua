-- This file contains all barebones-registered events and has already set up the passed-in parameters for your use.
-- Do not remove the GameMode:_Function calls in these events as it will mess with the internal barebones systems.

-- Cleanup a player when they leave
function GameMode:OnDisconnect(keys)
  DebugPrint('[BAREBONES] Player Disconnected ' .. tostring(keys.userid))
  DebugPrintTable(keys)

  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid

  
end
-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)
  DebugPrint("[BAREBONES] GameRules State Changed")
  DebugPrintTable(keys)

  -- This internal handling is used to set up main barebones functions
  GameMode:_OnGameRulesStateChange(keys)
  
  local newState = GameRules:State_Get()

	if newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		local mode 	= GameRules.GameMode
		local votes = mode.VoteTable
		
		--[[
		-- Random tables for test purposes
		local testTable = {game_length = {}, combat_system = {}}

		local votes_a = {15, 20, 25, 30}
		local votes_b = {1, 2}

		for i = 0,9 do
			testTable.game_length[i] 	= votes_a[math.random(table.getn(votes_a))]
			testTable.combat_system[i] 	= votes_b[math.random(table.getn(votes_b))]
		end
		votes = testTable		
		]]

		mode.game_length = 0
		mode.combat_system = ""

		for category, pidVoteTable in pairs(votes) do
			
			-- Tally the votes into a new table
			local voteCounts = {}
			for pid, vote in pairs(pidVoteTable) do
				if not voteCounts[vote] then voteCounts[vote] = 0 end
				voteCounts[vote] = voteCounts[vote] + 1
			end

			--print(" ----- " .. category .. " ----- ")
			--PrintTable(voteCounts)

			-- Find the key that has the highest value (key=vote value, value=number of votes)
			local highest_vote = 0
			local highest_key = ""
			for k, v in pairs(voteCounts) do
				if v > highest_vote then
					highest_key = k
					highest_vote = v
				end
			end

			-- Check for a tie by counting how many values have the highest number of votes
			local tieTable = {}
			for k, v in pairs(voteCounts) do
				if v == highest_vote then
					table.insert(tieTable, k)
				end
			end

			-- Resolve a tie by selecting a random value from those with the highest votes
			if table.getn(tieTable) > 1 then
				--print("TIE!")
				highest_key = tieTable[math.random(table.getn(tieTable))]
			end

			
			-- Act on the winning vote
			if category == "game_length" then
				--GameRules:SetPreGameTime( 60 * highest_key ) -- Если офнуть то не будет работать система тайминга
				
				if highest_key == 15 then

				end
				if highest_key == 20 then
					CreateUnitByName("npc_check_attack_medium", Vector(352,-2080,32), true, nil, nil, DOTA_TEAM_BADGUYS); 
				end
				if highest_key == 25 then
					CreateUnitByName("npc_check_attack_hard", Vector(352,-2080,32), true, nil, nil, DOTA_TEAM_BADGUYS);
				end
				
				if highest_key == 30 then			 
				   GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )
				   CreateUnitByName("npc_check_attack_extreme", Vector(352,-2080,32), true, nil, nil, DOTA_TEAM_BADGUYS);
				end
				
				mode.game_length = highest_key		
				
			elseif category == "combat_system" then
				local gme = GameRules:GetGameModeEntity()
				if highest_key == 1 then
					gme:SetDamageFilter( Dynamic_Wrap (GameMode, "DamageFilter_Simple" ), self )
					mode.combat_system = "simple"
				elseif highest_key == 2 then
					--gme:SetDamageFilter( Dynamic_Wrap (GameMode, "DamageFilter_CombatTriangle" ), self )
					mode.combat_system = "triangle"
				end
			end
			print(category .. ": " .. highest_key)
		end
	end
end



-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
  DebugPrint("[BAREBONES] NPC Spawned")
  DebugPrintTable(keys)

  -- This internal handling is used to set up main barebones functions
  GameMode:_OnNPCSpawned(keys)

  local npc = EntIndexToHScript(keys.entindex)
end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function GameMode:OnEntityHurt(keys)
  --DebugPrint("[BAREBONES] Entity Hurt")
  --DebugPrintTable(keys)

  local damagebits = keys.damagebits -- This might always be 0 and therefore useless
  if keys.entindex_attacker ~= nil and keys.entindex_killed ~= nil then
    local entCause = EntIndexToHScript(keys.entindex_attacker)
    local entVictim = EntIndexToHScript(keys.entindex_killed)
  end
end

-- An item was picked up off the ground
function GameMode:OnItemPickedUp(keys)
  DebugPrint( '[BAREBONES] OnItemPickedUp' )
  DebugPrintTable(keys)

  local heroEntity = EntIndexToHScript(keys.HeroEntityIndex)
  local itemEntity = EntIndexToHScript(keys.ItemEntityIndex)
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local itemname = keys.itemname
end

-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys)
  DebugPrint( '[BAREBONES] OnPlayerReconnect' )
  DebugPrintTable(keys) 
end

-- An item was purchased by a player
function GameMode:OnItemPurchased( keys )
  DebugPrint( '[BAREBONES] OnItemPurchased' )
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
  
end

-- An ability was used by a player
function GameMode:OnAbilityUsed(keys)
  DebugPrint('[BAREBONES] AbilityUsed')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityname = keys.abilityname

  if player.cursorStream ~= nil then
    if not (string.len(abilityname) > 14 and string.sub(abilityname,1,14) == "move_to_point_") then
      if not DontCancelBuildingGhostAbils[abilityname] then
        player:CancelGhost()
      else
        print(abilityname .. " did not cancel building ghost.")
      end
    end
  end
end

-- A non-player entity (necro-book, chen creep, etc) used an ability
function GameMode:OnNonPlayerUsedAbility(keys)
  DebugPrint('[BAREBONES] OnNonPlayerUsedAbility')
  DebugPrintTable(keys)

  local abilityname=  keys.abilityname
end

-- A player changed their name
function GameMode:OnPlayerChangedName(keys)
  DebugPrint('[BAREBONES] OnPlayerChangedName')
  DebugPrintTable(keys)

  local newName = keys.newname
  local oldName = keys.oldName
end

-- A player leveled up an ability
function GameMode:OnPlayerLearnedAbility( keys)
  DebugPrint('[BAREBONES] OnPlayerLearnedAbility')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local abilityname = keys.abilityname
end

-- A channelled ability finished by either completing or being interrupted
function GameMode:OnAbilityChannelFinished(keys)
  DebugPrint('[BAREBONES] OnAbilityChannelFinished')
  DebugPrintTable(keys)

  local abilityname = keys.abilityname
  local interrupted = keys.interrupted == 1
end

-- A player leveled up
function GameMode:OnPlayerLevelUp(keys)
  DebugPrint('[BAREBONES] OnPlayerLevelUp')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local level = keys.level
end

-- A player last hit a creep, a tower, or a hero
function GameMode:OnLastHit(keys)
  DebugPrint('[BAREBONES] OnLastHit')
  DebugPrintTable(keys)

  local isFirstBlood = keys.FirstBlood == 1
  local isHeroKill = keys.HeroKill == 1
  local isTowerKill = keys.TowerKill == 1
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local killedEnt = EntIndexToHScript(keys.EntKilled)
end

-- A tree was cut down by tango, quelling blade, etc
function GameMode:OnTreeCut(keys)
  DebugPrint('[BAREBONES] OnTreeCut')
  DebugPrintTable(keys)

  local treeX = keys.tree_x
  local treeY = keys.tree_y
end

-- A rune was activated by a player
function GameMode:OnRuneActivated (keys)
  DebugPrint('[BAREBONES] OnRuneActivated')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local rune = keys.rune

  --[[ Rune Can be one of the following types
  DOTA_RUNE_DOUBLEDAMAGE
  DOTA_RUNE_HASTE
  DOTA_RUNE_HAUNTED
  DOTA_RUNE_ILLUSION
  DOTA_RUNE_INVISIBILITY
  DOTA_RUNE_BOUNTY
  DOTA_RUNE_MYSTERY
  DOTA_RUNE_RAPIER
  DOTA_RUNE_REGENERATION
  DOTA_RUNE_SPOOKY
  DOTA_RUNE_TURBO
  ]]
end

-- A player took damage from a tower
function GameMode:OnPlayerTakeTowerDamage(keys)
  DebugPrint('[BAREBONES] OnPlayerTakeTowerDamage')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local damage = keys.damage
end

-- A player picked a hero
function GameMode:OnPlayerPickHero(keys)
  DebugPrint('[BAREBONES] OnPlayerPickHero')
  DebugPrintTable(keys)

  local heroClass = keys.hero
  local heroEntity = EntIndexToHScript(keys.heroindex)
  local player = EntIndexToHScript(keys.player)
end

-- A player killed another player in a multi-team context
function GameMode:OnTeamKillCredit(keys)
  DebugPrint('[BAREBONES] OnTeamKillCredit')
  DebugPrintTable(keys)

  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
  local numKills = keys.herokills
  local killerTeamNumber = keys.teamnumber
end

-- An entity died
function GameMode:OnEntityKilled( keys )
  DebugPrint( '[BAREBONES] OnEntityKilled Called' )

  GameMode:_OnEntityKilled( keys )
  
  -- The Unit that was Killed
  local killedUnit = EntIndexToHScript( keys.entindex_killed )
  -- The Killing entity
  local killerEntity = nil
  -- Drop item 
  if killedUnit:IsCreature() then
    RollDrops(killedUnit)
	RollDrops_fat(killedUnit)
  end
  
  if keys.entindex_attacker ~= nil then
    killerEntity = EntIndexToHScript( keys.entindex_attacker )
  end

  local damagebits = keys.damagebits -- This might always be 0 and therefore useless

  if killedUnit.foodProvided ~= nil then
    killedUnit:GetPlayerOwner().maxFood = killedUnit:GetPlayerOwner().maxFood - killedUnit.foodProvided
  end

  if killedUnit.foodSpent ~= nil then
    killedUnit:GetPlayerOwner().food = killedUnit:GetPlayerOwner().food - killedUnit.foodSpent
  end

  -- Respawn creep
  if string.match(killedUnit:GetUnitName (), "npc_petri_creep_") then
    if GameRules:IsDaytime() == false then

      killerEntity:CastAbilityNoTarget(killerEntity:FindAbilityByName("petri_petrosyan_return"), killerEntity:GetPlayerOwnerID())
      Notifications:Bottom(killerEntity:GetPlayerOwnerID(), {text="#no_farm_tonight", duration=5, style={color="red", ["font-size"]="45px"}})
      
      Timers:CreateTimer(0.04,
      function()
        MoveCamera(killerEntity:GetPlayerOwnerID(), killerEntity)
      end)
      
    end
    Timers:CreateTimer(0.73,
    function()
      CreateUnitByName(killedUnit:GetUnitName(), killedUnit:GetAbsOrigin(),true, nil,nil,DOTA_TEAM_NEUTRALS)
    end)
  end

  if killedUnit:HasAbility("petri_building") and killedUnit.RemoveBuilding ~= nil then
    killedUnit:RemoveBuilding(true)
  end

  -- Petrosyn is killed
  if killedUnit:GetUnitName() == "npc_dota_hero_brewmaster" then
    -- if killerEntity:GetPlayerOwnerID() ~= nil then
    --   Notifications:TopToAll({text="#petrosyan_is_killed" .. PlayerResource:GetPlayerName(killerEntity:GetPlayerOwnerID()), duration=4, style={color="yellow"}, continue=false})
    -- end
    killedUnit:SetTimeUntilRespawn(30.0)
    Timers:CreateTimer(30.0,
    function()
      killedUnit:RespawnHero(false, false, false)
    end)
  end

  -- KVN fan is killed
  if killedUnit:GetUnitName() == "npc_dota_hero_rattletrap" then
    --Notifications:TopToAll({text=PlayerResource:GetPlayerName(killedUnit:GetPlayerOwnerID()) .." ".."#kvn_fan_is_dead", duration=4, style={color="red"}, continue=false})
    GameRules.deadKvnFansNumber = GameRules.deadKvnFansNumber or 0
    GameRules.deadKvnFansNumber = GameRules.deadKvnFansNumber + 1

    if GameRules.deadKvnFansNumber == PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS) then
      Notifications:TopToAll({text="#petrosyan_win", duration=10, style={color="RED"}, continue=false})

      for i=1,10 do
        PlayerResource:SetCameraTarget(i-1, killerEntity)
      end

      Timers:CreateTimer(2.0,
        function()
          GameRules:SetGameWinner(DOTA_TEAM_BADGUYS) 
        end)
    end
  end
end

-- Drop item 
function RollDrops(unit)
    local DropInfo = GameRules.DropTable[unit:GetUnitName()]
    if DropInfo then
        for k,ItemTable in pairs(DropInfo) do
            local chance = ItemTable.Chance or 100
            local max_drops = ItemTable.Multiple or 1
            local item_name = ItemTable.Item
            for i=1,max_drops do
                if RollPercentage(chance) then
                    print("Creating "..item_name)
                    local item = CreateItem(item_name, nil, nil)
                    item:SetPurchaseTime(0)
                    local pos = unit:GetAbsOrigin()
                    local drop = CreateItemOnPositionSync( pos, item )
                    local pos_launch = pos+RandomVector(RandomFloat(150,200))
                    item:LaunchLoot(false, 200, 0.75, pos_launch)
                end
            end
        end
    end
end

-- knife for scalp fat -createhero north_sheep enemy
function RollDrops_fat(event)
	for playerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do -- Макс. кол-во игроков, не являющихся зрителями, поддерживается.
    if PlayerResource:IsValidPlayerID(playerID) then
    local hero = PlayerResource:GetSelectedHeroEntity(playerID)

    local DropInfo_fat = GameRules.DropTable_fat[event:GetUnitName()]
    if DropInfo_fat then
        for k,ItemTable in pairs(DropInfo_fat) do
            local chance = ItemTable.Chance or 100
            local max_drops = ItemTable.Multiple or 1
            local item_name = ItemTable.Item
            for i=1,max_drops do		
			if hero:HasItemInInventory("item_scalp") then
                if RollPercentage(chance) then
                    print("Creating "..item_name)
                    local item = CreateItem(item_name, nil, nil)
                    item:SetPurchaseTime(0)
                    local pos = event:GetAbsOrigin()
                    local drop = CreateItemOnPositionSync( pos, item )
                    local pos_launch = pos+RandomVector(RandomFloat(150,200))
                    item:LaunchLoot(false, 200, 0.75, pos_launch)
                end
			  end	
            end
        end
    end
end
end
end

-- This function is called 1 to 2 times as the player connects initially but before they 
-- have completely connected
function GameMode:PlayerConnect(keys)
  DebugPrint('[BAREBONES] PlayerConnect')
  DebugPrintTable(keys)
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:OnConnectFull(keys)
  FillingNetTables()
  DebugPrint('[BAREBONES] OnConnectFull')
  DebugPrintTable(keys)
  GameMode:_OnConnectFull(keys)
  local entIndex = keys.index+1
  -- The Player entity of the joining user
  local ply = EntIndexToHScript(entIndex)

  -- The Player ID of the joining player
  local playerID = ply:GetPlayerID()
end

function FillingNetTables()
    for shop, item in pairs(items) do
        CustomNetTables:SetTableValue("items",shop,item)
    end
    for item, cost in pairs(costs) do
        CustomNetTables:SetTableValue("itemscost",item,cost)
    end
    for item, ingredient in pairs(ingredients) do
        CustomNetTables:SetTableValue("itemsingredients",item,ingredient)
    end
end

-- This function is called whenever illusions are created and tells you which was/is the original entity
function GameMode:OnIllusionsCreated(keys)
  DebugPrint('[BAREBONES] OnIllusionsCreated')
  DebugPrintTable(keys)

  local originalEntity = EntIndexToHScript(keys.original_entindex)
end

-- This function is called whenever an item is combined to create a new item
function GameMode:OnItemCombined(keys)
  DebugPrint('[BAREBONES] OnItemCombined')
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end
  local player = PlayerResource:GetPlayer(plyID)

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
end

-- This function is called whenever an ability begins its PhaseStart phase (but before it is actually cast)
function GameMode:OnAbilityCastBegins(keys)
  DebugPrint('[BAREBONES] OnAbilityCastBegins')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityName = keys.abilityname
end

-- This function is called whenever a tower is killed
function GameMode:OnTowerKill(keys)
  DebugPrint('[BAREBONES] OnTowerKill')
  DebugPrintTable(keys)

  local gold = keys.gold
  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local team = keys.teamnumber
end

-- This function is called whenever a player changes there custom team selection during Game Setup 
function GameMode:OnPlayerSelectedCustomTeam(keys)
  DebugPrint('[BAREBONES] OnPlayerSelectedCustomTeam')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.player_id)
  local success = (keys.success == 1)
  local team = keys.team_id
end

-- This function is called whenever an NPC reaches its goal position/target
function GameMode:OnNPCGoalReached(keys)
  DebugPrint('[BAREBONES] OnNPCGoalReached')
  DebugPrintTable(keys)

  local goalEntity = EntIndexToHScript(keys.goal_entindex)
  local nextGoalEntity = EntIndexToHScript(keys.next_goal_entindex)
  local npc = EntIndexToHScript(keys.npc_entindex)
end