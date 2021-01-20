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
local cars      = {}
local PlayerData = nil
local maxspeedcar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
local maxspeed = 150.0
local engine = 1
local windows = 1
local balteswarning = false

Citizen.CreateThread(function()
  while ESX == nil do
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  Citizen.Wait(0)
  end

  PlayerData = ESX.GetPlayerData()
end)


Citizen.CreateThread(function()
  while true do
    if IsPedInAnyVehicle(GetPlayerPed(-1),  false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
    maxspeedcar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetEntityMaxSpeed(maxspeedcar, maxspeed)
    end

    if IsPedInAnyVehicle(GetPlayerPed(-1),  false) and engine == 2 then
    SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
  end
    Citizen.Wait(0)
  end
end)

local disableShuffle = true
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
end, false) --False, allow everyone to run it

function OpenFordonsMenu(menu)

    local elements = {
      --{label = 'Sätt på/av bälte', value = 'belt'},
      {label = 'Lås/Lås upp fordon',     value = 'locking'},
      {label = 'Motor av/på',     value = 'engine'},
      {label = 'Fordonsdörrar',     value = 'doors'},
      {label = 'Farthållare',     value = 'speedlimit'},
      --{label = 'Veva ner rutorna', value = 'windows'},
      --{label = 'Bälte På / av',    value = 'belt'},
 

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'OpenFordonsMenu',
      {
        title    = 'Fordonsmeny',
        align    = 'right',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'locking' then
          locking()
        end

      if data.current.value == 'engine' then
          toggleEngine()
        end

      if data.current.value == 'speedlimit' then
        openSpeedlimitMenu()
      end


      if data.current.value == 'windows' then
        toggleWindows()
      end

      if data.current.value == 'belt' then
        beltToggle()
      end

      if data.current.value == 'doors' then
          openDoorMenu()
        end


      end,
      function(data, menu)
		menu.close()
	   end
    )
end

function openDoorMenu()
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'door_actions',
    {
      title    = 'Dörrar',
      align    = 'right',
      elements = {
        {label = 'Motorhuv', value = 'motorhuv'},
        {label = 'Bagage', value = 'bagage'},
        {label = 'Vänster fram', value = 'vfr'},
        {label = 'Höger fram', value = 'hfr'},
        {label = 'Vänster bak', value = 'hbk'},
        {label = 'Höger bak', value = 'vbk'},
      },
    },
    function(data, menu)
      local playerVeh = nil
      local playerPed = GetPlayerPed(-1)
      local coords    = GetEntityCoords(playerPed)
      if data.current.value == 'motorhuv' then
        if IsPedInAnyVehicle(playerPed,  false) then
          playerVeh = GetVehiclePedIsIn(playerPed, false)
        else
          playerVeh = GetClosestVehicle(coords.x, coords.y, coords.z, 4.0, 0, 71)
        end
        local locked = GetVehicleDoorLockStatus(playerVeh)
        local pedd = GetPedInVehicleSeat(playerVeh, -1)
        if locked == 1 and pedd == 0 or pedd == playerPed then
          if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
            SetVehicleDoorShut(playerVeh, 4, false)
          else
            SetVehicleDoorOpen(playerVeh, 4, false)      
          end
        end
      end
      if data.current.value == 'bagage' then
        if IsPedInAnyVehicle(playerPed,  false) then
          playerVeh = GetVehiclePedIsIn(playerPed, false)
        else
          playerVeh = GetClosestVehicle(coords.x, coords.y, coords.z, 5.2, 0, 71)
        end
        local locked = GetVehicleDoorLockStatus(playerVeh)
        local pedd = GetPedInVehicleSeat(playerVeh, -1)
        if locked == 1 and pedd == 0 or pedd == playerPed then
          if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
            SetVehicleDoorShut(playerVeh, 5, false)
          else
            SetVehicleDoorOpen(playerVeh, 5, false)      
          end
        end
      end
      if data.current.value == 'vfr' then
        if IsPedInAnyVehicle(playerPed,  false) then
          playerVeh = GetVehiclePedIsIn(playerPed, false)
        else
          playerVeh = GetClosestVehicle(coords.x, coords.y, coords.z, 4.0, 0, 71)
        end
        local locked = GetVehicleDoorLockStatus(playerVeh)
        local pedd = GetPedInVehicleSeat(playerVeh, -1)
        if locked == 1 and pedd == 0 or pedd == playerPed then
          if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
            SetVehicleDoorShut(playerVeh, 0, false)
          else
            SetVehicleDoorOpen(playerVeh, 0, false)      
          end
        end
      end
      if data.current.value == 'hfr' then
        if IsPedInAnyVehicle(playerPed,  false) then
          playerVeh = GetVehiclePedIsIn(playerPed, false)
        else
          playerVeh = GetClosestVehicle(coords.x, coords.y, coords.z, 4.0, 0, 71)
        end
        local locked = GetVehicleDoorLockStatus(playerVeh)
        local pedd = GetPedInVehicleSeat(playerVeh, -1)
        if locked == 1 and pedd == 0 or pedd == playerPed then
          if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
            SetVehicleDoorShut(playerVeh, 1, false)
          else
            SetVehicleDoorOpen(playerVeh, 1, false)      
          end
        end
      end
      if data.current.value == 'vbk' then
        if IsPedInAnyVehicle(playerPed,  false) then
          playerVeh = GetVehiclePedIsIn(playerPed, false)
        else
          playerVeh = GetClosestVehicle(coords.x, coords.y, coords.z, 4.0, 0, 71)
        end
        local locked = GetVehicleDoorLockStatus(playerVeh)
        local pedd = GetPedInVehicleSeat(playerVeh, -1)
        if locked == 1 and pedd == 0 or pedd == playerPed then
          if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
            SetVehicleDoorShut(playerVeh, 3, false)
          else
            SetVehicleDoorOpen(playerVeh, 3, false)      
          end
        end
      end
      if data.current.value == 'hbk' then
        if IsPedInAnyVehicle(playerPed,  false) then
          playerVeh = GetVehiclePedIsIn(playerPed, false)
        else
          playerVeh = GetClosestVehicle(coords.x, coords.y, coords.z, 4.0, 0, 71)
        end
        local locked = GetVehicleDoorLockStatus(playerVeh)
        local pedd = GetPedInVehicleSeat(playerVeh, -1)
        if locked == 1 and pedd == 0 or pedd == playerPed then
          if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
            SetVehicleDoorShut(playerVeh, 2, false)
          else
            SetVehicleDoorOpen(playerVeh, 2, false)      
          end
        end
      end
    end,
    function(data, menu)
      menu.close()
    end
  )
