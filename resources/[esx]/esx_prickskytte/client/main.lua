local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

---qalle
local hasBulletproof 				  = false

--- action functions
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local weapons = {
  "WEAPON_PISTOL",
}

---jakt
local entitySkin
local entityType
local entityQuantity = 1
local missionX = -1492.2
local missionY = 4971.5
local missionZ = 64.2
local entityBlip = {}
local djurspawn
local entityAlive = false
local entityHealth = {}
local entity = {}
local entitySpawned = true
local remover = false
local hasLicens = false

local missionCoords = {
  {x=26.66, y=-1079.97, z=28.8},
  {x=16.78, y=-1081.63, z=28.8},
  {x=17.51, y=-1077.57, z=28.8},
  {x=23.29, y=-1073.61, z=28.8},
}

local entityRemoved = {}
local vending = false
local count = 5
local blipid = 0
local missionRunning = false
local entityType = {28}   --Player,1|Male,4|Female,5|Cop,6|Human,26|SWAT,27|Animal,28|Army,29
local entitySkin = {GetHashKey("a_c_deer")}
local reset = false
local rovdjur = 1
local isinjob = false
local spawned_car = nil
local a = math.random(1, 4)

--- esx
local GUI = {}
ESX                           = nil
GUI.Time                      = 0
local PlayerData              = {}

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
 	PlayerData = ESX.GetPlayerData()
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

----markers
AddEventHandler('guntrain:hasEnteredMarker', function (zone)
  if zone == 'TakeKeyPolice' and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
    CurrentAction     = 'take_key_police'
    CurrentActionMsg  = 'Tryck ~INPUT_CONTEXT~ för att ta ut ett passerkort.'
    CurrentActionData = {}
  end
end)

AddEventHandler('guntrain:hasEnteredMarker', function (zone)
  if zone == 'TakeRadioPolice' and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
    CurrentAction     = 'take_radio_police'
    CurrentActionMsg  = 'Tryck ~INPUT_CONTEXT~ för att ta ut radio .'
    CurrentActionData = {}
  end
end)

AddEventHandler('guntrain:hasExitedMarker', function (zone)
  if not IsInShopMenu then
    ESX.UI.Menu.CloseAll()
  end

  CurrentAction = nil
end)



--keycontrols
Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)
    local ped = GetPlayerPed(-1)
    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0, Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
        if CurrentAction == 'training' then
                  GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"),250, true, true)
                  TriggerEvent('skinchanger:getSkin', function(skin)

                  if skin.sex == 0 then

                  local clothesSkin = {
                  ['helmet_1'] = 0, ['helmet_2'] = 0,
                  ['glasses_1'] = 23, ['glasses_2'] = 0
                  }
                  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                  else

                  local clothesSkin = {
                  ['helmet_1'] = 0, ['helmet_2'] = 0,
                  ['glasses_1'] = 25, ['glasses_2'] = 1
                  }
                  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                  end

                  local playerPed = GetPlayerPed(-1)
                  SetPedArmour(playerPed, 0)
                  ClearPedBloodDamage(playerPed)
                  ResetPedVisibleDamage(playerPed)
                  ClearPedLastWeaponDamage(playerPed)
                  sendNotification(_U('equipment'), 'success', 2500)

                  end)
                end

        if CurrentAction == 'trainingcomplete' and not CheckWeapon(ped) then
          sendNotification(_U('nothing'), 'error', 2500)
        end

        --köp skottsäkervest
        if CurrentAction == 'buy_bulletproof_vest' then
           TriggerServerEvent('esx_qalle:removeMoney', Config.BulletProofPrice)
        end

        --passerkort för polisen
        if CurrentAction == 'take_key_police' then
          TriggerServerEvent('esx_policejob:getKey', 'policecard', 1)
          sendNotification('Du tog ut ett passerkort', 'success', 2500)
          CurrentAction = nil
        end

        if CurrentAction == 'take_radio_police' then
          TriggerServerEvent('esx_policejob:getRadio', 'radio', 1)
          sendNotification('Du tog ut en radio', 'success', 2500)
          CurrentAction = nil
        end

        if CurrentAction == 'trainingcomplete' and CheckWeapon(ped) then
                  RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"),250, true, true)
                  TriggerEvent('skinchanger:getSkin', function(skin)

                  if skin.sex == 0 then

                  local clothesSkin = {
                  ['helmet_1'] = -1, ['helmet_2'] = 0,
                  ['glasses_1'] = 0, ['helmet_2'] = 0
                  }
                  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                  else

                  local clothesSkin = {
                  ['helmet_1'] = -1, ['helmet_2'] = 0,
                  ['glasses_1'] = 5, ['glasses_2'] = 0
                  }
                  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                  end

                  local playerPed = GetPlayerPed(-1)
                  SetPedArmour(playerPed, 0)
                  ClearPedBloodDamage(playerPed)
                  ResetPedVisibleDamage(playerPed)
                  ClearPedLastWeaponDamage(playerPed)
                  sendNotification(_U('equipmentdone'), 'success', 5000)
                  end)
              end
        if CurrentAction == 'trainingstart' then
            local entityCoords = {
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0},
                {x=0, y=0, z=0}
              }
            if GetDistanceBetweenCoords( GetEntityCoords(GetPlayerPed(-1)),missionCoords[a].x , missionCoords[a].y , missionCoords[a].z, true ) < 80 then
                missionRunning = true
                entityType = {28,28,28,28,28}   
                entitySkin =  {GetHashKey("a_c_deer"),GetHashKey("a_c_boar"),GetHashKey("a_c_mtlion"),GetHashKey("a_c_pig"),GetHashKey("a_c_cow"),
                        GetHashKey("a_c_pig"),GetHashKey("a_c_deer"),GetHashKey("a_c_mtlion"),GetHashKey("a_c_cow"),
                        GetHashKey("a_c_coyote"),GetHashKey("a_c_coyote"),GetHashKey("a_c_boar"),GetHashKey("a_c_boar")}
                entitySpawned = false
                remover = true
                djurspawn = AddBlipForCoord(missionCoords[a].x,missionCoords[a].y,missionCoords[a].z)
                SetBlipColour(djurspawn,1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(_U('animal'))
                EndTextCommandSetBlipName(djurspawn)
            if (entitySpawned==false) then
                local spawnrovdjur = math.random(1, 13)
                RequestModel(entitySkin[rovdjur]) 
                while not HasModelLoaded(entitySkin[rovdjur]) do
                  Wait(1)
                end

                if (djurspawn~= nil) then
                  RemoveBlip(djurspawn)
                end
                entity[rovdjur] = CreatePed(entityType[spawnrovdjur], entitySkin[rovdjur], missionCoords[a].x, missionCoords[a].y, missionCoords[a].z, 0, true, true)
                missionX = missionCoords[a].x
                missionY = missionCoords[a].y
                missionZ = missionCoords[a].z
                SetEntityAsMissionEntity(entity[rovdjur], true, true)
                TaskWanderStandard(entity[rovdjur], 0, 0)
                entityAlive = true
                entitySpawned = true
                remover = false
                
            end
            
            if (missionRunning == true and entitySpawned == true) then  
              entityHealth[rovdjur] = GetEntityHealth(entity[rovdjur])
              blipid = entityBlip[rovdjur]
              local vX , vY , vZ = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blipid, Citizen.ResultAsVector()))
              entityCoords[rovdjur].x = vX
              entityCoords[rovdjur].y = vY
              entityCoords[rovdjur].z = vZ
              if (entityHealth[rovdjur] == 0 and entityAlive == true) then
                entityAlive = false
                entityRemoved[rovdjur] = false
              end
                if (GetDistanceBetweenCoords( GetEntityCoords(GetPlayerPed(-1)),entityCoords[rovdjur].x , entityCoords[rovdjur].y , entityCoords[rovdjur].z, true ) < 40 and entityAlive == false) then
                  ClearPrints()
                  SetTextEntry_2("STRING")
                  Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity[rovdjur]))
                  entityRemoved[rovdjur] = true
                  entitySpawned = false
                  rovdjur = math.random(1,12)
                  a = math.random(1, 4)
                  end
                end
              end
            end

        GUI.Time      = GetGameTimer()
      end
    end
  end
