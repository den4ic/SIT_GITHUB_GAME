if GameMode == nil then
	GameMode = class({})
end

 
--function GameMode:InitGameMode()  
--  ListenToGameEvent("dota_player_killed", Dynamic_Wrap(GameMode, "OnHeroKilled"), self)
--end

function GameMode:OnHeroKilled(data)
print("----------------------------------------Hero Killed----------------------------------------")
	--local killedEntity = PlayerResource:GetSelectedHeroEntity(data.PlayerID) 
	local killedEntity = EntIndexToHScript(data.entindex_killed) 
	if killedEntity:IsRealHero() then
   if killedEntity:GetNumItemsInInventory() ~=0 then
	   for i=0,5 do
			local item = killedEntity:GetItemInSlot(i);
			if item ~= nil then
				local position = killedEntity:GetAbsOrigin()
				local name = item:GetAbilityName()
				killedEntity:RemoveItem(item)				
				GameMode:CreateDrop(name, position)
			end
		end
   end
end
end

function GameMode:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end  