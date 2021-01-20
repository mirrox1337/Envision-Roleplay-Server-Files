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

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastPad                 = nil
local LastAction                = nil
local LastPadData             = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = nil
local ClickedInsideMarker       = false
local MarkerDelay               = 0

ESX                             = nil
GUI.Time                        = 0
--and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function getJob()
  
  if PlayerData.job ~= nil then
  return PlayerData.job.name  
  
  end  
end

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj)
		ESX = obj
	end)
    
	Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx_teleportpads:hasEnteredMarker')
AddEventHandler('esx_teleportpads:hasEnteredMarker', function(name, data) 
  CurrentAction = 'pad.' .. string.lower(name)
  CurrentActionMsg = data.Text
  CurrentActionData = { label = name, data = data }
end)

RegisterNetEvent('esx_teleportpads:hasExitedMarker')
AddEventHandler('esx_teleportpads:hasExitedMarker', function()
  ESX.UI.Menu.CloseAll()
  
  CurrentAction = nil
  ClickedInsideMarker = false
end)

-- [DISPLAYING MARKERS] --
Citizen.CreateThread(function()
  while true do
    Wait(0)
    
	local playerPed = GetPlayerPed(-1)
    local coords = GetEntityCoords(playerPed)

    for pad,padData in pairs(Config.Pads) do  
      if GetDistanceBetweenCoords(coords, padData.Marker.x,  padData.Marker.y, padData.Marker.z,  true) < Config.DrawDistance then
        DrawMarker(Config.MarkerType, padData.Marker.x, padData.Marker.y, padData.Marker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
      end
    end
  end
end)

-- [ENTER/EXIT EVENTS] --
Citizen.CreateThread(function()
  while true do
    Wait(0)
	
    local playerPed = GetPlayerPed(-1)
    local coords = GetEntityCoords(playerPed)
    local isInMarker = false
    local currentPad = nil
    local currentAction = nil
	local currentPadData = nil

    for pad,padData in pairs(Config.Pads) do
      if GetDistanceBetweenCoords(coords, padData.Marker.x, padData.Marker.y, padData.Marker.z, true) < (Config.MarkerSize.x * 1.5) then
        isInMarker = true
		  
        currentPad = pad
        currentAction = 'pad.' .. string.lower(pad)
		currentPadData = padData
      end
    end

    local hasExited = false

    if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastPad ~= currentPad or LastAction ~= currentAction)) then
      if (LastPad ~= nil and LastAction ~= nil) and (LastPad ~= currentPad or LastAction ~= currentAction) then
        TriggerEvent('esx_teleportpads:hasExitedMarker', LastPad, LastAction)
          
		hasExited = true
      end

      HasAlreadyEnteredMarker = true
		
      LastPad = currentPad
      LastAction = currentAction
      LastPadData = currentPadData

      TriggerEvent('esx_teleportpads:hasEnteredMarker', currentPad, currentPadData)
    end

    if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false

      TriggerEvent('esx_teleportpads:hasExitedMarker', LastPad, LastAction)
    end
  end
end)

-- [KEYBOARD EVENTS] -- 
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
	  
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0, Keys['E']) and (GetGameTimer() - GUI.Time) > 150 then
		if ClickedInsideMarker == false then
		  if MarkerDelay == 0 then
		    ClickedInsideMarker = true
		  
		    local coords = CurrentActionData.data.TeleportPoint
		  
		    SetEntityCoords(GetPlayerPed(-1), coords.x, coords.y, coords.z)
		  
		    MarkerDelay = 1000
		  end
        end
      end
    end
  end
end)
Citizen.CreateThread(function()
  while true do
	Citizen.Wait(10)
	
	if MarkerDelay > 0 then
		MarkerDelay = MarkerDelay - 10
		
		if MarkerDelay < 0 then
		  MarkerDelay = 0
		end
	end
  end
end)