end)

-- Display markers
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords = GetEntityCoords(GetPlayerPed(-1))

    for k,v in pairs(Config.Zones) do
      if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local isInMarker  = false
    local currentZone = nil

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
        isInMarker  = true
        currentZone = k
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone                = currentZone
      TriggerEvent('guntrain:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('guntrain:hasExitedMarker', LastZone)
    end
  end
end)

--skottsäkervest
RegisterNetEvent('esx_qalle:bulletproof')
AddEventHandler('esx_qalle:bulletproof', function()


	local playerPed = GetPlayerPed(-1)
	SetPedComponentVariation(playerPed, 9, 27, 9 ,2)
	AddArmourToPed(playerPed, 100)
	SetPedArmour(playerPed, 100)

end)

--skottsäkervest av
RegisterNetEvent('esx_qalle:bulletproofoff')
AddEventHandler('esx_qalle:bulletproofoff', function()


	local playerPed = GetPlayerPed(-1)

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	TriggerEvent('skinchanger:loadSkin', skin)
    
	end)
	SetPedArmour(playerPed, 0)

end)

---alla grejer
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

	TriggerEvent('esx_qalle:hasNotBulletproof')

	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'bulletproof' then
			if PlayerData.inventory[i].count > 0 then
				TriggerEvent('esx_qalle:hasBulletproof')
			end
		end
	end
end)

--skottsäkravestar
RegisterNetEvent('esx_qalle:hasBulletproof')
AddEventHandler('esx_qalle:hasBulletproof', function()
	hasBulletproof = true
end)

RegisterNetEvent('esx_qalle:hasNotBulletproof')
AddEventHandler('esx_qalle:hasNotBulletproof', function()
	hasBulletproof = false
end)

--telefonkiosk
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x = 17.9
        local y = -1103.0
        local z = 29.8

            local playerPos = GetEntityCoords(GetPlayerPed(-1), true)

            local pP = GetPlayerPed(-1)
 
            if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 20.0) then
                DrawMarker(27, x, y, z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 0, 255,165, 0, 0, 0,0)

                if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 2.0) then
                    DisplayHelpText(('Tryck ~INPUT_CONTEXT~ för att använda telefonkiosken'))

                if hasUsed then
                	Citizen.Wait(60000)
                	ESX.UI.Menu.CloseAll()
                	hasUsed = false
                end

                if (IsControlJustReleased(1, 51)) then
                	ESX.UI.Menu.CloseAll()
                	ESX.ShowNotification('Du har lånat en telefon i ~g~1 minut')
                    ESX.UI.Menu.Open('phone', GetCurrentResourceName(), 'main')
                    hasUsed = true
                    else
				end
            end
        end
	end
end)

--vapen
function CheckWeapon(ped)
  for i=1, #weapons do
    if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
      return true
    end
  end

  return false
end

---- FUNCTIONS ----
function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--notification
function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "katalog",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end