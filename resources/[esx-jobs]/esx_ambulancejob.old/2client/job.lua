local HasAlreadyEnteredMarker, LastZone, CurrentAction, CurrentActionMsg, CurrentActionData = nil, nil, nil, '', {}
local IsBusy = false
local isCarry 				  = false
ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	if ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	elseif ESX.PlayerData.job.grade_name == 'sub_boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions',
	{
		title		= _U('ambulance'),
		align		= 'right',
		elements	= elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()

		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	end)
end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()


	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
	{
		title		= _U('ems_menu_title'),
		align		= 'right',
		elements	= {
			{label = _U('ems_menu_revive'), value = 'revive'},
			{label = _U('ems_menu_small'), value = 'small'},
			{label = _U('ems_menu_big'), value = 'big'},
			--{label = 'Lyft', value = 'lift'},
			{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
			{label = 'Vårda patient', value = 'treat_patient'},
			{label = 'Fakturera', value = 'bill'},
			
		}
	}, function(data, menu)
		if IsBusy then
			return 
		end
		if data.current.value == 'bill' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent('barbies_faktura:createInvoice')	
		end
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if (closestPlayer == -1 or closestDistance > 1.0 ) and data.current.value ~= 'bill' then
			ESX.ShowNotification(_U('no_players'))
		else
			
			if data.current.value == 'revive' then

				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(closestPlayer)

						if IsPedDeadOrDying(closestPlayerPed, 1) then
							local playerPed = PlayerPedId()

							IsBusy = true
							ESX.ShowNotification(_U('revive_inprogress'))

							local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

							for i=1, 15, 1 do
								Citizen.Wait(900)
						
								ESX.Streaming.RequestAnimDict(lib, function()
									TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
								end)
							end

							TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
							IsBusy = false

							-- Show revive award?
							if Config.ReviveReward > 0 then
								ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
							else
								ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
							end
						else
							ESX.ShowNotification(_U('player_not_unconscious'))
						end
					else
						ESX.ShowNotification(_U('not_enough_medikit'))
					end
				end, 'medikit')

			elseif data.current.value == 'small' then

				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()

							IsBusy = true
							ESX.ShowNotification(_U('heal_inprogress'))
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
							ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
							IsBusy = false
						else
							ESX.ShowNotification(_U('player_not_conscious'))
						end
					else
						ESX.ShowNotification(_U('not_enough_bandage'))
					end
				end, 'bandage')

			elseif data.current.value == 'big' then

				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()

							IsBusy = true
							ESX.ShowNotification(_U('heal_inprogress'))
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
							ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
							IsBusy = false
						else
							ESX.ShowNotification(_U('player_not_conscious'))
						end
					else
						ESX.ShowNotification(_U('not_enough_medikit'))
					end
				end, 'medikit')

			elseif data.current.value == 'put_in_vehicle' then
				TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
			elseif data.current.value == 'lift' then    
				local closestPlayer, distance = ESX.Game.GetClosestPlayer()
	
				if distance ~= -1 and distance <= 3.0 and not IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
					TriggerServerEvent('esx_zeb_tackle:tryTackle', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification('Ingen person i närheten.')
				end
			elseif data.current.value == 'treat_patient' then
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()

							IsBusy = true
							ESX.ShowNotification(_U('heal_inprogress'))
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'treat')
							ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
							IsBusy = false
						else
							ESX.ShowNotification(_U('player_not_conscious'))
						end
					else
						ESX.ShowNotification(_U('not_enough_medikit'))
					end
				end
						
	end, function(data, menu)
		menu.close()
	end)
end


AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(zone)
	if zone == 'Upstairs' then
		Teleport('Upstairs')
	elseif zone == 'Downstairs' then
		Teleport('Downstairs')
	elseif zone == 'Roof' then
		Teleport('Roof')
	elseif zone == 'Office' then
		Teleport('Office')
	elseif zone == 'AmbulanceActions' then
		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	elseif zone == 'VehicleSpawner' then
		CurrentAction		= 'vehicle_spawner_menu'
		CurrentActionMsg	= _U('veh_spawn')
		CurrentActionData	= {}
	elseif zone == 'Pharmacy' then
		CurrentAction		= 'pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local coords	= GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 1.0 then
				CurrentAction		= 'delete_vehicle'
				CurrentActionMsg	= _U('store_veh')
				CurrentActionData	= {vehicle = vehicle}
			end
		end
	end
