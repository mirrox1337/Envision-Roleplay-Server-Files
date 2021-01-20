
cam = nil

OpenGarage = function()
	local playerCoords = GetEntityCoords(PlayerPedId())
	PlayerData = ESX.GetPlayerData()

	if not ESX.Game.IsSpawnPointClear(Config["locations"]["garage"].spawn, 3.0) then 
		ESX.ShowNotification("Det är ett fordon som blockerar utfarten.")
		return
	end

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end
	RenderScriptCams(1, 1, 750, 1, 1)
	SetCamCoord(cam, Config["locations"]["garage"].cam)
	SetCamActive(cam, true)
	PointCamAtCoord(cam, Config["locations"]["garage"].spawn)

	local elements = {}

    for k,v in ipairs(Config["vehicles"]) do
        table.insert(elements, {
            label = v["label"],
            model = v["model"]
        })
    end
	DeleteAllVehicles()
	ESX.Game.SpawnLocalVehicle('gle450', Config["locations"]["garage"].spawn, Config["locations"]["garage"].heading, function (vehicle)
		local props = ESX.Game.GetVehicleProperties(vehicle)


		 props.plate = 'TAXI'


	    ESX.Game.SetVehicleProperties(vehicle, props)
		table.insert(LastVehicles, vehicle)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded('gle450')

	end)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = "Garagemenyn",
		align    = 'right',
		elements = elements
	}, function(data, menu)
		local data = data["current"]
        DeleteAllVehicles()
        menu.close()
		ESX.Game.SpawnVehicle(data["model"], Config["locations"]["garage"].spawn, Config["locations"]["garage"].heading, function(vehicle)
			table.insert(LastVehicles, vehicle)
			NetworkFadeInEntity(vehicle, true, true)
			SetModelAsNoLongerNeeded(data["model"])
			SetEntityAsMissionEntity(vehicle, true, true)
			SetVehicleNumberPlateText(vehicle, "TAXI")
			menu.close()

			SetCamActive(cam, false)
			RenderScriptCams(0, 1, 750, 1, 0)
		end)
	end, function(data, menu)
		menu.close()
		SetCamActive(cam, false)
		RenderScriptCams(0, 1, 750, 1, 0)
		DeleteAllVehicles()
	end, function(data, menu)
		local data = data["current"]
		DeleteAllVehicles()
		ESX.Game.SpawnLocalVehicle(data["model"], Config["locations"]["garage"].spawn, Config["locations"]["garage"].heading, function(vehicle)
			table.insert(LastVehicles, vehicle)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(data["model"])
		end)
	end
	)
end

RemoveVehicle = function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    DeleteVehicle(vehicle)
end

DeleteAllVehicles = function()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
    end
end

OpenCloakroom = function()
    ESX.UI.Menu.CloseAll()
    local elements = { 
        { ["label"] = "Civilklädsel", ["usage"] = "civilwear" },
    }
    for k,v in ipairs(Config["clothes"]) do
        table.insert(elements, {
            ["label"] = v["label"],
            ["clothe"] = v["clothe"]
        })
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
    {
        ["title"] = "Omklädningsmeny",
        ["align"] = "right",
        ["elements"] = elements
    }, function(data, menu)
        if data["current"]["usage"] == "civilwear" then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
                local playerPed = GetPlayerPed(-1)
                SetPedArmour(playerPed, 0)
                ClearPedBloodDamage(playerPed)
                ResetPedVisibleDamage(playerPed)
                ClearPedLastWeaponDamage(playerPed)
            end)
        else
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin["sex"] == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, data["current"]["clothe"]["male"])
                else
                    TriggerEvent('skinchanger:loadClothes', skin, data["current"]["clothe"]["female"])
                end
                local playerPed = GetPlayerPed(-1)
                SetPedArmour(playerPed, 0) ClearPedBloodDamage(playerPed) ResetPedVisibleDamage(playerPed) ClearPedLastWeaponDamage(playerPed)      
            end)
        end

    end, function(data, menu)
        menu.close()
    end
    )
end

Locations = function(place)
    if place == "garage" then OpenGarage()
    elseif place == "removeVehicle" then RemoveVehicle()
    elseif place == "cloakroom" then OpenCloakroom()
    elseif place == "storage" then OpenStorage()
    elseif place == "boss" then if ESX.PlayerData["job"]["grade_name"] == "boss" then TriggerEvent('esx_society:openBossMenu', 'taxi', function(data, menu) menu.close() end) else
        ESX.ShowNotification(Strings["notboss"]) end
    end
