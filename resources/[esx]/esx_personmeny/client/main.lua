local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 150, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local KeyboardInput = function(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Wait(0)
		DisplayHelpTextThisFrame('mod_menu_help_text', false)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Wait(500)
		return result
	else
		Wait(500)
		return false 
	end
end

ESX = nil
spelaVisiteringAnim = 0
local IsCuffed = false

Citizen.CreateThread(function()
	while not ESX do

		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end



	
	 --local player = PlayerPedId()--härifrån
	 --local inventory = ESX.GetPlayerData().inventory
	 --local AmmoAmount = nil
	
	 --for i=1, #inventory, 1 do
	 	--if inventory[i].name == 'laptop' then
	 		--AmmoAmount = inventory[i].count
	 	--end
	 --end
	 --print(AmmoAmount)
	 --SetPedAmmo(player, GetHashKey('WEAPON_PISTOL'), AmmoAmount)

	 --while true do
	 	--local sleep = 500
	 	--if IsPedArmed(PlayerPedId(), 4) then
	 		--sleep = 5
	 		--local wep = GetSelectedPedWeapon(player)
	 		--print(GetWeapontypeSlot(wep))
	 		 --if wep == GetHashKey("WEAPON_PISTOL") then
	 		 	--if IsPedShooting(PlayerPedId()) then
	 		 		--TriggerServerEvent("menu:removeItem", '9mm', 1)
	 		 	--end 
	 		-- end

	 		--if IsPedShooting(PlayerPedId()) then
	 			--TriggerServerEvent("menu:removeItem", 'laptop', 1)
	 		--end 
	 	--end
	 	--Wait(sleep)
	 --end--hit

	while true do
		Citizen.Wait(0)

		if ESX ~= nil then

			if IsControlJustPressed(0, Keys["F3"]) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'Personmeny') then
				OpenPersonMeny()
			end

			--if IsControlJustPressed(0, Keys["M"]) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'Fordonsmeny') then
				--OpenFordonsMeny()
			--end

		end

		local ped = GetPlayerPed(-1)

		if IsCuffed then
			if not IsEntityPlayingAnim(ped, 'mp_arresting', 'idle', true) then
				if not HasAnimDictLoaded('mp_arresting') then
					RequestAnimDict('mp_arresting')

			      	while not HasAnimDictLoaded('mp_arresting') do
			        	Citizen.Wait(50)
			      	end
			    end
			      	
			    TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
			end
			
			DisableControlAction(0, 23, true) -- Enter Car
		    DisableControlAction(0, 44, true) -- Cover
		    DisableControlAction(0, 105, true) -- Hands Up
		    DisableControlAction(0, 140, true) -- Melee attack
		    DisableControlAction(0, 167, true) -- F6
		    DisableControlAction(0, 170, true) -- F3
		    DisableControlAction(0, 288, true) -- F1
		    DisableControlAction(0, 289, true) -- F2
		    DisableControlAction(0, 24, true) -- Attack
		    DisableControlAction(0, 66, true) -- Shoot
		    DisableControlAction(0, 37, true) -- TAB
		    DisableControlAction(0, 73, true) -- X
		    DisableControlAction(0, 25, true) -- Aim
		    DisableControlAction(0, 303, true) -- U
		end

	end

end)

RegisterNetEvent("esx:removeInventoryItem")--här
 AddEventHandler('esx:removeInventoryItem', function(item, count)
 	local ammo = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey("WEAPON_PISTOL"))
 	local player = PlayerPedId()
 	if item["name"] == "laptop" then
 		SetPedAmmo(player, GetHashKey('WEAPON_PISTOL'), ammo - count)
 	end
 end)

 RegisterNetEvent("esx:addInventoryItem")
 AddEventHandler('esx:addInventoryItem', function(item, count)
 	local ammo = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey("WEAPON_PISTOL"))
 	local player = PlayerPedId()
 	if item["name"] == "laptop" then
 		SetPedAmmo(player, GetHashKey('WEAPON_PISTOL'), ammo + count)
 	end
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)


local Licenses = {}
local NobodyClose = 'Det är ingen i närheten...'
local NoVehicle = 'Det är inget fordon i närheten...'

local windowavg					= false
local windowavd					= false
local windowarg					= false
local windoward					= false
local window 					= false
local engineOn 					= true
local speedkm 					= 0