end)

function FastTravel(pos)
	TeleportFadeEffect(PlayerPedId(), pos)
end

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Blip.Pos.x, Config.Blip.Pos.y, Config.Blip.Pos.z)

	SetBlipSprite(blip, Config.Blip.Sprite)
	SetBlipDisplay(blip, Config.Blip.Display)
	SetBlipScale(blip, Config.Blip.Scale)
	SetBlipColour(blip, Config.Blip.Colour)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('hospital'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				elseif k ~= 'AmbulanceActions' and k ~= 'VehicleSpawner' and k ~= 'VehicleDeleter' and k ~= 'Pharmacy' then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		local coords		= GetEntityCoords(PlayerPedId())
		local isInMarker	= false
		local currentZone	= nil

		for k,v in pairs(Config.Zones) do
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.MarkerSize.x) then
					isInMarker	= true
					currentZone = k
				end
			elseif k ~= 'AmbulanceActions' and k ~= 'VehicleSpawner' and k ~= 'VehicleDeleter' and k ~= 'Pharmacy' then
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.MarkerSize.x) then
					isInMarker	= true
					currentZone = k
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', lastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then

				if CurrentAction == 'ambulance_actions_menu' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'vehicle_spawner_menu' then
					OpenVehicleSpawnerMenu()
				elseif CurrentAction == 'pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'fast_travel_goto_top' or CurrentAction == 'fast_travel_goto_bottom' then
					FastTravel(CurrentActionData.pos)
				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'ambulance', vehicleProps)
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				CurrentAction = nil

			end

		end

		if IsControlJustReleased(0, Keys['F6']) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
			OpenMobileAmbulanceActionsMenu()
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 10.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				local player, distance = ESX.Game.GetClosestPlayer()

				if distance ~= -1 and distance <= 3.0 then
					TaskWarpPedIntoVehicle(player, vehicle, freeSeat)
				else
					ESX.ShowNotification('Ingen i närheten')
				end
			end
		end
	end

end)


function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title		= _U('cloakroom'),
		align		= 'right',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'ambulance_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		end

		menu.close()
		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	end, function(data, menu)
		menu.close()
	end)
end