end

DrawAdvancedMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, markerData["a"] or 100, false, true, 2, false, false, false, false)
end

help = function(msg)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

RegisterNetEvent("nxrp-taxi:updateStorage")
AddEventHandler("nxrp-taxi:updateStorage", function()
	if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "storagee") then
		local openedMenu = ESX.UI.Menu.GetOpened("default", GetCurrentResourceName(), "storagee")

		if openedMenu then
			openedMenu.close()
			OpenStorage()
		end
	end
end)


OpenStorage = function()
	ESX.UI.Menu.CloseAll()
    ESX.TriggerServerCallback('nxrp-taxi:getStockItems', function(items, weapons)
		
		local elements = {
			{
				["label"] = "Lägg in",
				["value"] = "additem"
			}
		}

		for i=1, #items, 1 do
			if items[i]["count"] > 0 then
				table.insert(elements, {
					label = items[i]["label"] .. ' - ' .. items[i]["count"] .. 'st',
					type = 'item',
					value = items[i]["name"]
				})
			end
		end

		for i=1, #weapons, 1 do
			if weapons[i]["count"] > 0 then
				table.insert(elements, {
					label = ESX.GetWeaponLabel(weapons[i]["name"]) .. ' - ' .. weapons[i]["count"] .. 'st' ,
					type = 'weapon',
					value = weapons[i]["name"]
				})
			end
		end

		ESX.UI.Menu.Open("default", GetCurrentResourceName(), "storagee", {
			["title"] = "Förrådet",
			["align"] = "right",
			["elements"] = elements
		}, function(data, menu)
			local value = data["current"]["value"]
			if value == 'additem' then
				AddItemToStorage()
			else
				if data["current"]["type"] == 'weapon' then
					ESX.TriggerServerCallback('nxrp-taxi:removeArmoryWeapon', function()
						OpenStorage()
					end, data["current"]["value"])
				elseif data["current"]["type"] == 'item' then
					local itemName = data["current"]["value"]

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_323232323item_count', {
						title ='Hur mycket?'
					}, function(data2, menu2)
						local count = tonumber(data2["value"])
		
						if count == nil then
							ESX.ShowNotification('Ogiltigt nummer...')
						else
							menu2.close()
							menu.close()
							TriggerServerEvent('nxrp-taxi:getStockItem', itemName, count)
		
							Citizen.Wait(300)
							OpenStorage()
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end


		end, function(data, menu)
			menu.close()
		end
		)
	end)
end

AddItemToStorage = function()
	ESX.TriggerServerCallback('nxrp-taxi:getPlayerInventory', function(inventory)
		local elements = {}

		local playerPed  = PlayerPedId()
		local weaponList = ESX.GetWeaponList()
	
		for i=1, #weaponList, 1 do
			local weaponHash = GetHashKey(weaponList[i]["name"])
	
			if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i]["name"] ~= 'WEAPON_UNARMED' then
				table.insert(elements, {
					label = weaponList[i]["label"],
					value = weaponList[i]["name"]
				})
			end
		end

		for i=1, #inventory["items"], 1 do
			local item = inventory["items"][i]

			if item["count"] > 0 then
				table.insert(elements, {
					label = item["label"] .. ' - ' .. item["count"] .. 'st',
					type = 'item_standard',
					value = item["name"]
				})
			end
		end

		ESX.UI.Menu.Open("default", GetCurrentResourceName(), "3232444", {
			["title"] = "Lägg in",
			["align"] = "right",
			["elements"] = elements
		}, function(data, menu)
			if data["current"]["type"] == 'item_standard' then
				local itemName = data["current"]["value"]

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
					title = 'Hur mycket?'
				}, function(data2, menu2)
					local count = tonumber(data2["value"])
	
					if count == nil then
						ESX.ShowNotification('Ogiltigt nummer...')
					else
						menu2.close()
						menu.close()
						ESX.UI.Menu.CloseAll()
						TriggerServerEvent('nxrp-taxi:putStockItems', itemName, count)
						Wait(300)
	
						AddItemToStorage()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			else
				ESX.TriggerServerCallback('nxrp-taxi:addArmoryWeapon', function()
					AddItemToStorage()
				end, data["current"]["value"], true)
			end
		end, function(data, menu)
            menu.close()
			OpenStorage()
		end
		)

	end)