OpenPersonMeny = function()
	local elements = {
		{ ["label"] = 'Yrke: ' .. ESX.PlayerData["job"].label .. ' - ' .. ESX.PlayerData["job"].grade_label, ["usage"] = 'yrke' },
		{ ["label"] = 'Kolla ditt identitetskort', ["usage"] = 'kolladittid' },
		{ ["label"] = 'Kolla dina körkort', ["usage"] = 'korkort' },
		{ ["label"] = 'Individåtgärder', ["usage"] = 'individ' },
		{ ["label"] = 'Animationer', ["usage"] = 'anim' },
		{ ["label"] = 'Accessoarer', ["usage"] = 'accessoarer' },
		{ ["label"] = 'Kläder', ["usage"] = 'klader' },
		{ ["label"] = 'Räkningar', ["usage"] = 'rakningar' },
		{ ["label"] = 'Dina färdigheter', ["usage"] = 'fardigheter' },
		{ ["label"] = 'Anteckningar', value = 'notes'},
		{ ["label"] = 'Stäng av/på telefon', value = 'phoneoff'},
		--{ ["label"] = 'VD-Meny', value = 'test'},


	}



	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Personmeny', 
	{
		["title"] = 'Personmeny',
		["align"] = 'right',
		["elements"] = elements

	}, function(data, menu)
		local usage = data.current.usage

		if usage == 'kolladittid' then
			TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			
		elseif usage == 'fardigheter' then
			exports["gamz-skillsystem"]:SkillMenu()
			
		
		elseif data.current.value == 'notes' then
				TriggerEvent('barbies_notes:noteMenu')

		elseif data.current.value == 'phoneoff' then
				TriggerServerEvent("esx_phone3:togglePhone")		
	
		elseif usage == 'individ' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Individåtgärder',
			{
				["title"] = 'Individåtgärder',
				["align"] = 'right',
				["elements"] = {
					{ ["label"] = 'Visa ditt identitetskort', ["usage"] = 'visadittid' },
					{ ["label"] = 'Visitera person', ["usage"] = 'visitera' },
					{ ["label"] = 'Lyft / släpp person', ["usage"] = 'lyft' },
					{ ["label"] = 'Applicera handfängsel', ["usage"] = 'applicerabuntband' },
					{ ["label"] = 'Lirka upp handfängsel', ["usage"] = 'skäravbuntband' },
					{ ["label"] = 'Ge kontanter', ["usage"] = 'cash' }
				},
			}, function(data2, menu2)
				local usage = data2.current.usage

				if usage == 'visadittid' then
					local player, distance = ESX.Game.GetClosestPlayer()

					if distance ~= -1 and distance <= 1.0 then
						TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
					else
						ESX.ShowNotification(NobodyClose)
					end

				elseif usage == "cash" then
					local player, distance = ESX.Game.GetClosestPlayer()

					if distance ~= -1 and distance <= 1.0 then
						local amount = KeyboardInput('Hur mycket pengar vill du ge?', '', 30)
						TriggerServerEvent("menu:giveMoney", GetPlayerServerId(player), amount)
					else
						ESX.ShowNotification(NobodyClose)
					end


				elseif usage == 'lyft' then
					local player, distance = ESX.Game.GetClosestPlayer()

					if distance ~= -1 and distance <= 1.0 and not IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(player)) then
					  TriggerServerEvent('menu:Lyft', GetPlayerServerId(player))
					else
						ESX.ShowNotification(NobodyClose)
					end

				elseif usage == 'applicerabuntband' then
					local player, distance = ESX.Game.GetClosestPlayer()
				
					if distance ~= -1 and distance <= 1.0 then
						local inventory = ESX.GetPlayerData().inventory
						local HandcuffAmount = nil
						
						for i=1, #inventory, 1 do
							if inventory[i].name == 'handcuffs' then
								HandcuffAmount = inventory[i].count
							end
						end

						if HandcuffAmount > 0 then
							TriggerEvent('esx_handcuffs:cuffcheck', source)
							TriggerServerEvent('menu:removeItem', 'handcuffs', 1)
						else
							ESX.ShowNotification('Du behöver ett handfängsel...')
						end
					else
						ESX.ShowNotification(NobodyClose)
					end

				elseif usage == 'skäravbuntband' then
					local player, distance = ESX.Game.GetClosestPlayer()
				
					if distance ~= -1 and distance <= 1.0 then
						local inventory = ESX.GetPlayerData().inventory
						local KeyAmount = nil
						
						for i=1, #inventory, 1 do
							if inventory[i].name == 'sidavbitare' then
								KeyAmount = inventory[i].count
							end
						end

						if KeyAmount > 0 then
							TriggerEvent('esx_handcuffs:unlockingcuffs')
						else
							ESX.ShowNotification('Du behöver en sidavbitare...')
						end
					else
						ESX.ShowNotification(NobodyClose)
					end

				elseif usage == 'visitera' then
					local player, distance = ESX.Game.GetClosestPlayer()

					if distance ~= -1 and distance <= 1.0 then
						if IsEntityPlayingAnim(GetPlayerPed(player), "random@mugging3", 'handsup_standing_base', 3) or IsEntityPlayingAnim(GetPlayerPed(player), "mp_arresting", "idle", 3) or IsPedFatallyInjured(GetPlayerPed(player)) then 
							VisiteraPerson(player)
						else
							ESX.ShowNotification('Personen håller inte upp händerna.')  
						end
					else
						ESX.ShowNotification(NobodyClose)        
					end
				end
			end, function(data2, menu2)
				menu2.close()
			end
			)
		elseif usage == 'korkort' then
			local ownedLicenses = {}

			for i=1, #Licenses, 1 do
				ownedLicenses[Licenses[i].type] = true
			end
		
			local elements = {}
		
			if ownedLicenses['drive'] then
				table.insert(elements, {label = 'B-körkort (personbil): <span style="color:green;">JA</span>', value = 'drive_test', type = 'drive'})
			else
				table.insert(elements, {label = 'B-körkort (personbil): <span style="color:red;">NEJ</span>', value = 'drive_test', type = 'drive'})
			end
		
			if ownedLicenses['drive_bike'] then
				table.insert(elements, {label = 'A-körkort (motorcykel): <span style="color:green;">JA</span>', value = 'drive_test', type = 'drive_bike'})
			else
				table.insert(elements, {label = 'A-körkort (motorcykel): <span style="color:red;">NEJ</span>', value = 'drive_test', type = 'drive_bike'})
			end
		
			if ownedLicenses['drive_truck'] then
				table.insert(elements, {label = 'C-körkort (lastbil): <span style="color:green;">JA</span>',value = 'drive_test',type = 'drive_truck'})
			else
				table.insert(elements, {label = 'C-körkort (lastbil): <span style="color:red;">NEJ</span>',value = 'drive_test',type = 'drive_truck'})
			end
		
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Dinakörkort',
			{
				["title"] = 'Dina körkort',
				["align"] = 'right',
				["elements"] = elements
			}, function(data3, menu3)

			end, function(data3, menu3)
				menu3.close()
				OpenPersonMeny()
			end
			)

    
		elseif usage == 'anim' then
			TriggerEvent('loffe_animations:openMenu')
		elseif usage == 'rakningar' then
			TriggerEvent('esx_billing')
		elseif usage == 'klader' then
			OpenClotheMenu()
		elseif usage == 'accessoarer' then
			TriggerEvent('esx_accessories')
		end

	end, function(data, menu)
		menu.close()
	end
    )
