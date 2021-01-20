-- BELOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE! --

local useBilling = true -- OPTIONS: (true/false)
local useCameraSound = true -- OPTIONS: (true/false)
local useFlashingScreen = true -- OPTIONS: (true/false)
local useBlips = true -- OPTIONS: (true/false)
local alertPolice = true -- OPTIONS: (true/false)
local alertSpeed = 170 -- OPTIONS: (1-5000 KMH)

-- ABOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE!  --







local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local hasBeenCaught = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- BLIP FOR SPEEDCAMERA (START)

local blips = {
	-- 60KM/H ZONES
	{title="Fartkamera (80KM/H)", colour=1, id=1, x = -245.3225, y = -666.7277, z = 33.3188}, -- Mäklaren (90km/h)
	
	-- 80KM/H ZONES
	{title="Fartkamera (80KM/H)", colour=1, id=1, x = 216.1155, y = -699.7361, z = 35.8636}, -- Sjukhuset

	
	-- 120KM/H ZONES
	{title="Fartkamera (120KM/H)", colour=1, id=1, x = -2157.0187, y = -351.3911, z = 13.1638}, -- Västra påfarten
	{title="Fartkamera (120KM/H)", colour=1, id=1, x = 1993.6103, y = 2563.5349, z = 57.3889}, -- Vid Fängelset
	{title="Fartkamera (120KM/H)", colour=1, id=1, x = 1028.8005, y = 6488.5307, z = 22.4505} -- Motorvägen palito
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		if useBlips == true then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.5)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end
end)

-- BLIP FOR SPEEDCAMERA (END)

local Speedcamera60Zone = {
    {x = -245.3225,y = -666.7277,z = 33.3188}
}

local Speedcamera80Zone = {
	{x = 216.1155,y = -699.7361,z = 35.8636}
}

local Speedcamera120Zone = {
    {x = -2157.0187,y = -351.3911,z = 13.1638},
    {x = 1993.6103,y = 2563.5349,z = 57.3889},
    {x = 1028.8005,y = 6488.5307,z = 22.4505}
}

-- 60 ZONE (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(Speedcamera60Zone) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera60Zone[k].x, Speedcamera60Zone[k].y, Speedcamera60Zone[k].z)

            if dist <= 20.0 then
				local playerPed = GetPlayerPed(-1)
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 80.0 -- THIS IS THE MAX SPEED IN KM/H
				
				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
							if hasBeenCaught == false then
								if GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE4" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE5" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE6" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE7" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE9" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICEB" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "SHERIFF" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "SHERIFF2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "FBI" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE4" then -- BLACKLISTED VEHICLE
								-- VEHICLES ABOVE ARE BLACKLISTED
								else
									-- ALERT POLICE (START)
									if alertPolice == true then
										if SpeedKM > alertSpeed then
											local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
											TriggerServerEvent('esx_phone:send', 'police', ' Nån körde förbi en fartkamera i ÖVER ' .. alertSpeed.. ' KMH', false, {x =x, y =y, z =z})
										end
									end
									-- ALERT POLICE (END)								
								
									-- FLASHING EFFECT (START)
									if useFlashingScreen == true then
										TriggerServerEvent('esx_speedcamera:openGUI')
									end
									
									if useCameraSound == true then
										TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
									end
									
									if useFlashingScreen == true then
										Citizen.Wait(200)
										TriggerServerEvent('esx_speedcamera:closeGUI')
									end
									-- FLASHING EFFECT (END)								
								
									TriggerEvent("pNotify:SendNotification", {text = "Du har kört för fort på en 80km/h väg!", type = "error", timeout = 5000, layout = "centerLeft"})
									
									--if useBilling == true then
										--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'Fartkamera (80KM/H)', 500) -- Sends a bill from the police
									--else
										--TriggerServerEvent('esx_speedcamera:PayBill60Zone')
									--end
										
									hasBeenCaught = true
									Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end
							end
						end
					end
					
					hasBeenCaught = false
				end
            end
        end
    end
end)

-- 60 ZONE (END)

