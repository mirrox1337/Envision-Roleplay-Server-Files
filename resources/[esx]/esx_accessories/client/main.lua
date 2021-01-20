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

ESX								= nil
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}
local isDead					= false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenAccessoryMenu()
	local playerPed = GetPlayerPed(-1)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory',
	{
		title = 'Accessoarer',
		align = 'right',
		elements = {
			{label = 'Hjälm / Hatt', value = 'Helmet'},
			{label = 'Örontillbehör', value = 'Ears'},
			{label = 'Mask', value = 'Mask'},
			{label = 'Glasögon', value = 'Glasses'}
		}
	}, function(data, menu)
		Anim(data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then

			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == "mask" then
					mAccessory = 0
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		end

	end, accessory)
end

function Anim(accessory)
	local playerPed = GetPlayerPed(-1)
	local _accessory = string.lower(accessory)

	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		if hasAccessory then
			if accessory == 'Helmet' then
				TriggerEvent('skinchanger:getSkin', function(skin)
					local mAccessory = -1
					local _accessory = string.lower('helmet')

					if skin[_accessory .. '_1'] == mAccessory then
						ESX.Streaming.RequestAnimDict('missheistdockssetup1hardhat@', function()
							TaskPlayAnim(playerPed, 'missheistdockssetup1hardhat@', 'put_on_hat', 8.0, -8, -1, 49, 0, 0, 0, 0)
							Citizen.Wait(2000)
						end)
						ClearPedSecondaryTask(playerPed)
						SetUnsetAccessory('Helmet')
					else
						ESX.Streaming.RequestAnimDict('veh@bike@common@front@base', function()
							TaskPlayAnim(playerPed, 'veh@bike@common@front@base', 'take_off_helmet_stand', 8.0, -8, -1, 49, 0, 0, 0, 0)
							Citizen.Wait(1400)
						end)
						ClearPedSecondaryTask(playerPed)
						SetUnsetAccessory('Helmet')
					end
				end)
			end

			if accessory == 'Mask' then
				TriggerEvent('skinchanger:getSkin', function(skin)
					local mAccessory = 0
					local _accessory = string.lower('mask')

					if skin[_accessory .. '_1'] == mAccessory then
						ESX.Streaming.RequestAnimDict('mp_masks@on_foot', function()
							TaskPlayAnim(playerPed, 'mp_masks@on_foot', 'put_on_mask', 8.0, -8, -1, 49, 0, 0, 0, 0)
							Citizen.Wait(500)
						end)
						ClearPedSecondaryTask(playerPed)
						SetUnsetAccessory('Mask')
					else
						ESX.Streaming.RequestAnimDict('misscommon@std_take_off_masks', function()
							TaskPlayAnim(playerPed, 'misscommon@std_take_off_masks', 'take_off_mask_ps', 8.0, -8, -1, 49, 0, 0, 0, 0)
							Citizen.Wait(1400)
						end)
						ClearPedSecondaryTask(playerPed)
						SetUnsetAccessory('Mask')
					end
				end)
			end

			if accessory == 'Glasses' then
				TriggerEvent('skinchanger:getSkin', function(skin)
					local mAccessory = -1
					local _accessory = string.lower('glasses')

					if skin[_accessory .. '_1'] == mAccessory then
						ESX.Streaming.RequestAnimDict('mp_masks@on_foot', function()
							TaskPlayAnim(playerPed, 'mp_masks@on_foot', 'put_on_mask', 8.0, -8, 800, 49, 0, 0, 0, 0)
							Citizen.Wait(700)
							SetUnsetAccessory('Glasses')
						end)
						ClearPedSecondaryTask(playerPed)
					else
						ESX.Streaming.RequestAnimDict('mp_masks@on_foot', function()
							TaskPlayAnim(playerPed, 'mp_masks@on_foot', 'put_on_mask', 8.0, -8, 800, 49, 0, 0, 0, 0)
							Citizen.Wait(700)
						end)
						ClearPedSecondaryTask(playerPed)
						SetUnsetAccessory('Glasses')
					end
				end)
			end

			if accessory == 'Ears' then
				ESX.Streaming.RequestAnimDict('mp_masks@on_foot', function()
					TaskPlayAnim(playerPed, 'mp_masks@on_foot', 'put_on_mask', 8.0, -8, -1, 49, 0, 0, 0, 0)
					Citizen.Wait(900)
				end)
				ClearPedSecondaryTask(playerPed)
				SetUnsetAccessory('Ears')
			end
		else
			ESX.ShowNotification(_U('no_' .. _accessory))
		end
	end, accessory)
end

function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local restrict = {}

	restrict = { _accessory .. '_1', _accessory .. '_2' }
	
	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
		{
			title = _U('valid_purchase'),
			align = 'right',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes', ESX.Math.GroupDigits(Config.Price)), value = 'yes'}
			}
		}, function(data, menu)
			menu.close()
			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('esx_accessories:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerServerEvent('esx_accessories:pay')
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_accessories:save', skin, accessory)
						end)
					else
						TriggerEvent('esx_skin:getLastSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end)
			end

			if data.current.value == 'no' then
				local player = PlayerPedId()
				TriggerEvent('esx_skin:getLastSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				if accessory == "Ears" then
					ClearPedProp(player, 2)
				elseif accessory == "Mask" then
					SetPedComponentVariation(player, 1, 0 ,0, 2)
				elseif accessory == "Helmet" then
					ClearPedProp(player, 0)
				elseif accessory == "Glasses" then
					SetPedPropIndex(player, 1, -1, 0, 0)
				end
			end
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}

		end)
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end, restrict)
end

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('esx_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips --
Citizen.CreateThread(function()
	for k,v in pairs(Config.ShopsBlips) do
		if v.Pos ~= nil then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

				SetBlipSprite (blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 0.6)
				SetBlipColour (blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('shop', _U(string.lower(k))))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 10) then
					DrawScriptMarker({
						["type"] = 6,
						["posx"] = v.Pos[i].x,
						["posy"] = v.Pos[i].y,
						["posz"] = v.Pos[i].z,
						["r"] = 0,
						["g"] = 255,
						["b"] = 150
					})
				end
			end
		end
	end
end)

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["posx"], markerData["posy"], markerData["posz"], 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, true, 2, false, false, false, false)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x then
					isInMarker  = true
					currentZone = k
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('esx_accessories:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_accessories:hasExitedMarker', LastZone)
		end

	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and CurrentActionData.accessory then
				OpenShopMenu(CurrentActionData.accessory)
				CurrentAction = nil
			end
		elseif CurrentAction == nil and not Config.EnableControls then
			Citizen.Wait(500)
		end

	end
end)

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 255)
	SetTextOutline()
  
	AddTextComponentString(text)
	DrawText(_x, _y)
  
	local factor = (string.len(text)) / 270
	DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
  end

RegisterNetEvent('esx_accessories')
AddEventHandler('esx_accessories', function()
	OpenAccessoryMenu()
end)

RegisterNetEvent('esx_accessoriesshop')
AddEventHandler('esx_accessoriesshop', function()
	OpenShopMenu(CurrentActionData.accessory)
end)