end

OpenFordonsMeny = function()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Fordonsmeny',
	{
		["title"] = 'Fordonsmeny',
		["align"] = 'right',
		["elements"] = {
			{ ["label"] = 'Lås / öppna', ["usage"] = 'locking' },
			{ ["label"] = 'Motor', ["usage"] = 'engine' },
			{ ["label"] = 'Dörrar', ["usage"] = 'dorrar' },
			{ ["label"] = 'Fönster', ["usage"] = 'fonster' },
			{ ["label"] = 'Farthållare', ["usage"] = 'speed' },
			{ ["label"] = 'Bälte', ["usage"] = 'belt' },
			{ ["label"] = 'Välj säte', ["usage"] = 'seat' }
		},
	}, function(data, menu)
		local usage = data.current.usage

		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(ped)
		local vehicle = nil

		if IsPedInAnyVehicle(ped, false) then
			vehicle = GetVehiclePedIsIn(ped, false)
		 elseif IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if vehicle ~= nil then
			if usage == 'lockcar' then
				Lockcar()

			elseif usage == 'seat' then
				ESX.UI.Menu.Open("default", GetCurrentResourceName(), "chooseseat", {
					["title"] = "Välj säte",
					["align"] = "right",
					["elements"] = {
						{ ["label"] = 'Förarsätet', ["seat"] = -1 },
						{ ["label"] = 'Passagerarsätet', ["seat"] = 0 },
						{ ["label"] = 'Vänstra bakresätet', ["seat"] = 1 },
						{ ["label"] = 'Höger bakresätet', ["seat"] = 2 },
						{ ["label"] = 'Utanför vänster', ["seat"] = 3 },
						{ ["label"] = 'Utanför höger', ["seat"] = 4 },
					}
				}, function(data7, menu7)

					TaskEnterVehicle(PlayerPedId(), vehicle, 10000, data7["current"]["seat"], 1.0, 1, 0)
				
				end, function(data7, menu7)
					menu7.close()
				end
				)

			elseif usage == 'dorrar' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dorrar',
				{
					["title"] = 'Dörrar',
					["align"] = 'right',
					["elements"] = {
						{ ["label"] = 'Motorhuv', ["usage"] = 'motorhuv' },
						{ ["label"] = 'Baklucka', ["usage"] = 'baklucka' },
						{ ["label"] = 'Vänstra dörrar', ["usage"] = 'leftdoors' },
						{ ["label"] = 'Högra dörrar', ["usage"] = 'rightdoors' }
					}
				}, function(data2, menu2)
					local usage = data2.current.usage

					if usage == 'motorhuv' then
						if GetVehicleDoorAngleRatio(vehicle, 4) > 0.0 then 
							SetVehicleDoorShut(vehicle, 4, false)
						else
							SetVehicleDoorOpen(vehicle, 4, false)
						end

					elseif usage == 'baklucka' then
						if GetVehicleDoorAngleRatio(vehicle, 5) > 0.0 then 
							SetVehicleDoorShut(vehicle, 5, false)
						else
							SetVehicleDoorOpen(vehicle, 5, false)
						end

					elseif usage == 'leftdoors' then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'leftdoors',
						{
							["title"] = 'Vänstra dörrar',
							["align"] = 'right',
							["elements"] = {
								{ ["label"] = 'Bakre dörr', ["usage"] = 'bakreleftdoor' },
								{ ["label"] = 'Främre dörr', ["usage"] = 'framreleftdoor' },
							}
						}, function(data3, menu3)
							local usage = data3.current.usage

							if usage == 'bakreleftdoor' then
								if GetVehicleDoorAngleRatio(vehicle, 2) > 0.0 then 
									SetVehicleDoorShut(vehicle, 2, false)
								else
									SetVehicleDoorOpen(vehicle, 2, false)
								end

							elseif usage == 'framreleftdoor' then
								if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 then 
									SetVehicleDoorShut(vehicle, 0, false)
								else
									SetVehicleDoorOpen(vehicle, 0, false)
								end
							end
						end, function(data3, menu3)
							menu3.close()
						end
						)

					elseif usage == 'rightdoors' then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rightdoors',
						{
							["title"] = 'Högra dörrar',
							["align"] = 'right',
							["elements"] = {
								{ ["label"] = 'Bakre dörr', ["usage"] = 'bakrerightdoor' },
								{ ["label"] = 'Främre dörr', ["usage"] = 'framrerightdoor' },
							}
						}, function(data4, menu4)
							local usage = data4.current.usage

							if usage == 'bakrerightdoor' then
								if GetVehicleDoorAngleRatio(vehicle, 3) > 0.0 then 
									SetVehicleDoorShut(vehicle, 3, false)
								else
									SetVehicleDoorOpen(vehicle, 3, false)
								end

							elseif usage == 'framrerightdoor' then
								if GetVehicleDoorAngleRatio(vehicle, 1) > 0.0 then 
									SetVehicleDoorShut(vehicle, 1, false)
								else
									SetVehicleDoorOpen(vehicle, 1, false)
								end
							end
						end, function(data4, menu4)
							menu4.close()
						end
						)

					end
				end, function(data2, menu2)
					menu2.close()
				end
				)
			end
		else
			ESX.ShowNotification(NoVehicle)
		end

		if IsPedInAnyVehicle(ped) then
			if usage == 'engine' then
				local playerPed = GetPlayerPed(-1)
				local playerVeh = GetVehiclePedIsIn(playerPed, false)

				if engineOn == true then
					SetVehicleUndriveable(playerVeh, true)
					SetVehicleEngineOn(playerVeh, false, false, false)
					engineOn = false
				else
					SetVehicleUndriveable(playerVeh, false)
					SetVehicleEngineOn(playerVeh, true, false, false)       
					engineOn = true
				end

			elseif usage == 'fonster' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fonster', 
				{
					["title"] = 'Fönster',
					["align"] = 'right',
					["elements"] = {
						{ ["label"] = 'Veva ner', ["usage"] = 'ner' },
						{ ["label"] = 'Veva upp', ["usage"] = 'upp' },
					}

				}, function(data5, menu5)
					local usage = data5.current.usage

					if usage == 'ner' then
						RollDownWindow(vehicle, 0)
						RollDownWindow(vehcile, 1)
					elseif usage == 'upp' then
						RollUpWindow(vehicle, 0)
						RollUpWindow(vehcile, 1)
					end
				end, function(data5, menu5)
					menu5.close()
				end
				)
				
			elseif usage == 'speed' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'speed', 
				{
					["title"] = 'Farthållare',
					["align"] = 'right',
					["elements"] = {
						{ ["label"] = 'Nollställ', ["usage"] = 'disable' },
						{ ["label"] = '30 km/h', ["usage"] = '30' },
						{ ["label"] = '50 km/h', ["usage"] = '50' },
						{ ["label"] = '80 km/h', ["usage"] = '80' },
						{ ["label"] = '100 km/h', ["usage"] = '100' },
						{ ["label"] = '120 km/h', ["usage"] = '120' },
						{ ["label"] = '150 km/h', ["usage"] = '150' },
						{ ["label"] = '170 km/h', ["usage"] = '170' },
					}

				}, function(data6, menu6)
					local usage = data6.current.usage

					if usage == 'disable' then
						local playerPed = GetPlayerPed(-1)
						local playerVeh = GetVehiclePedIsIn(playerPed, false)
						local modelVeh  = GetEntityModel(playerVeh)
						local maxSpeed  = GetVehicleMaxSpeed(modelVeh)
						SetEntityMaxSpeed(playerVeh, 100000000000)
						ESX.ShowNotification('Du nollställde farthållaren.')
					end

					local speedkm = data6.current.usage
					local speed   = speedkm/3.6
					local playerPed = GetPlayerPed(-1)
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if usage == "50" then
						SetEntityMaxSpeed(playerVeh, speed)
						ESX.ShowNotification('Du satte farthållaren på ' .. usage .. ' km/h')
					else
						SetEntityMaxSpeed(playerVeh, speed)
						ESX.ShowNotification('Du satte farthållaren på ' .. usage .. ' km/h')
					end

				end, function(data6, menu6)
					menu6.close()
				end
				)

			elseif usage == 'changeseat' then
				TriggerEvent("SeatShuffle")
			elseif usage == 'belt' then
				TriggerEvent("balte")
			end
		end
			
		end, function(data, menu)
			menu.close()
		end
	)