Teleport = function(pos)
	local elements = {}
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and pos ~= 'Roof' then 
		table.insert(elements, {label = 'Taket', value = 'Roof'})
	end
	if pos == 'Downstairs' then 
		table.insert(elements,
			{label = 'lobby', value = 'Upstairs'}
		)
		table.insert(elements,
			{label = 'Kontor', value = 'Office'}
		)
	elseif pos == 'Upstairs' then
		table.insert(elements,
			{label = 'Operation', value = 'Downstairs'}
		)
		table.insert(elements,
			{label = 'Kontor', value = 'Office'}
		)
	elseif pos == 'Roof' then
		table.insert(elements,
			{label = 'lobby', value = 'Upstairs'}
		)
		table.insert(elements,
			{label = 'Operation', value = 'Downstairs'}
		)
		table.insert(elements,
			{label = 'Kontor', value = 'Office'}
		)
	elseif pos == 'Office' then
		table.insert(elements,
			{label = 'lobby', value = 'Upstairs'}
		)
		table.insert(elements,
			{label = 'Operation', value = 'Downstairs'}
		)
	end 
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'teleport',
		{
			title    = 'Vart vill du?',
			elements = elements
		},
		function(data, menu)
			local destination = data.current.value
			if data.current.value == 'Upstairs' then
				ESX.UI.Menu.CloseAll()
				DoScreenFadeOut(1000)
				Citizen.Wait(1000)
				SetEntityCoords(PlayerPedId(), Config.Zones[destination]['Pos']['x'], Config.Zones[destination]['Pos']['y'], Config.Zones[destination]['Pos']['z'])
				SetEntityHeading(PlayerPedId(), Config.Zones[destination]['Pos']['h'])
				DoScreenFadeIn(1000)
			elseif data.current.value == 'Downstairs' then
				ESX.UI.Menu.CloseAll()
				DoScreenFadeOut(1000)
				Citizen.Wait(1000)
				SetEntityCoords(PlayerPedId(), Config.Zones[destination]['Pos']['x'], Config.Zones[destination]['Pos']['y'], Config.Zones[destination]['Pos']['z'])
				SetEntityHeading(PlayerPedId(), Config.Zones[destination]['Pos']['h'])
				DoScreenFadeIn(1000)
			elseif data.current.value == 'Office' then
				ESX.UI.Menu.CloseAll()
				DoScreenFadeOut(1000)
				Citizen.Wait(1000)
				SetEntityCoords(PlayerPedId(), Config.Zones[destination]['Pos']['x'], Config.Zones[destination]['Pos']['y'], Config.Zones[destination]['Pos']['z'])
				SetEntityHeading(PlayerPedId(), Config.Zones[destination]['Pos']['h'])
				DoScreenFadeIn(1000)
			elseif data.current.value == 'Roof' then
				ESX.UI.Menu.CloseAll()
				local heli = Config.HelicopterSpawner

				if not IsAnyVehicleNearPoint(heli.SpawnPoint.x, heli.SpawnPoint.y, heli.SpawnPoint.z, 3.0) then
					ESX.Game.SpawnVehicle('swift', {
							x = heli.SpawnPoint.x,
							y = heli.SpawnPoint.y,
							z = heli.SpawnPoint.z
					}, heli.Heading, function(vehicle)
							SetVehicleModKit(vehicle, 0)
							SetVehicleLivery(vehicle, 1)
					end)
				end
				DoScreenFadeOut(1000)
				Citizen.Wait(1000)
				SetEntityCoords(PlayerPedId(), Config.Zones[destination]['Pos']['x'], Config.Zones[destination]['Pos']['y'], Config.Zones[destination]['Pos']['z'])
				SetEntityHeading(PlayerPedId(), Config.Zones[destination]['Pos']['h'])
				DoScreenFadeIn(1000)
			end
		end,
		function(data, menu)
				menu.close()
		end
	)
end

function OpenVehicleSpawnerMenu()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
			for i=1, #vehicles, 1 do
				table.insert(elements, {
					label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
					value = vehicles[i]
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title		= _U('veh_menu'),
				align		= 'right',
				elements = elements
			}, function(data, menu)
				menu.close()

				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 230.0, function(vehicle)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					SetVehicleFuelLevel(vehicle, 100 + 0.0)
					DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
				end)
				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ambulance', vehicleProps)
			end, function(data, menu)
				menu.close()
				CurrentAction		= 'vehicle_spawner_menu'
				CurrentActionMsg	= _U('veh_spawn')
				CurrentActionData	= {}
			end)
		end, 'ambulance')

	else -- not society vehicles

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title		= _U('veh_menu'),
			align		= 'right',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			menu.close()

			ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, 230.0, function(vehicle)
				local playerPed = PlayerPedId()
				--TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				SetVehicleFuelLevel(vehicle, 100 + 0.0)
				DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
			end)
		end, function(data, menu)
			menu.close()
			CurrentAction		= 'vehicle_spawner_menu'
			CurrentActionMsg	= _U('veh_spawn')
			CurrentActionData	= {}
		end)

	end
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy',
	{
		title		= _U('pharmacy_menu_title'),
		align		= 'right',
		elements = {
			{label = ('Medicinlåda'), value = 'medikit'},
			{label = ('Bandage'), value = 'bandage'},
			{label = ('Citodon'), value = 'vicodin'},
			{label = ('Oxycontin'), value = 'hydrocodone'},
			{label = ('Morfin'), value = 'morphine'},

		}
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
	end, function(data, menu)
		menu.close()

		CurrentAction		= 'pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	end)
end

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle({
		x = coords.x,
		y = coords.y,
		z = coords.z
	})

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
		local freeSeat = nil

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat ~= nil then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
		TriggerEvent('mythic_hospital:client:RemoveBleed', playerPed)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
		TriggerEvent('mythic_hospital:client:RemoveBleed', playerPed)
		TriggerEvent('mythic_hospital:client:FieldTreatLimbs', playerPed)
	elseif healType == 'treat' then
		SetEntityHealth(playerPed, maxHealth)
		TriggerEvent('mythic_hospital:client:RemoveBleed', playerPed)
		TriggerEvent('mythic_hospital:client:ResetLimbs', playerPed)

	end

	ESX.ShowNotification(_U('healed'))
end)