end

function openSpeedlimitMenu()
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'speedlimit_actions',
    {
      title    = 'Cruise Control',
      align    = 'right',
      elements = {
        {label = 'Ingen begränsning', value = 540.0},
        {label = '30 KM/H', value = 30.0},
        {label = '50 KM/H', value = 50.0},
        {label = '80 KM/H', value = 80.0},
        {label = '120 KM/H', value = 119.5},
      },
    },
    function(data, menu)
      if data.current.value == 'egen' then
      else
        maxspeed = data.current.value / 3.6
      end
    end,
    function(data, menu)
      menu.close()
    end
  )
end

function locking()
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
  
  
 ESX.TriggerServerCallback('esx_vehiclelock:requestPlayerCars', function(isOwnedVehicle)
  
	
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	--print (vehicleProps.plate)
	  if isOwnedVehicle or (PlayerData.job.name == 'police' and vehicleProps.plate == 'POLIS' or PlayerData.job.name == 'mecano' and vehicleProps.plate == 'MEKANO' or PlayerData.job.name == 'nightclub' and vehicleProps.plate == 'DRAGAN' or PlayerData.job.name == 'ambulance' and vehicleProps.plate == 'AMBULANS' or PlayerData.job.name == 'lawyer' and vehicleProps.plate == 'ADVOKAT' or PlayerData.job.name == 'Securitas' and vehicleProps.plate == 'SECURI' or PlayerData.job.name == "taxi" and vehicleProps.plate == "TAXI" ) then
		local locked = GetVehicleDoorLockStatus(vehicle)
		local heading = GetEntityHeading(playerPed)
		if locked == 1 then -- if unlocked
		loadanim()
      	TaskPlayAnim(GetPlayerPed(-1), 'anim@mp_player_intmenu@key_fob@', 'fob_click', 8.0, -8.0, -1, 48, 0, 0, 0, 0)
		  SetVehicleDoorsLocked(vehicle, 2)
		  PlayVehicleDoorCloseSound(vehicle, 1)
		  --sendNotification('Du har LÅST ditt fordon', 'error', 2500)
      TriggerEvent('esx:showNotification', 'Du har LÅST ditt fordon!')
		elseif locked == 2 then -- if locked
		  SetVehicleDoorsLocked(vehicle, 1)
		  PlayVehicleDoorOpenSound(vehicle, 0)
		  if not IsPedInAnyVehicle(playerPed,  false) then
			SetPedIntoVehicle(playerPed, vehicle, -1)
			TaskLeaveVehicle(playerPed, vehicle, 16)
			SetEntityCoords(playerPed, coords.x, coords.y, coords.z-0.99, 1, 0, 0, 1)
			SetEntityHeading(playerPed, heading)
		  end
	  	loadanim()
      TaskPlayAnim(GetPlayerPed(-1), 'anim@mp_player_intmenu@key_fob@', 'fob_click', 8.0, -8.0, -1, 48, 0, 0, 0, 0)
      TriggerEvent('esx:showNotification', 'Du har LÅST UPP ditt fordon!')
		end
	  else
		--sendNotification('Du har INGA nycklar till detta fordon', 'error', 2500)
    TriggerEvent('esx:showNotification', 'Du har INGA nycklar till detta fordon!')
	  end
	end, ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
  end


function toggleWindows()
  if windows == 1 then
    windows = 2
  else
    RollUpWindow(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    RollUpWindow(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1)
    windows = 1
  end
    
end

function loadanim()
 
  RequestAnimDict("anim@mp_player_intmenu@key_fob@")
  while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
  Wait(0)
  end

end

function toggleEngine()
  if engine == 1 then
    engine = 2
  else
    engine = 1
  end
    
end

function beltToggle()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 8 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 13 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 14 then
    TriggerEvent('belt')
  end
    
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

-- Main thread
Citizen.CreateThread(function()
  while true do

  Wait(0)

  if IsControlPressed(0,  Keys['M']) then
    OpenFordonsMenu()
    Wait(10)
  end
  end
end)

Citizen.CreateThread(function()
  while true do

  Wait(0)

  if windows == 2 then
    RollUpWindow(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    RollUpWindow(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1)
    RollDownWindow(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    RollDownWindow(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1)
    Wait(500)
  end
  end
end)

--reset belte
--Citizen.CreateThread(function()
  --while true do

  --Wait(500)
  --if not IsPedInAnyVehicle(GetPlayerPed(-1),  false) then
    --DecorRegister("IsBelted",  3)
      --DecorSetInt(GetPlayerPed(-1), "IsBelted", 0)
    --end
  --end
----end)

--Citizen.CreateThread(function()
    --while true do
        --Citizen.Wait(750)
        --if IsPedInAnyVehicle(GetPlayerPed(-1),  false) and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 8 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 13 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 14 and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1)  or GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1)) then
          --if beltep1 == false or beltep2 == false or beltep3 == false or beltep4 == false then
            --balteswarning = not balteswarning
          --else
            --balteswarning = false
          --end
        --else
          --balteswarning = false
        --end
    --end
--end)

--Citizen.CreateThread(function()
    --while true do
        --Citizen.Wait(0)
        --numSeats = GetVehicleModelNumberOfSeats(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
      --if numSeats > 0 and not IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) and DecorGetInt(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1),"IsBelted") ~= 1 then
        --beltep1 = false
      --else
        --beltep1 = true
      --end
      --if numSeats > 1 and not IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) and DecorGetInt(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0),"IsBelted") ~= 1 then
        --beltep2 = false
      --else
        --beltep2 = true
      ---end
      --if  numSeats > 2 and not IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1) and DecorGetInt(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1),"IsBelted") ~= 1 then
        --beltep3 = false
      --else
        --beltep3 = true
      --end
      --if  numSeats > 3 and not IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2) and DecorGetInt(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2),"IsBelted") ~= 1 then
        --beltep4 = false
      --else
        --beltep4 = true
      --end
    --end
