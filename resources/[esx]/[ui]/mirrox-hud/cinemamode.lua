ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
		
		Citizen.Wait(0)
	end
end)

cinema = false
playerMoving = false
local wasCinema = false
local amount = 0.85 --Hur mycket kameran ska skaka

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if cinema then 
			if not IsPedInAnyVehicle(PlayerPedId(), false) and GetEntitySpeed(PlayerPedId()) >= 0.5 and GetFollowPedCamViewMode() ~= 4 then
				if playerMoving == false then
					ShakeGameplayCam("ROAD_VIBRATION_SHAKE", amount)
					playerMoving = true
				end
			else
				if playerMoving == true then
					StopGameplayCamShaking(false)
					playerMoving = false
				end
			end
			if not wasCinema then
				hud = false
			end

			local screenW, screenH = GetScreenResolution()
			local height = 1080
			local ratio = screenW / screenH
			local width = height * ratio

			DisplayRadar(false)
			
			ESX.UI.HUD.SetDisplay(0.0)

			DrawRect(0.0, 0.0, width / 100, 0.2, 0, 0, 0, 255)
			DrawRect(0.0, 1.0, width / 100, 0.2, 0, 0, 0, 255)

			wasCinema = true
		else
			if wasCinema then
				if IsPedInAnyVehicle(GetPlayerPed(-1)) then
					DisplayRadar(true)
				end
				
				hud = true --Hunger/thirst

				wasCinema = false
			end
		end
	end
end)

RegisterNetEvent('revenge-cinemamode:show')
AddEventHandler('revenge-cinemamode:show', function()
	cinema = not cinema
end)


RegisterNetEvent('revenge-cinemamode:force')
AddEventHandler('revenge-cinemamode:force', function(forced)
	cinema = forced
end)