RegisterNetEvent('esx_ambulancejob:spawnWheelchair')
AddEventHandler('esx_ambulancejob:spawnWheelchair', function()
	LoadModel('prop_wheelchair_01')

	local wheelchair = CreateObject(GetHashKey('prop_wheelchair_01'), GetEntityCoords(PlayerPedId()), true)
end)

RegisterNetEvent('esx_ambulancejob:deleteWheelchair')
AddEventHandler('esx_ambulancejob:deleteWheelchair', function()
	local wheelchair = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey('prop_wheelchair_01'))

	if DoesEntityExist(wheelchair) then
		DeleteEntity(wheelchair)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_wheelchair_01"), false)

		if DoesEntityExist(closestObject) then
			sleep = 5

			local wheelChairCoords = GetEntityCoords(closestObject)
			local wheelChairForward = GetEntityForwardVector(closestObject)
			
			local sitCoords = (wheelChairCoords + wheelChairForward * - 0.5)
			local pickupCoords = (wheelChairCoords + wheelChairForward * 0.3)

			if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 1.0 then
				DrawText3Ds(sitCoords, "[E] Sit", 0.4)

				if IsControlJustPressed(0, 38) then
					Sit(closestObject)
				end
			end

			if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 1.0 then
				DrawText3Ds(pickupCoords, "[E] Pick up", 0.4)

				if IsControlJustPressed(0, 38) then
					PickUp(closestObject)
				end
			end
		end

		Citizen.Wait(sleep)
	end
end)

Sit = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			ShowNotification("Somebody is already using the wheelchair!")
			return
		end
	end

	LoadAnim("missfinale_c2leadinoutfin_c_int")

	AttachEntityToEntity(PlayerPedId(), wheelchairObject, 0, 0, 0.0, 0.4, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(wheelchairObject)

	while IsEntityAttachedToEntity(PlayerPedId(), wheelchairObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(PlayerPedId(), true, true)
		end

		if not IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			TaskPlayAnim(PlayerPedId(), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 8.0, 8.0, -1, 69, 1, false, false, false)
		end

		if IsControlPressed(0, 32) then
			local x, y, z  = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * -0.02)
			SetEntityCoords(wheelchairObject, x,y,z)
			PlaceObjectOnGroundProperly(wheelchairObject)
		end

		if IsControlPressed(1,  34) then
			heading = heading + 0.4

			if heading > 360 then
				heading = 0
			end

			SetEntityHeading(wheelchairObject,  heading)
		end

		if IsControlPressed(1,  9) then
			heading = heading - 0.4

			if heading < 0 then
				heading = 360
			end

			SetEntityHeading(wheelchairObject,  heading)
		end

		if IsControlJustPressed(0, 73) then
			DetachEntity(PlayerPedId(), true, true)

			local x, y, z = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * - 0.7)

			SetEntityCoords(PlayerPedId(), x,y,z)
		end
	end
end

PickUp = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
			ShowNotification("Somebody is already driving the wheelchair!")
			return
		end
	end

	NetworkRequestControlOfEntity(wheelchairObject)

	LoadAnim("anim@heists@box_carry@")

	AttachEntityToEntity(wheelchairObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.00, -0.3, -0.73, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

	while IsEntityAttachedToEntity(wheelchairObject, PlayerPedId()) do
		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(wheelchairObject, true, true)
		end

		if IsControlJustPressed(0, 73) then
			DetachEntity(wheelchairObject, true, true)
		end
	end
end

DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 370

	DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 41, 11, 41, 100)
end

GetPlayers = function()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

GetClosestPlayer = function()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

LoadAnim = function(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		
		Citizen.Wait(1)
	end
end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		
		Citizen.Wait(1)
	end
end

ShowNotification = function(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end