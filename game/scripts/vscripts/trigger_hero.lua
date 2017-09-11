function OnStartTouch(trigger)
	print(trigger.activator)
	print(trigger.caller)
  Notifications:TopToAll({text="#victim_win", duration=100, style={color="green"}, continue=false})
  
  Timers:CreateTimer(5.0,
    function()
      GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS) 
    end)
end
 
--function OnEndTouch(trigger)
--	print(trigger.activator)
--	print(trigger.caller)
--end