end

local ped = nil

StartNPC = function()
	local player = PlayerPedId()
	InNPC, PickupPed = true, true
	local random = math.random(1, #Config.pedLocations)
	SetNewWaypoint(Config.pedLocations[random].coords)
	if not DoesEntityExist(ped) then
		local randomhash = math.random(1, #Config.peds)
		RequestModel(Config.peds[randomhash].hash)
  
		while not HasModelLoaded(Config.peds[randomhash].hash) do
			Wait(1)
		end
		ped = CreatePed(5, Config.peds[randomhash].hash, Config.pedLocations[random].coords, 90.0, false, false)
		TaskWanderInArea(ped, Config.pedLocations[random].coords, 5.0, 0, 1)
	end
	ESX.ShowNotification("Du har nu fått en <span style='color:yellow'>GPS-position</span> till en passagerare. Åk till den anvigna <span style='color:yellow'>GPS-punkten</span> och hämta upp personen.")
	while true do local sleep = 1000
		while PickupPed do Wait(0)
			if GetDistanceBetweenCoords(GetEntityCoords(player), Config.pedLocations[random].coords, true) <= 130 then
				sleep = 5
				DrawAdvancedMarker({
					["type"] = 0,
					["pos"] = Config.pedLocations[random].coords,
					["r"] = 50,
					["g"] = 250,
					["b"] = 50,
					["sizeX"] = 1.0,
					["sizeY"] = 1.0,
					["sizeZ"] = 1.0,
					["rotate"] = false
				})
				if GetDistanceBetweenCoords(GetEntityCoords(player), Config.pedLocations[random].coords, true) <= 3 then
					help("~INPUT_CONTEXT~ Be personen komma till taxin")
					if IsControlJustReleased(0, 38) then
						if IsPedInAnyVehicle(player, false) then
							local vehicle = GetVehiclePedIsIn(player, false)
							if GetEntityModel(vehicle) == GetHashKey("gle450") then 
								TaskEnterVehicle(ped, vehicle, -1, 2, 1.0, 1, 0)
							else
								ESX.ShowNotification("Du måste ha en taxibil för detta...")
							end
						else
							ESX.ShowNotification("Du måste ha en taxibil för detta...")
						end
					end
					if IsPedInAnyVehicle(ped, false) then
						leavePed(Config.pedLocations[random].coords)
						PickupPed = false
					end
				end
			end
		end

		Wait(sleep)
	end
end

leavePed = function(coords)
	local random = math.random(1, #Config.leavePositions)
	SetNewWaypoint(Config.leavePositions[random].coords)
	ESX.ShowNotification("Åk till den angivna position och lämna av passageraren.")
	while true do local sleep, player = 1000, PlayerPedId()
		if GetDistanceBetweenCoords(GetEntityCoords(player), Config.leavePositions[random].coords) <= 130 then
			sleep = 5
			DrawAdvancedMarker({
				["type"] = 0,
				["pos"] = Config.leavePositions[random].coords,
				["r"] = 50,
				["g"] = 250,
				["b"] = 50,
				["sizeX"] = 1.0,
				["sizeY"] = 1.0,
				["sizeZ"] = 1.0,
				["rotate"] = false
			})
			if GetDistanceBetweenCoords(GetEntityCoords(player), Config.leavePositions[random].coords) <= 3 then
				if IsPedInAnyVehicle(player, false) then
					local vehicle = GetVehiclePedIsIn(player, false)
					if GetEntityModel(vehicle) == GetHashKey("gle450") then 
						TriggerServerEvent("nxrp-taxi:giveReward")
						TaskLeaveAnyVehicle(ped, 0, 0)
						TaskWanderInArea(ped, Config.leavePositions[random].coords, 50.0, 0, 1)
						ped, PickupPed, InNPC = nil, false, false
						Wait(2000)
						StartNPC()
					else
						ESX.ShowNotification("Du måste ha en taxibil för detta...")
					end
				else
					ESX.ShowNotification("Du måste ha en taxibil för detta...")
				end
			end
		end

		Wait(sleep)
	end
end