-- 80 ZONE (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(Speedcamera80Zone) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera80Zone[k].x, Speedcamera80Zone[k].y, Speedcamera80Zone[k].z)

            if dist <= 20.0 then
				local playerPed = GetPlayerPed(-1)
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 80.0 -- THIS IS THE MAX SPEED IN KM/H
				
				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then					
							if hasBeenCaught == false then
								if GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE4" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE5" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE6" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE7" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE9" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICEB" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "SHERIFF" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "SHERIFF2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "FBI" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE4" then -- BLACKLISTED VEHICLE
								-- VEHICLES ABOVE ARE BLACKLISTED
								else
									-- ALERT POLICE (START)
									if alertPolice == true then
										if SpeedKM > alertSpeed then
											local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
											TriggerServerEvent('esx_phone:send', 'police', ' Nån körde förbi en fartkamera i ÖVER ' .. alertSpeed.. ' KMH', false, {x =x, y =y, z =z})
										end
									end
									-- ALERT POLICE (END)								
								
									-- FLASHING EFFECT (START)
									if useFlashingScreen == true then
										TriggerServerEvent('esx_speedcamera:openGUI')
									end
									
									if useCameraSound == true then
										TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
									end
									
									if useFlashingScreen == true then
										Citizen.Wait(200)
										TriggerServerEvent('esx_speedcamera:closeGUI')
									end
									-- FLASHING EFFECT (END)								
								
									TriggerEvent("pNotify:SendNotification", {text = "Du körde för fort på en 80km/h väg!", type = "error", timeout = 5000, layout = "centerLeft"})
									
									--if useBilling == true then
										--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'Fartkamera (80KM/H)', 500) -- Sends a bill from the police
									--else
										--TriggerServerEvent('esx_speedcamera:PayBill80Zone')
									--end
										
									hasBeenCaught = true
									Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end
							end
						end
					end
					
					hasBeenCaught = false
				end
            end
        end
    end
end)

-- 80 ZONE (END)

-- 120 ZONE (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(Speedcamera120Zone) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera120Zone[k].x, Speedcamera120Zone[k].y, Speedcamera120Zone[k].z)

            if dist <= 20.0 then
				local playerPed = GetPlayerPed(-1)
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 120.0 -- THIS IS THE MAX SPEED IN KM/H
				
				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then 
							if hasBeenCaught == false then
								if GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE4" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE5" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE6" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE7" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE9" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICEB" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "SHERIFF" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "SHERIFF2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "FBI" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE4" then -- BLACKLISTED VEHICLE
								-- VEHICLES ABOVE ARE BLACKLISTED
								else
									-- ALERT POLICE (START)
									if alertPolice == true then
										if SpeedKM > alertSpeed then
											local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
											TriggerServerEvent('esx_phone:send', 'police', ' Nån körde förbi en fartkamera i ÖVER ' .. alertSpeed.. ' KMH', false, {x =x, y =y, z =z})
										end
									end
									-- ALERT POLICE (END)
								
									-- FLASHING EFFECT (START)
									if useFlashingScreen == true then
										TriggerServerEvent('esx_speedcamera:openGUI')
									end
									
									if useCameraSound == true then
										TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
									end
									
									if useFlashingScreen == true then
										Citizen.Wait(200)
										TriggerServerEvent('esx_speedcamera:closeGUI')
									end
									-- FLASHING EFFECT (END)
								
									TriggerEvent("pNotify:SendNotification", {text = "Du har kört för fort på en 120km/h väg!", type = "error", timeout = 5000, layout = "centerLeft"})
									
									--if useBilling == true then
										--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'Fartkamera (120KM/H)', 900) -- Sends a bill from the police
									--else
										--TriggerServerEvent('esx_speedcamera:PayBill120Zone')
									--end
										
									hasBeenCaught = true
									Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end
							end
						end
					end
					
					hasBeenCaught = false
				end
            end
        end
    end
end)

-- 120 ZONE (END)

RegisterNetEvent('esx_speedcamera:openGUI')
AddEventHandler('esx_speedcamera:openGUI', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openSpeedcamera'})
end)   

RegisterNetEvent('esx_speedcamera:closeGUI')
AddEventHandler('esx_speedcamera:closeGUI', function()
    SendNUIMessage({type = 'closeSpeedcamera'})
end)