end


local disableShuffle = false
function disableSeatShuffle(flag)
  disableShuffle = flag
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
      if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
        if GetIsTaskActive(GetPlayerPed(-1), 165) then
          SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
        end
      end
    end
  end
end)

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end


RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    disableSeatShuffle(false)
    Citizen.Wait(5000)
    disableSeatShuffle(true)
  else
    CancelEvent()
  end
end)


RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- ** ANDRA FUNKTIONER ** ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Lyfter		 = false
local bliLyft		 = false
local LyftLib		 = "anim@heists@box_carry@"
local LyftAnim 		 = 'idle'
local LyftTargetLib	 = 'amb@world_human_bum_slumped@male@laying_on_right_side@base'
local LyftTargetAnim = 'base'

RegisterNetEvent('menu:bliLyft')
AddEventHandler('menu:bliLyft', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(LyftTargetLib)

	while not HasAnimDictLoaded(LyftTargetLib) do
		Citizen.Wait(10)
	end

	if bliLyft then
		bliLyft = false
		DetachEntity(GetPlayerPed(-1), true, false)
		Citizen.Wait(80)
		ClearPedTasks(GetPlayerPed(-1))
	else
		bliLyft = true	
    	Citizen.Wait(25)
		AttachEntityToEntity(GetPlayerPed(-1), targetPed, GetPedBoneIndex(playerPed, 57005), -0.32, -0.6, -0.35, 240.0, 35.0, 149.0, true, true, false, true, 1, true)
	    Citizen.Wait(50)
		TaskPlayAnim(playerPed, LyftTargetLib, LyftTargetAnim, 8.0, 8.0, -1, 9, 0, false, false, false)
	end
end)

