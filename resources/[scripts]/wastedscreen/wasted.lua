locksound = false

Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0)      
            if IsEntityDead(PlayerPedId()) then 
			
					StartScreenEffect("DeathFailOut", 0, 0)
					if not locksound then
					end
					ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
					
					local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

					if HasScaleformMovieLoaded(scaleform) then
						Citizen.Wait(0)

                    while IsEntityDead(PlayerPedId()) do
					  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					  Citizen.Wait(0)
                     end
					 
				  StopScreenEffect("DeathFailOut")
				  locksound = false
			end
		end
    end
end)