--end)

--notification
function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "duty",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end

function getVehicleInDirection(coordFrom, coordTo)
  local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
  return vehicle
end

local doors = {
  {"seat_dside_f", -1},
  {"seat_pside_f", 0},
  {"seat_dside_r", 1},
  {"seat_pside_r", 2}
}

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end


RestrictEmer = false -- Only allow this feature for emergency vehicles.
keepDoorOpen = true -- Keep the door open when getting out.

--- Code ---
local notify = false

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)

        if not notify then
            if IsPedInAnyVehicle(ped, true) then
            notify = false
            end
        end
        if RestrictEmer then
            if GetVehicleClass(veh) == 18 then
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    Citizen.Wait(150)
                    if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                        SetVehicleEngineOn(veh, true, true, false)
                        if keepDoorOpen then
                            TaskLeaveVehicle(ped, veh, 256)
                        else
                            TaskLeaveVehicle(ped, veh, 0)
                        end
                    end
                end
            end
        else
            if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                Citizen.Wait(150)
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    SetVehicleEngineOn(veh, true, true, false)
                    if keepDoorOpen then
                        TaskLeaveVehicle(ped, veh, 256)
                    else
                        TaskLeaveVehicle(ped, veh, 0)
                    end
                end
            end
        end
	end
end)