RegisterNetEvent('menu:lyftPerson')
AddEventHandler('menu:lyftPerson', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(LyftLib)

	while not HasAnimDictLoaded(LyftLib) do
		Citizen.Wait(10)
	end
	
	if Lyfter then
		Lyfter = false
		Citizen.Wait(50)
		ClearPedTasks(GetPlayerPed(-1))
	else
		TaskPlayAnim(playerPed, LyftLib, LyftAnim, 8.0, 8.0, -1, 50, 0, false, false, false )
		Lyfter = true
	end
end)

Lockcar = function()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local coords2 = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local vehicle = nil
  
  
	if IsPedInAnyVehicle(playerPed,  false) then
	  vehicle = GetVehiclePedIsIn(playerPed, false)
	else
	  vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 71 )
	end
  
	--print(vehicle)
  
	if vehicle == 0 then
		local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
	  local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
	  local targetVehicle = getVehicleInDirection(coordA, coordB)
		  if targetVehicle ~= nil then
			vehicle = targetVehicle
		  end
	end
	ESX.TriggerServerCallback('menu:requestPlayerCars', function(isOwnedVehicle)
	local playerPed = GetPlayerPed(-1)
  
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	print(vehicleProps.plate)
	print(ESX.PlayerData["job"]["name"])
	  if isOwnedVehicle or 
	  (ESX.PlayerData["job"]["name"] == 'police'and vehicleProps.plate == 'POLIS' or 
	  ESX.PlayerData["job"]["name"] == 'ambulance' and vehicleProps.plate == 'AMBULANS' or 
	  ESX.PlayerData["job"]["name"] == 'bennys' and vehicleProps.plate == 'BENNYS')
	then
	  local locked = GetVehicleDoorLockStatus(vehicle)
	  local heading = GetEntityHeading(playerPed)
	  if locked == 1 then -- if unlocked
		  SetVehicleDoorsLocked(vehicle, 2)
		  PlayVehicleDoorCloseSound(vehicle, 1)
		  if not IsPedInAnyVehicle(playerPed, true) then
			  
			  ESX.Streaming.RequestAnimDict('anim@mp_player_intmenu@key_fob@', function()
				  TaskPlayAnim(playerPed, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 8.0, -8, -1, 49, 0, 0, 0, 0)
				  
				  Citizen.Wait(100)
  
				  ESX.ShowNotification("Du har <span style='color:red; font-weight: bold'>LÅST</span> ditt fordon.")
				  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'carlock', 0.7)
				  SetVehicleLights(vehicle, 2)
				  Citizen.Wait(200)
				  SetVehicleLights(vehicle, 1)
				  Citizen.Wait(200)
				  SetVehicleLights(vehicle, 2)
				  Citizen.Wait(200)
				  SetVehicleLights(vehicle, 1)
				  SetVehicleLightsMode(vehicle, 0)
				  SetVehicleLights(vehicle, 0)
	  
				  Citizen.Wait(1000)
				  ClearPedSecondaryTask(playerPed)
			  end)
		  else
			  ESX.ShowNotification("Du har <span style='color:red; font-weight: bold'>LÅST</span> ditt fordon.")
			  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'carlock', 0.7)
		  end
	  
	  elseif locked == 2 then -- if locked
		  SetVehicleDoorsLocked(vehicle, 1)
		  PlayVehicleDoorOpenSound(vehicle, 0)
		  if not IsPedInAnyVehicle(playerPed, true) then
			  ESX.Streaming.RequestAnimDict('anim@mp_player_intmenu@key_fob@', function()
				  TaskPlayAnim(playerPed, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 8.0, -8, -1, 49, 0, 0, 0, 0)
  
				  ESX.ShowNotification("Du har <span style='color:green; font-weight: bold'>LÅST UPP</span> ditt fordon.")
				  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'carlock', 0.7)
				  SetVehicleLights(vehicle, 2)
				  Citizen.Wait(200)
				  SetVehicleLights(vehicle, 1)
				  Citizen.Wait(200)
				  SetVehicleLights(vehicle, 2)
				  Citizen.Wait(200)
				  SetVehicleLights(vehicle, 1)
				  SetVehicleLightsMode(vehicle, 0)
				  SetVehicleLights(vehicle, 0)

				  Citizen.Wait(1000)
				  ClearPedSecondaryTask(playerPed)
			  end)
		  else
			  ESX.ShowNotification("Du har <span style='color:green; font-weight: bold'>LÅST UPP</span> ditt fordon.")
			  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'carlock', 0.7)
		  end
	  end
	  else
		ESX.ShowNotification("Du har inga nycklar till detta fordon.")
	  end
	end, GetVehicleNumberPlateText(vehicle))
