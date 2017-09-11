function Spawn(keys)
	think()
end
function think()
  Timers:CreateTimer(function()
		  	if thisEntity:IsNull() then
		  		return nil
		  	end
  			if RollPercentage(30) then
  				local vector = thisEntity:GetAbsOrigin() + RandomVector(RandomInt(200,800))
  				if vector.x < -649.045 and vector.x > -12239.2 and vector.y > -6262.96 and vector.y < -10818.4 then
  					thisEntity:MoveToPosition(vector)
  				else
  					thisEntity:MoveToPosition(Vector(-2236.24,-12671.7,32)) -- (-1920,-12160,32) (-2464,-11808,32)
  				end
  			end
		return 1
    end)
end