interactionDistance = 3.5 --The radius you have to be in to interact with the vehicle.
lockDistance = 25 --The radius you have to be in to lock your vehicle.

--  V A R I A B L E S --
engineoff = false
saved = false
controlsave_bool = false

-- E N G I N E --
IsEngineOn = true
RegisterNetEvent('engine')
AddEventHandler('engine',function() 
	local player = GetPlayerPed(-1)
	
	if (IsPedSittingInAnyVehicle(player)) then 
		local vehicle = GetVehiclePedIsIn(player,false)
		
		if IsEngineOn == true then
			IsEngineOn = false
			SetVehicleEngineOn(vehicle,false,false,false)
		else
			IsEngineOn = true
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
		end
		
		while (IsEngineOn == false) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
		end
	end
end)

RegisterNetEvent('engineoff')
AddEventHandler('engineoff',function() 
		local player = GetPlayerPed(-1)

        if (IsPedSittingInAnyVehicle(player)) then 
            local vehicle = GetVehiclePedIsIn(player,false)
			engineoff = true
			ShowNotification("Motor ~r~avstängd~s~")
			while (engineoff) do
			SetVehicleEngineOn(vehicle,false,false,false)
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
			end
		end
end)
RegisterNetEvent('engineon')
AddEventHandler('engineon',function() 
    local player = GetPlayerPed(-1)

        if (IsPedSittingInAnyVehicle(player)) then 
            local vehicle = GetVehiclePedIsIn(player,false)
			engineoff = false
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
			ShowNotification("Motor ~g~på~s~")
	end
end)
-- T R U N K --
RegisterNetEvent('trunk')
AddEventHandler('trunk',function() 
	local player = GetPlayerPed(-1)
			if controlsave_bool == true then
				vehicle = saveVehicle
			else
				vehicle = GetVehiclePedIsIn(player,true)
			end
			
			local isopen = GetVehicleDoorAngleRatio(vehicle,5)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,5,0,0)
				else
				SetVehicleDoorShut(vehicle,5,0)
				end
			end
end)

-- R E A R  D O O R S --
RegisterNetEvent('rdoors')
AddEventHandler('rdoors',function() 
	local player = GetPlayerPed(-1)
    		if controlsave_bool == true then
				vehicle = saveVehicle
			else
				vehicle = GetVehiclePedIsIn(player,true)
			end
			local isopen = GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,2,0,0)
				SetVehicleDoorOpen(vehicle,3,0,0)
				else
				SetVehicleDoorShut(vehicle,2,0)
				SetVehicleDoorShut(vehicle,3,0)
				end
			end
end)		

-- H O O D --
RegisterNetEvent('hood')
AddEventHandler('hood',function() 
	local player = GetPlayerPed(-1)
    	if controlsave_bool == true then
			vehicle = saveVehicle
		else
			vehicle = GetVehiclePedIsIn(player,true)
		end
			
			local isopen = GetVehicleDoorAngleRatio(vehicle,4)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,4,0,0)
				else
				SetVehicleDoorShut(vehicle,4,0)
				end
      end
end)

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end
-- S A V E --
RegisterNetEvent('save')
AddEventHandler('save',function() 
	local player = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(player)) then 
		if  saved == true then
			--remove from saved.
			saveVehicle = nil
			RemoveBlip(targetBlip)
			ShowNotification("Markeringen ~r~togs bort~w~.")
			saved = false
		else
			RemoveBlip(targetBlip)
			saveVehicle = GetVehiclePedIsIn(player,true)
			local vehicle = saveVehicle
			targetBlip = AddBlipForEntity(vehicle)
			SetBlipSprite(targetBlip,225)
			ShowNotification("Du markerade din " .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ .")
			saved = true
		end
	end
end)
-- R E M O T E --
RegisterNetEvent('controlsave')
AddEventHandler('controlsave',function() 
		if controlsave_bool == false then
			controlsave_bool = true
			if saveVehicle == nil then
			ShowNotification("~r~Inget fordon sparat.")
			else
			ShowNotification("Du kontrollerar inte ditt fordon längre ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(saveVehicle))))
			end
		else
			controlsave_bool = false
			if saveVehicle == nil then
			ShowNotification("~r~Inget fordon sparat.")
			else
			ShowNotification("Du kontrollerar inte ditt fordon längre ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(saveVehicle))))
			end
		end
end)