end

RegisterNetEvent('menu:appliceraBuntband')
AddEventHandler('menu:appliceraBuntband', function()
	local ped = GetPlayerPed(-1)
	
	IsCuffed = true
	DraggedBy = nil

    SetEnableHandcuffs(ped, true)
    SetPedCanPlayGestureAnims(ped, false)
end)

RegisterNetEvent('menu:taAvBuntband')
AddEventHandler('menu:taAvBuntband', function()
	local ped = GetPlayerPed(-1)

	IsCuffed = false
	DraggedBy = nil

	ClearPedSecondaryTask(ped)

    SetEnableHandcuffs(ped, false)
    SetPedCanPlayGestureAnims(ped, true)
end)

VisiteraPerson = function(player)

	ESX.TriggerServerCallback('menu:getPlayerData', function(data)
  
	  local elements = {}
	  
	  table.insert(elements, {
		label  = 'Ta kontanter: ' .. data.money .. ' SEK',
		value  = 'money',
		itemType = 'item_money',
		amount = data.money
	  })
  
	  table.insert(elements, {label = '--- Vapen ---', value = nil})
  
	  for i=1, #data.weapons, 1 do
		table.insert(elements, {
		  label          = 'Ta vapen: ' .. ESX.GetWeaponLabel(data.weapons[i].name),
		  value          = data.weapons[i].name,
		  itemType       = 'item_weapon',
		  amount         = data.ammo,
		})
	  end
  
	  table.insert(elements, {label = '--- Ryggsäck ---', value = nil})
  
	  for i=1, #data.inventory, 1 do
		if data.inventory[i].count > 0 then
		  table.insert(elements, {
			label          = 'Ta föremål: ' .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
			value          = data.inventory[i].name,
			itemType       = 'item_standard',
			amount         = data.inventory[i].count,
		  })
		end
	  end
  
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'body_search',
		{
		  title    = 'Visiterar person...',
		  align    = 'right',
		  elements = elements,
		},
		function(data, menu)
  
		  local itemType = data.current.itemType
		  local itemName = data.current.value
		  local amount   = data.current.amount
  
		  if data.current.value ~= nil then
			if spelaVisiteringAnim == 0 then
				spelaVisiteringAnim = 1

				RequestAnimDict("amb@medic@standing@kneel@exit")
				RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
				RequestAnimDict("amb@medic@standing@kneel@base")
	
				while not HasAnimDictLoaded("amb@medic@standing@kneel@exit") do
					Citizen.Wait(0)
				end
	
				while not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@") do
					Citizen.Wait(0)
				end
	
				while not HasAnimDictLoaded("amb@medic@standing@kneel@base") do
					Citizen.Wait(0)
				end
	
				if IsEntityDead(GetPlayerPed(player)) then
					TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
				end
	
				TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
				Citizen.Wait(6200)
				spelaVisiteringAnim = 0
				local target, distance = ESX.Game.GetClosestPlayer()
            	if IsEntityPlayingAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search", 3) and distance ~= -1 and distance <= 3.0 then
                    TriggerServerEvent('menu:taItem', GetPlayerServerId(target), itemType, itemName, amount)--target va player
                    VisiteraPerson(player)
                    Citizen.Wait(800)
				else
					menu.close()
					ESX.ShowNotification('Personen är för långt ifrån dig.')
				end
				if IsEntityPlayingAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base", 3) then
                    TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@exit" ,"exit" ,8.0, -8.0, -1, 0, 0, false, false, false )
                end
			end
  
		  end
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end, GetPlayerServerId(player))
  
  end

RegisterNetEvent('esx_dmvschool:loadLicenses')
AddEventHandler('esx_dmvschool:loadLicenses', function(licenses)
	Licenses = licenses
end)

function OpenClotheMenu(target)

	local elements = {}

	table.insert(elements, {label = 'Tröja', value = 'tshirt'})
	table.insert(elements, {label = 'Byxor', value = 'byxor'})
	table.insert(elements, {label = 'Skor', value = 'skor'})
	table.insert(elements, {label = 'Väst', value = 'väst'})
	table.insert(elements, {label = 'Väska', value = 'väska'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'action_menu',
	{
		title    = ('Kläder'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		
		Clothe(data.current.value)

	end,
	function(data, menu)
		menu.close()
	end
    )
end

function Clothe(type)
	local playerPed = GetPlayerPed(-1)
	local _type = string.lower(type)

	if type == 'tshirt' then
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin['torso_1'] == 15 then		
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					local clothesSkin = {
						["torso_1"] = skin.torso_1,
						["torso_2"] = skin.torso_2,
						["tshirt_1"] = skin.tshirt_1,
						["tshirt_2"] = skin.tshirt_2,
						["arms"] = skin.arms,
						["arms_2"] = skin.arms_2,
						["chain_1"] = skin.chain_1,
						["chain_2"] = skin.chain_2,
						["decals_1"] = skin.decals_1,
						["decals_2"] = skin.decals_2,
					}
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end)
				end)		
			else
				local clothesSkin = {
					['tshirt_1'] = 15, ['tshirt_2'] = 0,
					['torso_1'] = 15, ['torso_2'] = 0,
					['arms'] = 15, ['arms_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
					['decals_1'] = 0, ['decals_2'] = 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
		end)
	end

	if type == 'byxor' then	
		TriggerEvent('skinchanger:getSkin', function(skin)

			if skin['pants_1'] == 21 then

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)

					local clothesSkin = {
						['pants_1'] = skin.pants_1, ['pants_2'] = skin.pants_2
					}
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end)
				end)		
			else

				local clothesSkin = {
				['pants_1'] = 21, ['pants_2'] = 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
		end)
	end
	
	if type == 'skor' then	
		TriggerEvent('skinchanger:getSkin', function(skin)

			if skin['shoes_1'] == 34 then

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)

					local clothesSkin = {
						['shoes_1'] = skin.shoes_1, ['shoes_2'] = skin.shoes_2
					}
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end)
				end)		
			else

				local clothesSkin = {
				['shoes_1'] = 34, ['shoes_2'] = 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
		end)
	end

	if type == 'väska' then	
		TriggerEvent('skinchanger:getSkin', function(skin)

			if skin['bags_1'] == 0 then

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)

					local clothesSkin = {
						['bags_1'] = skin.bags_1, ['bags_2'] = skin.bags_2
					}
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end)
				end)		
			else

				local clothesSkin = {
				['bags_1'] = 0, ['bags_2'] = 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
		end)
	end	
end

local disableShuffle = false
function disableSeatShuffle(flag)
  disableShuffle = flag
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
      if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
        if GetIsTaskActive(GetPlayerPed(-1), 165) then
          SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
        end
      end
    end
  end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    disableSeatShuffle(false)
    Citizen.Wait(5000)
    disableSeatShuffle(true)
  else
    CancelEvent()
  end
end)

RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)

ammo = 10

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
end)









local ped = nil
Config = {
	markercoords = vector3(-811.91, 374.72, 87.88),

	ped = {
		hash = "csb_ortega",
		pos = vector4(4166.78, 4483.10, 4.10, 321.58)
	},

	items = {
        --{ label = "Aceton", item = "acetone", type = "item", price = 100 },
        --{ label = "Kokain", item = "coke", type = "item", price = 800 },
        --{ label = "Påse Kokain", item = "coke_pooch", type = "item", price = 2500 },
        --{ label = "Heroin", item = "opium", type = "item", price = 600 },
        --{ label = "Påse Heroin", item = "opium_pooch", type = "item", price = 800 },
        --{ label = "Cannabisfrö", item = "seed_weed", type = "item", price = 300 },
    }

}

CreateThread(function()
	if not DoesEntityExist(ped) then
		RequestModel(Config.ped.hash)
		while not HasModelLoaded(Config.ped.hash) do
			Citizen.Wait(50)
		end
		ped = CreatePed(4, Config.ped.hash, Config.ped.pos - vector4(0, 0, 0.98, 0))
		SetEntityAsMissionEntity(ped)
		SetBlockingOfNonTemporaryEvents(ped, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
	end

	while true do local sleep, player = 1000, PlayerPedId()
		if GetDistanceBetweenCoords(GetEntityCoords(player), Config.ped.pos.x, Config.ped.pos.y, Config.ped.pos.z, true) <= 2.5 then
			sleep = 5
			ESX.ShowHelpNotification("~INPUT_CONTEXT~ Prata med Eduardo")
			if IsControlJustReleased(0, 38) then
				local elements = {}
				for itemIndex, itemValue in pairs(Config.items) do
					table.insert(elements, {
						label = itemValue.label .. " - <span style='color:green'>" .. itemValue.price .. " SEK</span>",
						data = { label = itemValue.label, item = itemValue.item, type = itemValue.type, price = itemValue.price }
					})
				end
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open("default", GetCurrentResourceName(), "blackmarket", {
					title = "Eduardo",
					align = "right",
					elements = elements
				}, function(data, menu)
					TriggerServerEvent("blackmarket:buy", data.current["data"])
				end, function(data, menu)
					menu.close()
				end
				)
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(player), -30.25, -1098.7, 26.42, true) <= 2 then
			sleep = 5
			ESX.ShowHelpNotification("~INPUT_CONTEXT~ Åk upp med hissen")
			if IsControlJustReleased(0, 38) then
				DoScreenFadeOut(1000)
				Wait(1200)
				SetEntityCoords(player, -29.96, -1098.01, 35.6)
				SetEntityHeading(player, 155.97)
				Wait(600)
				DoScreenFadeIn(500)
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(player), -29.96, -1098.01, 35.6, true) <= 2 then
			sleep = 5
			ESX.ShowHelpNotification("~INPUT_CONTEXT~ Åk ner med hissen")
			if IsControlJustReleased(0, 38) then
				DoScreenFadeOut(1000)
				Wait(1200)
				SetEntityCoords(player, -30.25, -1098.7, 26.42)
				SetEntityHeading(player, 68.6)
				Wait(600)
				DoScreenFadeIn(500)
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(player), -37.76, -1088.07, 25.96, true) <= 2 then
			if IsPedInAnyVehicle(player, false) then
				local vehicle = GetVehiclePedIsIn(player, false)
				sleep = 5
				ESX.ShowHelpNotification("~INPUT_CONTEXT~ Åk upp med bilhissen")
				if IsControlJustReleased(0, 38) then
					DoScreenFadeOut(1000)
					Wait(1200)
					SetEntityCoords(vehicle, -33.31, -1094.49, 35.19)
					SetEntityHeading(vehicle, 159.95)
					TaskWarpPedIntoVehicle(player, vehicle, -1)
					Wait(600)
					DoScreenFadeIn(500)
				end
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(player), -33.31, -1094.49, 35.19, true) <= 2 then
			if IsPedInAnyVehicle(player, false) then
				local vehicle = GetVehiclePedIsIn(player, false)
				sleep = 5
				ESX.ShowHelpNotification("~INPUT_CONTEXT~ Åk ner med bilhissen")
				if IsControlJustReleased(0, 38) then
					DoScreenFadeOut(1000)
					Wait(1200)
					SetEntityCoords(vehicle, -37.76, -1088.07, 25.96)
					SetEntityHeading(vehicle, 249.63)
					TaskWarpPedIntoVehicle(player, vehicle, -1)
					Wait(600)
					DoScreenFadeIn(500)
				end
			end
		end

		Wait(sleep)
	end
end)

DrawAdvancedMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, true, 2, false, false, false, false)
end
