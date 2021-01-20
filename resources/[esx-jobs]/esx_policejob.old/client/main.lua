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
  
  local PlayerData              = {}
  local HasAlreadyEnteredMarker = false
  local LastStation             = nil
  local LastPart                = nil
  local LastPartNum             = nil
  local LastEntity              = nil
  local CurrentAction           = nil
  local CurrentActionMsg        = ''
  local CurrentActionData       = {}
  local DragStatus              = {}
  DragStatus.IsDragged          = false
  local hasAlreadyJoined        = false
  local blipsCops               = {}
  local isDead                  = false
  local CurrentTask             = {}
  local playerInService         = false
  local isCarry                 = false
  local copcars = {
		2046537925, -- police1
		-1627000575, --police2
		1912215274, --police3
		-1973172295, --police4
		-34623805, --policeb
		-1536924937, --policeold1
		-1779120616, --policeold2
		456714581, --policet
		353883353, --polmav
		1127131465, --fbi
		-1647941228, --fbi2
		-1205689942, --riot
		-1683328900, --sheriff
		1922257928, --sheriff2
		2620582743, --police5
		-1291872016, --police6(2)
		3003095280, --police6
		3816323553, --police9
  
  }
  local isCopcar = false
  local spawnedVehicles, isInShopMenu = {}, false
  ESX                           = nil
  
  Citizen.CreateThread(function()
	  while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(0)
	  end
  
	  while ESX.GetPlayerData().job == nil do
		  Citizen.Wait(10)
	  end
  
	  PlayerData = ESX.GetPlayerData()
  end)
  
  function SetVehicleMaxMods(vehicle)
	  local props = {
		  modEngine       = 3,
		  modBrakes       = 2,
		  modTransmission = 3,
		  modSuspension   = 3,
		  modTurbo        = true
	  }
  
	  ESX.Game.SetVehicleProperties(vehicle, props)
  end
  
  function cleanPlayer(playerPed)
	  SetPedArmour(playerPed, 0)
	  ClearPedBloodDamage(playerPed)
	  ResetPedVisibleDamage(playerPed)
	  ClearPedLastWeaponDamage(playerPed)
	  ResetPedMovementClipset(playerPed, 0)
  end
  
  function setUniform(job, playerPed)
	  TriggerEvent('skinchanger:getSkin', function(skin)
		  if skin.sex == 0 then
			  if Config.Uniforms[job].male ~= nil then
				  TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			  else
				  --ESX.ShowNotification(_U('no_outfit'))
				  exports['mythic_notify']:SendAlert('inform', _U('no_outfit'))
			  end
  
			  if job == 'bullet_wear' or job == 'gilet_wear' then
				  SetPedArmour(playerPed, 100)
			  end
		  else
			  if Config.Uniforms[job].female ~= nil then
				  TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			  else
				  --ESX.ShowNotification(_U('no_outfit'))
				  exports['mythic_notify']:SendAlert('inform', _U('no_outfit'))
			  end
  
			  if job == 'bullet_wear' or job == 'gilet_wear' then
				  SetPedArmour(playerPed, 100)
			  end
		  end
	  end)
  end
  
  function OpenCloakroomMenu()
  
	  local playerPed = PlayerPedId()
	  local grade = PlayerData.job.grade_name
  
	  local elements = {
		  { label = _U('citizen_wear'), value = 'citizen_wear' },
		  { label = _U('bullet_wear'), value = 'bullet_wear' },
		  { label = _U('gilet_wear'), value = 'gilet_wear' },
		  { label = _U('trainee_wear'), value = 'trainee_wear' }
	  }
  
	  if grade == 'recruit' then
		  table.insert(elements, {label = _U('police_wear'), value = 'recruit_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'recruit_wear2'})
	  elseif grade == 'officer' then
		  table.insert(elements, {label = _U('police_wear'), value = 'officer_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'officer_wear2'})
	  elseif grade == 'officer2' then
		  table.insert(elements, {label = _U('police_wear'), value = 'officer_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'officer_wear2'})
	  elseif grade == 'officer3' then
		  table.insert(elements, {label = _U('police_wear'), value = 'officer_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'officer_wear2'})
	  elseif grade == 'officer4' then
		  table.insert(elements, {label = _U('police_wear'), value = 'officer_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'officer_wear2'})
	  elseif grade == 'sergeant' then
		  table.insert(elements, {label = _U('police_wear'), value = 'sergeant_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'sergeant_wear2'})
	  elseif grade == 'intendent' then
		  table.insert(elements, {label = _U('police_wear'), value = 'intendent_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'intendent_wear2'})
	  elseif grade == 'lieutenant' then
		  table.insert(elements, {label = _U('police_wear'), value = 'lieutenant_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'lieutenant_wear2'})
	  elseif grade == 'chef' then
		  table.insert(elements, {label = _U('police_wear'), value = 'chef_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'chef_wear2'})
	  elseif grade == 'boss' then
		  table.insert(elements, {label = _U('police_wear'), value = 'boss_wear'})
		  table.insert(elements, {label = 'Uniform 2', value = 'boss_wear2'})
	  end
  
	  if Config.EnableNonFreemodePeds then
		  table.insert(elements, {label = 'Sheriff wear', value = 'freemode_ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'})
		  table.insert(elements, {label = 'Police wear', value = 'freemode_ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'})
		  table.insert(elements, {label = 'Swat wear', value = 'freemode_ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'})
	  end
  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	  {
		  title    = _U('cloakroom'),
		  align    = 'right',
		  elements = elements
	  }, function(data, menu)
  
		  cleanPlayer(playerPed)
  
		  if data.current.value == 'citizen_wear' then
			  
			  if Config.EnableNonFreemodePeds then
				  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					  local isMale = skin.sex == 0
  
					  TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							  TriggerEvent('skinchanger:loadSkin', skin)
							  TriggerEvent('esx:restoreLoadout')
						  end)
					  end)
  
				  end)
			  else
				  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					  TriggerEvent('skinchanger:loadSkin', skin)
				  end)
			  end
  
			  if Config.MaxInService ~= -1 then
  
				  ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					  if isInService then
  
						  playerInService = false
  
						  local notification = {
							  title    = _U('service_anonunce'),
							  subject  = '',
							  msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							  iconType = 1
						  }
  
						  TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')
  
						  TriggerServerEvent('esx_service:disableService', 'police')
						  TriggerEvent('esx_policejob:updateBlip')
						  --ESX.ShowNotification(_U('service_out'))
						  exports['mythic_notify']:SendAlert('inform', _U('service_out'))
					  end
				  end, 'police')
			  end
  
		  end
  
		  if Config.MaxInService ~= -1 and data.current.value ~= 'citizen_wear' then
			  local serviceOk = 'waiting'
  
			  ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				  if not isInService then
  
					  ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						  if not canTakeService then
							  --ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
							  exports['mythic_notify']:SendAlert('error', _U('service_max', inServiceCount, maxInService))
						  else
  
							  serviceOk = true
							  playerInService = true
  
							  local notification = {
								  title    = _U('service_anonunce'),
								  subject  = '',
								  msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
								  iconType = 1
							  }
	  
							  TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')
							  TriggerEvent('esx_policejob:updateBlip')
							  --ESX.ShowNotification(_U('service_in'))
							  exports['mythic_notify']:SendAlert('inform', _U('service_in'))
						  end
					  end, 'police')
  
				  else
					  serviceOk = true
				  end
			  end, 'police')
  
			  while type(serviceOk) == 'string' do
				  Citizen.Wait(5)
			  end
  
			  -- if we couldn't enter service don't let the player get changed
			  if not serviceOk then
				  return
			  end
		  end
  
		  if
			  data.current.value == 'recruit_wear' or
			  data.current.value == 'officer_wear' or
			  data.current.value == 'sergeant_wear' or
			  data.current.value == 'intendent_wear' or
			  data.current.value == 'lieutenant_wear' or
			  data.current.value == 'chef_wear' or
			  data.current.value == 'boss_wear' or
			  data.current.value == 'bullet_wear' or
			  data.current.value == 'gilet_wear' or
			  data.current.value == 'trainee_wear' or
			  data.current.value == 'recruit_wear2' or
			  data.current.value == 'officer_wear2' or
			  data.current.value == 'sergeant_wear2' or
			  data.current.value == 'intendent_wear2' or
			  data.current.value == 'lieutenant_wear2' or
			  data.current.value == 'chef_wear2' or
			  data.current.value == 'boss_wear2'
		  then
			  setUniform(data.current.value, playerPed)
		  end
  
		  if data.current.value == 'freemode_ped' then
			  local modelHash = ''
  
			  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				  if skin.sex == 0 then
					  modelHash = GetHashKey(data.current.maleModel)
				  else
					  modelHash = GetHashKey(data.current.femaleModel)
				  end
  
				  ESX.Streaming.RequestModel(modelHash, function()
					  SetPlayerModel(PlayerId(), modelHash)
					  SetModelAsNoLongerNeeded(modelHash)
  
					  TriggerEvent('esx:restoreLoadout')
				  end)
			  end)
  
		  end
  
  
  
	  end, function(data, menu)
		  menu.close()
  
		  CurrentAction     = 'menu_cloakroom'
		  CurrentActionMsg  = _U('open_cloackroom')
		  CurrentActionData = {}
	  end)
  end
  
  function OpenArmoryMenu(station)
  
	  if Config.EnableArmoryManagement then
  
		  local elements = {
			  {label = _U('get_weapon'),      value = 'get_weapon'},
			  {label = _U('put_weapon'),      value = 'put_weapon'},
			  {label = _U('remove_object'),   value = 'get_stock'},
			  {label = _U('deposit_object'),  value = 'put_stock'},
			  {label = _U('Ta ut nyckelkort'),    value = 'get_key'},
			  {label = 'Lämna in nyckelkort', value = 'put_key'}
		  }
  
		  if PlayerData.job.grade_name == 'boss' then
			  table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
		  end
  
		  ESX.UI.Menu.CloseAll()
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
		  {
			  title    = _U('armory'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
  
			  if data.current.value == 'get_weapon' then
				  OpenGetWeaponMenu()
			  elseif data.current.value == 'put_weapon' then
				  OpenPutWeaponMenu()
			  elseif data.current.value == 'put_stock' then
				  OpenPutStocksMenu()
			  elseif data.current.value == 'get_stock' then
				  OpenGetStocksMenu()
			  elseif data.current.value == 'get_key' then
				  TriggerServerEvent('esx_policejob:getKey')
			  elseif data.current.value == 'put_key' then
				  TriggerServerEvent('esx_policejob:putKey')
			  elseif data.current.value == 'buy_weapons' then
				  OpenBuyWeaponsMenu(station)
			  end
  
		  end, function(data, menu)
			  menu.close()
  
			  CurrentAction     = 'menu_armory'
			  CurrentActionMsg  = _U('open_armory')
			  CurrentActionData = {station = station}
		  end)
  
	  else
  
		  local elements = {}
  
		  for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do
			  local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
			  table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
		  end
  
		  ESX.UI.Menu.CloseAll()
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
		  {
			  title    = _U('armory'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
			  local weapon = data.current.value
			  TriggerServerEvent('esx_policejob:giveWeapon', weapon, 1000)
		  end, function(data, menu)
			  menu.close()
  
			  CurrentAction     = 'menu_armory'
			  CurrentActionMsg  = _U('open_armory')
			  CurrentActionData = {station = station}
		  end)
  
	  end
  
  end
  
  function OpenArmoryMenu(station)
	  local elements = {
		  {label = _U('buy_weapons'), value = 'buy_weapons'}
	  }
  
	  if Config.EnableArmoryManagement then
		  table.insert(elements, {label = _U('get_weapon'),     value = 'get_weapon'})
		  table.insert(elements, {label = _U('put_weapon'),     value = 'put_weapon'})
		  table.insert(elements, {label = _U('remove_object'),  value = 'get_stock'})
		  table.insert(elements, {label = _U('deposit_object'), value = 'put_stock'})
	  end
  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
	  {
		  title    = _U('armory'),
		  align    = 'right',
		  elements = elements
	  }, function(data, menu)
  
		  if data.current.value == 'get_weapon' then
			  OpenGetWeaponMenu()
		  elseif data.current.value == 'put_weapon' then
			  OpenPutWeaponMenu()
		  elseif data.current.value == 'buy_weapons' then
			  OpenBuyWeaponsMenu()
		  elseif data.current.value == 'put_stock' then
			  OpenPutStocksMenu()
		  elseif data.current.value == 'get_stock' then
			  OpenGetStocksMenu()
		  end
  
	  end, function(data, menu)
		  menu.close()
  
		  CurrentAction     = 'menu_armory'
		  CurrentActionMsg  = _U('open_armory')
		  CurrentActionData = {station = station}
	  end)
  end
  
  function OpenVehicleSpawnerMenu(station, partNum)
  
	  ESX.UI.Menu.CloseAll()
  
	  if Config.EnableSocietyOwnedVehicles then
  
		  local elements = {}
  
		  ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(garageVehicles)
  
			  for i=1, #garageVehicles, 1 do
				  table.insert(elements, {
					  label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']',
					  value = garageVehicles[i]
				  })
			  end
  
			  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			  {
				  title    = _U('vehicle_menu'),
				  align    = 'right',
				  elements = elements
			  }, function(data, menu)
				  menu.close()
  
				  local vehicleProps = data.current.value
				  local foundSpawnPoint, spawnPoint = GetAvailableVehicleSpawnPoint(station, partNum)
  
				  if foundSpawnPoint then
					  ESX.Game.SpawnVehicle(vehicleProps.model, spawnPoint, spawnPoint.heading, function(vehicle)
						  ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
						  --TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
						  SetVehicleFuelLevel(vehicle, 100 + 0.0)
						  DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
					  end)
  
					  TriggerServerEvent('esx_society:removeVehicleFromGarage', 'police', vehicleProps)
				  end
			  end, function(data, menu)
				  menu.close()
  
				  CurrentAction     = 'menu_vehicle_spawner'
				  CurrentActionMsg  = _U('vehicle_spawner')
				  CurrentActionData = {station = station, partNum = partNum}
			  end)
  
		  end, 'police')
  
	  else
  
		  local elements = {}
  
		  local sharedVehicles = Config.AuthorizedVehicles.Shared
		  for i=1, #sharedVehicles, 1 do
			  table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
		  end
  
		  local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]
		  for i=1, #authorizedVehicles, 1 do
			  table.insert(elements, { label = authorizedVehicles[i].label, model = authorizedVehicles[i].model})
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		  {
			  title    = _U('vehicle_menu'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
			  menu.close()
  
			  local foundSpawnPoint, spawnPoint = GetAvailableVehicleSpawnPoint(station, partNum)
  
			  if foundSpawnPoint then
				  if Config.MaxInService == -1 then
					  ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
  
						  local props = ESX.Game.GetVehicleProperties(vehicle)
  
  
						   props.plate = 'POLIS'
		  
		  
						  ESX.Game.SetVehicleProperties(vehicle, props)
						  local reg = GetVehicleNumberPlateText(vehicle)
						  TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
						  SetVehicleMaxMods(vehicle)
						  TriggerServerEvent("LegacyFuel:UpdateServerFuelTable", reg, 100)
						  SetVehicleFuelLevel(vehicle, 100 + 0.0)
						  DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
					  end)
				  end
			  end
  
		  end, function(data, menu)
			  menu.close()
  
			  CurrentAction     = 'menu_vehicle_spawner'
			  CurrentActionMsg  = _U('vehicle_spawner')
			  CurrentActionData = {station = station, partNum = partNum}
		  end)
  
	  end
  end
  
  function GetAvailableVehicleSpawnPoint(station, partNum)
	  local spawnPoints = Config.PoliceStations[station].Vehicles[partNum].SpawnPoints
	  local found, foundSpawnPoint = false, nil
  
	  for i=1, #spawnPoints, 1 do
		  if ESX.Game.IsSpawnPointClear(spawnPoints[i], spawnPoints[i].radius) then
			  found, foundSpawnPoint = true, spawnPoints[i]
			  break
		  end
	  end
  
	  if found then
		  return true, foundSpawnPoint
	  else
		  --ESX.ShowNotification(_U('vehicle_blocked'))
		  exports['mythic_notify']:SendAlert('error', _U('vehicle_blocked'))
		  return false
	  end
  end
  
  function OpenPoliceActionsMenu()
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions',
	  {
		  title    = 'Polisen',
		  align    = 'right',
		  elements = {
			  {label = _U('citizen_interaction'),	value = 'citizen_interaction'},
			  {label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
			  --{label = _U('object_spawner'),		value = 'object_spawner'},
			  --{label = 'Västar',		            value = 'vestmenu'},
			  --{label = 'Ta bort objekt',		    value = 'remove_object'},
			  {label = 'Fängelsemeny',		    value = 'jail_menu'}
		  }
	  }, function(data, menu)
  
		  if data.current.value == 'vestmenu' then
			  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vests',
			  {
				  title    = 'Västar av/på',
				  align    = 'right',
				  elements = {
					  {label = 'Ta av väst',              value = 'takeoff'},
					  {label = 'Sätt på skottsäker väst', value = 'skotton'},
					  {label = 'Sätt på reflex väst',	    value = 'reflexon'},
				  }
			  }, function(data2, menu2)
  
				  if data2.current.value == 'takeoff' then
					  TriggerEvent('skinchanger:getSkin', function(skin)
						  local clothesSkin = {
							  ['bproof_1'] = 0, ['bproof_2'] = 0,
						  }
	  
						  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					  end)
  
					  SetPedArmour(PlayerPedId(), 0)
					  
				  elseif data2.current.value == 'skotton' then
					  TriggerEvent('skinchanger:getSkin', function(skin)
						  if skin.sex == 0 then
							  local clothesSkin = {
								  ['bproof_1'] = 15, ['bproof_2'] = 1,
							  }
	  
							  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						  else
							  local clothesSkin = {
								  ['bproof_1'] = 17, ['bproof_2'] = 1,
							  }
	  
							  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						  end
					  end)
  
					  SetPedArmour(PlayerPedId(), 100)
  
				  elseif data2.current.value == 'reflexon' then
					  TriggerEvent('skinchanger:getSkin', function(skin)
						  if skin.sex == 0 then
							  local clothesSkin = {
								  ['bproof_1'] = 15, ['bproof_2'] = 2,
							  }
	  
							  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						  else
							  local clothesSkin = {
								  ['bproof_1'] = 17, ['bproof_2'] = 2,
							  }
	  
							  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						  end
					  end)
  
					  SetPedArmour(PlayerPedId(), 0)
				  end
			  end, function(data2, menu2)
				  menu2.close()
			  end)
		  end
  
		  if data.current.value == 'remove_object' then
			  local closestObject, closestDistance = ESX.Game.GetClosestObject()
			  if closestDistance <= 3.0 then
				  DeleteObject(closestObject)
			  else
				  ESX.ShowNotification('Det finns inget objekt i närheten som kan tas bort.')
			  end
		  end
  
		  if data.current.value == 'jail_menu' then
			  TriggerEvent("esx-qalle-jail:openJailMenu")
		  end
  
		  if data.current.value == 'citizen_interaction' then
			  local elements = {
				  {label = _U('id_card'),			value = 'identity_card'},
				  {label = _U('search'),			value = 'body_search'},
				  {label = _U('handcuff'),		value = 'handcuff'},
				  --{label = _U('unhandcuff'),		value = 'unhandcuff'},
				  {label = _U('drag'),			value = 'drag'},
				  {label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
				  {label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
				  {label = _U('lyft'),			value = 'lyft'},
				  {label = _U('fine'),			value = 'fine'},
				  {label = _U('license_check'),   value = 'license'},
				  {label = _U('brottsregister'),	value = 'brottsregister'},
				  {label = _U('ta_dna'),	value = 'dna'},
				  {label = _U('ta_krut'),	value = 'krut'},
				  {label = _U('unpaid_bills'),	value = 'unpaid_bills'}
			  }
		  
			  ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'citizen_interaction',
			  {
				  title    = _U('citizen_interaction'),
				  align    = 'right',
				  elements = elements
			  }, function(data2, menu2)
				  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				  if closestPlayer ~= -1 and closestDistance <= 3.0 then
					  local action = data2.current.value
  
					  if action == 'identity_card' then
						  OpenIdentityCardMenu(closestPlayer)
					  elseif action == 'body_search' then
						  TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
						  OpenBodySearchMenu(closestPlayer)
					  --[[elseif action == 'handcuff' then
						  TriggerEvent('esx_handcuffs:cuffcheck', source, source)
					  elseif action == 'unhandcuff' then
						  TriggerEvent('esx_handcuffs:cuffcheck', source, source)]]
					  elseif action == 'handcuff' then
						  TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
					  elseif action == 'drag' then
						  TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
					  elseif action == 'put_in_vehicle' then
						  TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
					  elseif action == 'out_the_vehicle' then
						  TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					  elseif action == 'fine' then
						  OpenFineMenu(closestPlayer)
					  elseif action == 'brottsregister' then
						  OpenCriminalRecords(closestPlayer)
					  elseif action == 'dna' then
						  TriggerEvent('jsfour-dna:get', closestPlayer)
					  elseif action == 'krut' then
						  TriggerEvent('esx_guntest:checkGun', source)
						  sendNotification('Letar efter krutstänk!', 'success', 10000)
					  elseif action == 'license' then
						  ShowPlayerLicense(closestPlayer)
					  elseif action == 'unpaid_bills' then
						  OpenUnpaidBillsMenu(closestPlayer)
					  elseif action == 'lyft' then
						  LyftPlayer(closestPlayer)
					  end
  
				  else
					  ESX.ShowNotification(_U('no_players_nearby'))
				  end
			  end, function(data2, menu2)
				  menu2.close()
			  end)
  
		  elseif data.current.value == 'vehicle_interaction' then
  
			  local elements  = {}
			  local playerPed = PlayerPedId()
			  local coords    = GetEntityCoords(playerPed)
			  local vehicle   = ESX.Game.GetVehicleInDirection()
			  
			  if DoesEntityExist(vehicle) then
				  --table.insert(elements, {label = 'Böter',	value = 'fine_car'})
				  --table.insert(elements, {label = _U('lockNunlock'),	value = 'lockNunlock'})
				  --table.insert(elements, {label = _U('vehicle_info'),	value = 'vehicle_infos'})
				  table.insert(elements, {label = 'Fordonsuppgifter',	value = 'vehicle_infos'})
				  table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
				  --table.insert(elements, {label = _U('impound'),		value = 'impound'})
				  --table.insert(elements, {label = _U('Ta DNA'),		    value = 'dna'})
			  end
			  
			  --table.insert(elements, {label = _U('search_database'), value = 'search_database'})
  
			  ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'vehicle_interaction',
			  {
				  title    = _U('vehicle_interaction'),
				  align    = 'right',
				  elements = elements
			  }, function(data2, menu2)
				  coords  = GetEntityCoords(playerPed)
				  vehicle = ESX.Game.GetVehicleInDirection()
				  action  = data2.current.value
  
				  if action == 'fine_car' then
					  TriggerEvent('envision_garage:fineCarByPlate')
				  end
				  if action == 'vehicle_info' then
					  TriggerEvent('envision_garage:checkCarInfoByPlateEvent')
				  end					
				  if action == 'search_database' then
					  LookupVehicle()
				  elseif DoesEntityExist(vehicle) then
					  local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
					  if action == 'vehicle_infos' then
						  OpenVehicleInfosMenu(vehicleData)
					  elseif action == 'lockNunlock' then
						  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							  local lockStatus = GetVehicleDoorLockStatus(vehicle)
							  for i=1, #copcars, 1 do
								  if vehicleData.model == copcars[i] then
									  isCopcar = true
								  end
							  end
							  if isCopcar then
								  if lockStatus == 1 or lockStatus == 0 then-- unlocked then 
									  SetVehicleDoorsLocked(vehicle, 4)
									  SetVehicleDoorsLockedForAllPlayers(vehicle, true)
									  ESX.ShowNotification(_U('vehicle_locked'))
								  elseif lockStatus == 4 then -- locked
									  SetVehicleDoorsLocked(vehicle, 1)
									  SetVehicleDoorsLockedForAllPlayers(vehicle, false)
									  ESX.ShowNotification(_U('vehicle_unlocked'))
								  end
							  else
								  ESX.ShowNotification(_U('notcopcar'))
							  end
						  end	
						  
					  elseif action == 'hijack_vehicle' then
						  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
							  Citizen.Wait(20000)
							  ClearPedTasksImmediately(playerPed)
  
							  SetVehicleDoorsLocked(vehicle, 1)
							  SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							  ESX.ShowNotification(_U('vehicle_unlocked'))
						  end
					  elseif action == 'impound' then
					  
						  -- is the script busy?
						  if CurrentTask.Busy then
							  return
						  end
  
						  ESX.ShowHelpNotification(_U('impound_prompt'))
						  
						  TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						  
						  CurrentTask.Busy = true
						  CurrentTask.Task = ESX.SetTimeout(10000, function()
							  ClearPedTasks(playerPed)
							  ImpoundVehicle(vehicle)
							  Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						  end)
						  
						  -- keep track of that vehicle!
						  Citizen.CreateThread(function()
							  while CurrentTask.Busy do
								  Citizen.Wait(1000)
							  
								  vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								  if not DoesEntityExist(vehicle) and CurrentTask.Busy then
									  ESX.ShowNotification(_U('impound_canceled_moved'))
									  ESX.ClearTimeout(CurrentTask.Task)
									  ClearPedTasks(playerPed)
									  CurrentTask.Busy = false
									  break
								  end
							  end
						  end)
  
					  elseif action == 'bajs' then
						  TriggerEvent('jsfour-dna:get', player)
					  end
				  else
					  ESX.ShowNotification(_U('no_vehicles_nearby'))
				  end
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
  
		  elseif data.current.value == 'object_spawner' then
			  ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'citizen_interaction',
			  {
				  title    = _U('traffic_interaction'),
				  align    = 'right',
				  elements = {
					  --{label = _U('cone'),            value = 'prop_roadcone02a'},
					  {label = _U('barrier'),         value = 'prop_mp_barrier_02b'},
					  --{label = 'Barriär pil höger',   value = 'prop_mp_arrow_barrier_01'},
					  --{label = 'Barriär vägarbete',   value = 'prop_mp_barrier_02'},
					  --{label = 'Barriär avspärrning', value = 'prop_barrier_work05'},
					  {label = _U('spikestrips'),     value = 'p_ld_stinger_s'},
					  --{label = _U('box'),             value = 'prop_boxpile_07d'},
					  --{label = _U('cash'),            value = 'hei_prop_cash_crate_half_full'},
					  {label = 'Trafikkon med lampa', value = 'prop_air_conelight'}
				  },
			  }, function(data2, menu2)
				  local model     = data2.current.value
				  local playerPed = PlayerPedId()
				  local coords    = GetEntityCoords(playerPed)
				  local forward   = GetEntityForwardVector(playerPed)
				  local x, y, z   = table.unpack(coords + forward * 1.0)
  
				  --if model == 'prop_roadcone02a' then
					  --z = z - 2.0
				  --end
  
				  ESX.Game.SpawnObject(model, {
					  x = x,
					  y = y,
					  z = z
				  }, function(obj)
					  SetEntityHeading(obj, GetEntityHeading(playerPed))
					  PlaceObjectOnGroundProperly(obj)
				  end)
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
		  end
  
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  function OpenIdentityCardMenu(player)
  
	  ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
  
		  local elements    = {}
		  local nameLabel   = _U('name', data.name)
		  local jobLabel    = nil
		  local sexLabel    = nil
		  local dobLabel    = nil
		  local heightLabel = nil
		  local idLabel     = nil
	  
		  if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			  jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		  else
			  jobLabel = _U('job', data.job.label)
		  end
	  
		  if Config.EnableESXIdentity then
	  
			  nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
	  
			  if data.sex ~= nil then
				  if string.lower(data.sex) == 'm' then
					  sexLabel = _U('sex', _U('male'))
				  else
					  sexLabel = _U('sex', _U('female'))
				  end
			  else
				  sexLabel = _U('sex', _U('unknown'))
			  end
	  
			  if data.dob ~= nil then
				  dobLabel = _U('dob', data.dob)
			  else
				  dobLabel = _U('dob', _U('unknown'))
			  end
	  
			  if data.height ~= nil then
				  heightLabel = _U('height', data.height)
			  else
				  heightLabel = _U('height', _U('unknown'))
			  end
	  
			  if data.name ~= nil then
				  idLabel = _U('id', data.name)
			  else
				  idLabel = _U('id', _U('unknown'))
			  end
	  
		  end
	  
		  local elements = {
			  {label = nameLabel, value = nil},
			  {label = jobLabel,  value = nil},
		  }
	  
		  if Config.EnableESXIdentity then
			  table.insert(elements, {label = sexLabel, value = nil})
			  table.insert(elements, {label = dobLabel, value = nil})
			  table.insert(elements, {label = heightLabel, value = nil})
			  table.insert(elements, {label = idLabel, value = nil})
		  end
	  
		  if data.drunk ~= nil then
			  table.insert(elements, {label = _U('bac', data.drunk), value = nil})
		  end
	  
		  if data.licenses ~= nil then
	  
			  table.insert(elements, {label = _U('license_label'), value = nil})
	  
			  for i=1, #data.licenses, 1 do
				  table.insert(elements, {label = data.licenses[i].label, value = nil})
			  end
	  
		  end
	  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		  {
			  title    = _U('citizen_interaction'),
			  align    = 'right',
			  elements = elements,
		  }, function(data, menu)
	  
		  end, function(data, menu)
			  menu.close()
		  end)
	  
	  end, GetPlayerServerId(player))
  
  end
  
  function OpenBodySearchMenu(player)
  
	  ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
  
		  local elements = {}
  
		  for i=1, #data.accounts, 1 do
  
			  if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
  
				  table.insert(elements, {
					  label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					  value    = 'black_money',
					  itemType = 'item_account',
					  amount   = data.accounts[i].money
				  })
  
				  break
			  end
  
		  end
  
		  table.insert(elements, {label = _U('guns_label'), value = nil})
  
		  for i=1, #data.weapons, 1 do
			  table.insert(elements, {
				  label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				  value    = data.weapons[i].name,
				  itemType = 'item_weapon',
				  amount   = data.weapons[i].ammo
			  })
		  end
  
		  table.insert(elements, {label = _U('inventory_label'), value = nil})
  
		  for i=1, #data.inventory, 1 do
			  if data.inventory[i].count > 0 then
				  table.insert(elements, {
					  label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					  value    = data.inventory[i].name,
					  itemType = 'item_standard',
					  amount   = data.inventory[i].count
				  })
			  end
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',
		  {
			  title    = _U('search'),
			  align    = 'right',
			  elements = elements,
		  },
		  function(data, menu)
  
			  local itemType = data.current.itemType
			  local itemName = data.current.value
			  local amount   = data.current.amount
  
			  if data.current.value ~= nil then
				  TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
				  OpenBodySearchMenu(player)
			  end
  
		  end, function(data, menu)
			  menu.close()
		  end)
  
	  end, GetPlayerServerId(player))
  
  end
  
  function OpenFineMenu(player)
  
	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'fine',
		  {
			  title    = _U('fine'),
			  align    = 'right',
			  elements = {
				  --[[{label = _U('traffic_offense'),   value = 0},
				  {label = _U('minor_offense'),     value = 1},
				  {label = _U('average_offense'),   value = 2},
				  {label = _U('major_offense'),     value = 3}]]
				  {label = _U('traffic_offense'), value = 0},
			  {label = _U('minor_offense'),   value = 1},
			  {label = _U('average_offense'), value = 2},
			  {label = _U('major_offense'),   value = 3},
			  --{label = _U('working_errors'),  value = 4},
			  --{label = _U('drugs_offense'),   value = 5},
			  --{label = _U('weapon_crimes'),   value = 6},
			  --{label = _U('other_offense'),   value = 7},
			  },
		  },
		  function(data, menu)
			  OpenFineCategoryMenu(player, data.current.value) 
		  end,
		  function(data, menu)
			  menu.close()
		  end
	  )
	
  end
  
  function OpenFineVehicleMenu(vehicle, vehicleData)
  
	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'fine',
		  {
			  title    = _U('fine'),
			  align    = 'right',
			  elements = {
				  {label = _U('traffic_offense'),   value = 0},
				  {label = _U('minor_offense'),     value = 1},
				  {label = _U('average_offense'),   value = 2},
				  {label = _U('major_offense'),     value = 3}
			  },
		  },
		  function(data, menu)
			  OpenFineVehicleCategoryMenu(vehicle, vehicleData, data.current.value)
		  end,
		  function(data, menu)
			  menu.close()
		  end
	  )
  
  end
  
  function OpenFineCategoryMenu(player, category)
  
	  ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
  
		  local elements = {}
  
		  for i=1, #fines, 1 do
			  table.insert(elements, {
				  label     = fines[i].label .. ' <span style="color: green;">$' .. fines[i].amount .. '</span>',
				  value     = fines[i].id,
				  amount    = fines[i].amount,
				  fineLabel = fines[i].label
			  })
		  end
  
		  ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'fine_category',
			  {
				  title    = _U('fine'),
				  align    = 'right',
				  elements = elements,
			  },
			  function(data, menu)
  
				  local label  = data.current.fineLabel
				  local amount = data.current.amount
  
				  menu.close()
  
				  if Config.EnablePlayerManagement then
					  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', _U('fine_total', label), amount)
				  else
					  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total', label), amount)
				  end
  
				  ESX.SetTimeout(300, function()
					  OpenFineCategoryMenu(player, category)
				  end)
  
			  end,
			  function(data, menu)
				  menu.close()
			  end
		  )
  
	  end, category)
  end
  
  function OpenFineVehicleCategoryMenu(vehicle, vehicleData, category)
  
	  ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
  
		  local elements = {}
  
		  for i=1, #fines, 1 do
			  table.insert(elements, {
				  label     = fines[i].label .. ' <span style="color: green;">$' .. fines[i].amount .. '</span>',
				  value     = fines[i].id,
				  amount    = fines[i].amount,
				  fineLabel = fines[i].label
			  })
		  end
  
		  ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'fine_category',
			  {
				  title    = _U('fine'),
				  align    = 'right',
				  elements = elements,
			  },
			  function(data, menu)
  
				  local label  = data.current.fineLabel
				  local amount = data.current.amount
  
				  -- Check if the vehicle is owned by a player, and if so retrieve the player's steam ID
				  ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(infos)
  
					  menu.close()
  
					  if infos.identifier ~= nil then
						  if Config.EnablePlayerManagement then
							  TriggerServerEvent('esx_billing:sendBillIdentifier', infos.identifier, 'society_police', _U('fine_total', label), amount, infos.name)
							  ESX.ShowNotification("Skickade en faktura till ägaren av fordonet!")
						  else
							  TriggerServerEvent('esx_billing:sendBillIdentifier', infos.identifier, '', _U('fine_total', label), amount, infos.name)
							  ESX.ShowNotification("Skickade en faktura till ägaren av fordonet!")
						  end
  
						  ESX.SetTimeout(300, function()
							  OpenFineCategoryMenu(vehicle, category)
						  end)
					  else
						  ESX.ShowNotification("Ägaren till fordonet kunde inte hittas!")
					  end
		
				  end, vehicleData.plate)
  
			  end,
			  function(data, menu)
				  menu.close()
			  end
		  )
  
	  end, category)
  end
  
  function LyftPlayer(closestPlayer)
	  ESX.ShowNotification('Du lyfter upp personen...')
	  Citizen.Wait(2500)
	  local dict = "anim@heists@box_carry@"
  
	  RequestAnimDict(dict)
	  while not HasAnimDictLoaded(dict) do
		  Citizen.Wait(100)
	  end
	  
	  local player, distance = ESX.Game.GetClosestPlayer()
	  local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
  
	  if distance ~= -1 and distance <= 3.0 then
		  local closestPlayer, distance = ESX.Game.GetClosestPlayer()
		  TriggerServerEvent('esx_ambulancejob:lyfter', GetPlayerServerId(closestPlayer))
  
		  TaskPlayAnim(GetPlayerPed(-1), dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		  isCarry = true
	  end
  end
  
  function OpenCriminalRecords(closestPlayer)
	  ESX.TriggerServerCallback('esx_policejob_brottsregister:grab', function(crimes)
  
		  local elements = {}
  
		  table.insert(elements, {label = 'Lägg till brott', value = 'crime'})
		  table.insert(elements, {label = '----= Brott =----', value = 'spacer'})
  
		  for i=1, #crimes, 1 do
			  table.insert(elements, {label = crimes[i].date .. ' - ' .. crimes[i].crime, value = crimes[i].crime, name = crimes[i].name})
		  end
  
  
		  ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'brottsregister',
			  {
				  title    = 'Brottsregister',
				  align    = 'right',
				  elements = elements
			  },
		  function(data2, menu2)
  
			  if data2.current.value == 'crime' then
				  ESX.UI.Menu.Open(
					  'dialog', GetCurrentResourceName(), 'brottsregister_second',
					  {
						  title = 'Brott?'
					  },
				  function(data3, menu3)
					  local crime = (data3.value)
  
					  if crime == tonumber(data3.value) then
						  ESX.ShowNotification('Åtgärd omöjlig')
						  menu3.close()               
					  else
						  menu2.close()
						  menu3.close()
						  TriggerServerEvent('esx_policejob_brottsregister:add', GetPlayerServerId(closestPlayer), crime)
						  ESX.ShowNotification('Lades till i registret!')
						  Citizen.Wait(100)
						  OpenCriminalRecords(closestPlayer)
					  end
  
				  end,
			  function(data3, menu3)
				  menu3.close()
			  end)
		  else
			  ESX.UI.Menu.Open(
				  'default', GetCurrentResourceName(), 'remove_confirmation',
					  {
					  title    = 'Ta bort?',
					  elements = {
						  {label = 'Ja', value = 'yes'},
						  {label = 'Nej', value = 'no'}
					  }
				  },
			  function(data3, menu3)
  
				  if data3.current.value == 'yes' then
					  menu2.close()
					  menu3.close()
					  TriggerServerEvent('esx_policejob_brottsregister:remove', GetPlayerServerId(closestPlayer), data2.current.value)
					  ESX.ShowNotification('Borttagen!')
					  Citizen.Wait(100)
					  OpenCriminalRecords(closestPlayer)
				  else
					  menu3.close()
				  end                         
  
				  end,
			  function(data3, menu3)
				  menu3.close()
			  end)                 
		  end
  
		  end,
		  function(data2, menu2)
			  menu2.close()
		  end)
  
	  end, GetPlayerServerId(closestPlayer))
  end
  
  function LookupVehicle()
	  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	  {
		  title = _U('search_database_title'),
	  }, function(data, menu)
		  local length = string.len(data.value)
		  if data.value == nil or length < 2 or length > 13 then
			  ESX.ShowNotification(_U('search_database_error_invalid'))
		  else
			  ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
				  if found then
					  ESX.ShowNotification(_U('search_database_found', owner))
				  else
					  ESX.ShowNotification(_U('search_database_error_not_found'))
				  end
			  end, data.value)
			  menu.close()
		  end
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  function ShowPlayerLicense(player)
	  local elements = {}
	  local targetName
	  ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		  if data.licenses then
			  for i=1, #data.licenses, 1 do
				  if data.licenses[i].label and data.licenses[i].type then
					  table.insert(elements, {
						  label = data.licenses[i].label,
						  type = data.licenses[i].type
					  })
				  end
			  end
		  end
		  
		  if Config.EnableESXIdentity then
			  targetName = data.firstname .. ' ' .. data.lastname
		  else
			  targetName = data.name
		  end
		  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
		  {
			  title    = _U('license_revoke'),
			  align    = 'right',
			  elements = elements,
		  }, function(data, menu)
			  ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			  TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			  
			  TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)
			  
			  ESX.SetTimeout(300, function()
				  ShowPlayerLicense(player)
			  end)
		  end, function(data, menu)
			  menu.close()
		  end)
  
	  end, GetPlayerServerId(player))
  end
  
  function OpenUnpaidBillsMenu(player)
	  local elements = {}
  
	  ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		  for i=1, #bills, 1 do
			  table.insert(elements, {
				  label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>',
				  value = bills[i].id
			  })
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		  {
			  title    = _U('unpaid_bills'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
	  
		  end, function(data, menu)
			  menu.close()
		  end)
	  end, GetPlayerServerId(player))
  end
  
  function OpenVehicleInfosMenu(vehicleData)
  
	  ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
  
		  local elements = {}
  
		  table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})
  
		  if retrivedInfo.owner == nil then
			  table.insert(elements, {label = _U('owner_unknown'), value = nil})
		  else
			  table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos',
		  {
			  title    = _U('vehicle_info'),
			  align    = 'right',
			  elements = elements
		  }, nil, function(data, menu)
			  menu.close()
		  end)
  
	  end, vehicleData.plate)
  
  end
  
  --[[function OpenGetWeaponMenu()
  
	  ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
		  local elements = {}
  
		  for i=1, #weapons, 1 do
			  if weapons[i].count > 0 then
				  table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
			  end
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
		  {
			  title    = _U('get_weapon_menu'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
  
			  menu.close()
  
			  ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
				  OpenGetWeaponMenu()
			  end, data.current.value)
  
		  end, function(data, menu)
			  menu.close()
		  end)
	  end)
  
  end
  
  function OpenPutWeaponMenu()
	  local elements   = {}
	  local playerPed  = PlayerPedId()
	  local weaponList = ESX.GetWeaponList()
  
	  for i=1, #weaponList, 1 do
		  local weaponHash = GetHashKey(weaponList[i].name)
  
		  if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			  table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
		  end
	  end
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
	  {
		  title    = _U('put_weapon_menu'),
		  align    = 'right',
		  elements = elements
	  }, function(data, menu)
  
		  menu.close()
  
		  ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
			  OpenPutWeaponMenu()
		  end, data.current.value, true)
  
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  function OpenBuyWeaponsMenu(station)
  
	  ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
  
		  local elements = {}
  
		  for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do
			  local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
			  local count  = 0
  
			  for i=1, #weapons, 1 do
				  if weapons[i].name == weapon.name then
					  count = weapons[i].count
					  break
				  end
			  end
  
			  table.insert(elements, {
				  label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price,
				  value = weapon.name,
				  price = weapon.price
			  })
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons',
		  {
			  title    = _U('buy_weapon_menu'),
			  align    = 'right',
			  elements = elements,
		  }, function(data, menu)
  
			  ESX.TriggerServerCallback('esx_policejob:buy', function(hasEnoughMoney)
				  if hasEnoughMoney then
					  ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
						  OpenBuyWeaponsMenu(station)
					  end, data.current.value, false)
				  else
					  ESX.ShowNotification(_U('not_enough_money'))
				  end
			  end, data.current.price)
  
		  end, function(data, menu)
			  menu.close()
		  end)
  
	  end)
  
  end
  
  function OpenGetStocksMenu()
  
	  ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)
  
		  local elements = {}
  
		  for i=1, #items, 1 do
			  table.insert(elements, {
				  label = 'x' .. items[i].count .. ' ' .. items[i].label,
				  value = items[i].name
			  })
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		  {
			  title    = _U('police_stock'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
  
			  local itemName = data.current.value
  
			  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				  title = _U('quantity')
			  }, function(data2, menu2)
  
				  local count = tonumber(data2.value)
  
				  if count == nil then
					  ESX.ShowNotification(_U('quantity_invalid'))
				  else
					  menu2.close()
					  menu.close()
					  TriggerServerEvent('esx_policejob:getStockItem', itemName, count)
  
					  Citizen.Wait(300)
					  OpenGetStocksMenu()
				  end
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
  
		  end, function(data, menu)
			  menu.close()
		  end)
	  end)
  end
  
  function OpenPutStocksMenu()
  
	  ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
  
		  local elements = {}
  
		  for i=1, #inventory.items, 1 do
			  local item = inventory.items[i]
  
			  if item.count > 0 then
				  table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
			  end
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		  {
			  title    = _U('inventory'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
  
			  local itemName = data.current.value
  
			  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				  title = _U('quantity')
			  }, function(data2, menu2)
  
				  local count = tonumber(data2.value)
  
				  if count == nil then
					  ESX.ShowNotification(_U('quantity_invalid'))
				  else
					  menu2.close()
					  menu.close()
					  TriggerServerEvent('esx_policejob:putStockItems', itemName, count)
  
					  Citizen.Wait(300)
					  OpenPutStocksMenu()
				  end
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
  
		  end, function(data, menu)
			  menu.close()
		  end)
	  end)
  
  end]]
  
  function OpenGetWeaponMenu()
  
	  ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
		  local elements = {}
  
		  for i=1, #weapons, 1 do
			  if weapons[i].count > 0 then
				  table.insert(elements, {
					  label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					  value = weapons[i].name
				  })
			  end
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
		  {
			  title    = _U('get_weapon_menu'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
  
			  menu.close()
  
			  ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
				  OpenGetWeaponMenu()
			  end, data.current.value)
			  if Config.EnableJobLogs == true then
				  TriggerServerEvent('esx_joblogs:AddInLog',"police" ,"removeArmoryWeapon" ,GetPlayerName(PlayerId()), label , value)
			  end
  
		  end, function(data, menu)
			  menu.close()
		  end)
	  end)
  
  end
  
  function OpenPutWeaponMenu()
	  local elements   = {}
	  local playerPed  = PlayerPedId()
	  local weaponList = ESX.GetWeaponList()
  
	  for i=1, #weaponList, 1 do
		  local weaponHash = GetHashKey(weaponList[i].name)
  
		  if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			  table.insert(elements, {
				  label = weaponList[i].label,
				  value = weaponList[i].name
			  })
		  end
	  end
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
	  {
		  title    = _U('put_weapon_menu'),
		  align    = 'right',
		  elements = elements
	  }, function(data, menu)
  
		  menu.close()
  
		  ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
			  OpenPutWeaponMenu()
		  end, data.current.value, true)
		  if Config.EnableJobLogs == true then
			  TriggerServerEvent('esx_joblogs:AddInLog',"police" ,"add_weapon" ,GetPlayerName(PlayerId()),weaponName ,amount)
		  end
  
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  function OpenBuyWeaponsMenu()
  
	  local elements = {}
	  local playerPed = PlayerPedId()
	  PlayerData = ESX.GetPlayerData()
  
	  for k,v in ipairs(Config.AuthorizedWeapons[PlayerData.job.grade_name]) do
		  local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		  local components, label = {}
  
		  local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)
  
		  if v.components then
			  for i=1, #v.components do
				  if v.components[i] then
  
					  local component = weapon.components[i]
					  local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)
  
					  if hasComponent then
						  label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_owned'))
					  else
						  if v.components[i] > 0 then
							  label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_item', ESX.Math.GroupDigits(v.components[i])))
						  else
							  label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_free'))
						  end
					  end
  
					  table.insert(components, {
						  label = label,
						  componentLabel = component.label,
						  hash = component.hash,
						  name = component.name,
						  price = v.components[i],
						  hasComponent = hasComponent,
						  componentNum = i
					  })
				  end
			  end
		  end
  
		  if hasWeapon and v.components then
			  label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
		  elseif hasWeapon and not v.components then
			  label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_owned'))
		  else
			  if v.price > 0 then
				  label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_item', ESX.Math.GroupDigits(v.price)))
			  else
				  label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_free'))
			  end
		  end
  
		  table.insert(elements, {
			  label = label,
			  weaponLabel = weapon.label,
			  name = weapon.name,
			  components = components,
			  price = v.price,
			  hasWeapon = hasWeapon
		  })
	  end
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		  title    = _U('armory_weapontitle'),
		  align    = 'right',
		  elements = elements
	  }, function(data, menu)
  
		  if data.current.hasWeapon then
			  if #data.current.components > 0 then
				  OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			  end
		  else
			  ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
				  if bought then
					  if data.current.price > 0 then
						  ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
					  end
  
					  menu.close()
  
					  OpenBuyWeaponsMenu()
				  else
					  ESX.ShowNotification(_U('armory_money'))
				  end
			  end, data.current.name, 1)
		  end
  
	  end, function(data, menu)
		  menu.close()
	  end)
  
  end
  
  function OpenWeaponComponentShop(components, weaponName, parentShop)
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
		  title    = _U('armory_componenttitle'),
		  align    = 'right',
		  elements = components
	  }, function(data, menu)
  
		  if data.current.hasComponent then
			  ESX.ShowNotification(_U('armory_hascomponent'))
		  else
			  ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
				  if bought then
					  if data.current.price > 0 then
						  ESX.ShowNotification(_U('armory_bought', data.current.componentLabel, ESX.Math.GroupDigits(data.current.price)))
					  end
  
					  menu.close()
					  parentShop.close()
  
					  OpenBuyWeaponsMenu()
				  else
					  ESX.ShowNotification(_U('armory_money'))
				  end
			  end, weaponName, 2, data.current.componentNum)
		  end
  
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  function OpenGetStocksMenu()
  
	  ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)
  
		  local elements = {}
  
		  for i=1, #items, 1 do
			  table.insert(elements, {
				  label = 'x' .. items[i].count .. ' ' .. items[i].label,
				  value = items[i].name
			  })
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		  {
			  title    = _U('police_stock'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
  
			  local itemName = data.current.value
  
			  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				  title = _U('quantity')
			  }, function(data2, menu2)
  
				  local count = tonumber(data2.value)
  
				  if count == nil then
					  ESX.ShowNotification(_U('quantity_invalid'))
				  else
					  menu2.close()
					  menu.close()
					  TriggerServerEvent('esx_policejob:getStockItem', itemName, count)
					  if Config.EnableJobLogs == true then
						TriggerServerEvent('esx_joblogs:AddInLog',"police" ,"getSharedInventory" ,GetPlayerName(PlayerId()), itemName ,count)
					  end
  
					  Citizen.Wait(300)
					  OpenGetStocksMenu()
				  end
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
  
		  end, function(data, menu)
			  menu.close()
		  end)
  
	  end)
  
  end
  
  function OpenPutStocksMenu()
  
	  ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
  
		  local elements = {}
  
		  for i=1, #inventory.items, 1 do
			  local item = inventory.items[i]
  
			  if item.count > 0 then
				  table.insert(elements, {
					  label = item.label .. ' x' .. item.count,
					  type = 'item_standard',
					  value = item.name
				  })
			  end
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		  {
			  title    = _U('inventory'),
			  align    = 'right',
			  elements = elements
		  }, function(data, menu)
  
			  local itemName = data.current.value
  
			  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				  title = _U('quantity')
			  }, function(data2, menu2)
  
				  local count = tonumber(data2.value)
  
				  if count == nil then
					  ESX.ShowNotification(_U('quantity_invalid'))
				  else
					  menu2.close()
					  menu.close()
					  TriggerServerEvent('esx_policejob:putStockItems', itemName, count)
					  if Config.EnableJobLogs == true then
					   TriggerServerEvent('esx_joblogs:AddInLog',"police" ,"putStockItems" ,GetPlayerName(PlayerId()), itemName ,count)
					  end
  
					  Citizen.Wait(300)
					  OpenPutStocksMenu()
				  end
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
  
		  end, function(data, menu)
			  menu.close()
		  end)
	  end)
  
  end
  
  -- Handcuff
  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(1)
		  local playerPed = PlayerPedId()
  
		  if IsHandcuffed then
			  --DisableControlAction(0, 1, true) -- Disable pan
			  --DisableControlAction(0, 2, true) -- Disable tilt
			  DisableControlAction(0, 24, true) -- Attack
			  DisableControlAction(0, 257, true) -- Attack 2
			  DisableControlAction(0, 25, true) -- Aim
			  DisableControlAction(0, 263, true) -- Melee Attack 1
			  --DisableControlAction(0, Keys['W'], true) -- W
			  --DisableControlAction(0, Keys['A'], true) -- A
			  --DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			  --DisableControlAction(0, 30, true) -- D (fault in Keys table!)
  
			  DisableControlAction(0, Keys['R'], true) -- Reload
			  DisableControlAction(0, Keys['SPACE'], true) -- Jump
			  DisableControlAction(0, Keys['Q'], true) -- Cover
			  DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			  --DisableControlAction(0, Keys['F'], true) -- Also 'enter'?
  
			  DisableControlAction(0, Keys['F1'], true) -- Disable phone
			  DisableControlAction(0, Keys['F2'], true) -- Inventory
			  DisableControlAction(0, Keys['F3'], true) -- Animations
			  DisableControlAction(0, Keys['F6'], true) -- Job
  
			  DisableControlAction(0, Keys['V'], true) -- Disable changing view
			  DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			  DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			  DisableControlAction(2, Keys['P'], true) -- Disable pause screen
  
			  DisableControlAction(0, 59, true) -- Disable steering in vehicle
			  DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			  DisableControlAction(0, 72, true) -- Disable reversing in vehicle
  
			  DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
  
			  DisableControlAction(0, 47, true)  -- Disable weapon
			  DisableControlAction(0, 264, true) -- Disable melee
			  DisableControlAction(0, 257, true) -- Disable melee
			  DisableControlAction(0, 140, true) -- Disable melee
			  DisableControlAction(0, 141, true) -- Disable melee
			  DisableControlAction(0, 142, true) -- Disable melee
			  DisableControlAction(0, 143, true) -- Disable melee
			  --DisableControlAction(0, 75, true)  -- Disable exit vehicle
			  --DisableControlAction(27, 75, true) -- Disable exit vehicle
  
			  if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				  ESX.Streaming.RequestAnimDict('mp_arresting', function()
					  TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				  end)
			  end
		  else
			  Citizen.Wait(500)
		  end
	  end
  end)
  
  RegisterNetEvent('esx_policejob:handcuff')
  AddEventHandler('esx_policejob:handcuff', function()
	  IsHandcuffed    = not IsHandcuffed
	  local playerPed = PlayerPedId()
  
	  Citizen.CreateThread(function()
		  if IsHandcuffed then
  
			  RequestAnimDict('mp_arresting')
			  while not HasAnimDictLoaded('mp_arresting') do
				  Citizen.Wait(100)
			  end
  
			  TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  
			  SetEnableHandcuffs(playerPed, true)
			  DisablePlayerFiring(playerPed, true)
			  SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			  SetPedCanPlayGestureAnims(playerPed, false)
			  FreezeEntityPosition(playerPed, false)
			  DisplayRadar(false)
  
			  if Config.EnableHandcuffTimer then
  
				  if HandcuffTimer.Active then
					  ESX.ClearTimeout(HandcuffTimer.Task)
				  end
  
				  StartHandcuffTimer()
			  end
  
		  else
  
			  if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				  ESX.ClearTimeout(HandcuffTimer.Task)
			  end
  
			  ClearPedSecondaryTask(playerPed)
			  SetEnableHandcuffs(playerPed, false)
			  DisablePlayerFiring(playerPed, false)
			  SetPedCanPlayGestureAnims(playerPed, true)
			  FreezeEntityPosition(playerPed, false)
			  DisplayRadar(true)
		  end
	  end)
  
  end)
  
  RegisterNetEvent('esx_policejob:unrestrain')
  AddEventHandler('esx_policejob:unrestrain', function()
	  if IsHandcuffed then
		  local playerPed = PlayerPedId()
		  IsHandcuffed = false
  
		  ClearPedSecondaryTask(playerPed)
		  SetEnableHandcuffs(playerPed, false)
		  DisablePlayerFiring(playerPed, false)
		  SetPedCanPlayGestureAnims(playerPed, true)
		  FreezeEntityPosition(playerPed, false)
		  DisplayRadar(true)
  
		  -- end timer
		  if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			  ESX.ClearTimeout(HandcuffTimer.Task)
		  end
	  end
  end)
  
  RegisterNetEvent('esx_policejob:upplyft')
  AddEventHandler('esx_policejob:upplyft', function(target)
	  local playerPed = GetPlayerPed(-1)
	  local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	  local lPed = GetPlayerPed(-1)
	  local dict = "amb@code_human_in_car_idles@low@ps@"
	  
	  if isCarry == false then
		  LoadAnimationDictionary("amb@code_human_in_car_idles@generic@ps@base")
		  TaskPlayAnim(lPed, "amb@code_human_in_car_idles@generic@ps@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
		  
		  AttachEntityToEntity(GetPlayerPed(-1), targetPed, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
		  
		  isCarry = true
	  else
		  DetachEntity(GetPlayerPed(-1), true, false)
		  ClearPedTasksImmediately(targetPed)
		  ClearPedTasksImmediately(GetPlayerPed(-1))
		  
		  isCarry = false
	  end
  end)
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
	  PlayerData.job = job
	  
	  Citizen.Wait(5000)
	  TriggerServerEvent('esx_policejob:forceBlip')
  end)
  
  AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)
  
	  if part == 'Cloakroom' then
		  CurrentAction     = 'menu_cloakroom'
		  CurrentActionMsg  = _U('open_cloackroom')
		  CurrentActionData = {}
  
	  elseif part == 'Armory' then
  
		  CurrentAction     = 'menu_armory'
		  CurrentActionMsg  = _U('open_armory')
		  CurrentActionData = {station = station}
  
	  elseif part == 'VehicleSpawner' then
  
		  CurrentAction     = 'menu_vehicle_spawner'
		  CurrentActionMsg  = _U('vehicle_spawner')
		  CurrentActionData = {station = station, partNum = partNum}
  
	  elseif part == 'HelicopterSpawner' then
  
		  local helicopters = Config.PoliceStations[station].Helicopters
  
		  if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint.x, helicopters[partNum].SpawnPoint.y, helicopters[partNum].SpawnPoint.z,  3.0) then
			  ESX.Game.SpawnVehicle('polmav', helicopters[partNum].SpawnPoint, helicopters[partNum].Heading, function(vehicle)
				  SetVehicleModKit(vehicle, 0)
				  SetVehicleLivery(vehicle, 0)
				  SetVehicleFuelLevel(vehicle, 100 + 0.0)
				  DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
			  end)
		  end
  
	  elseif part == 'VehicleDeleter' then
  
		  local playerPed = PlayerPedId()
		  local coords    = GetEntityCoords(playerPed)
  
		  if IsPedInAnyVehicle(playerPed,  false) then
  
			  local vehicle = GetVehiclePedIsIn(playerPed, false)
  
			  if DoesEntityExist(vehicle) then
				  CurrentAction     = 'delete_vehicle'
				  CurrentActionMsg  = _U('store_vehicle')
				  CurrentActionData = {vehicle = vehicle}
			  end
  
		  end
  
	  elseif part == 'BossActions' then
  
		  CurrentAction     = 'menu_boss_actions'
		  CurrentActionMsg  = _U('open_bossmenu')
		  CurrentActionData = {}
  
	  end
  
  end)
  
  AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	  ESX.UI.Menu.CloseAll()
	  CurrentAction = nil
  end)
  
  RegisterNetEvent('esx_policejob:drag')
  AddEventHandler('esx_policejob:drag', function(copID)
	  DragStatus.IsDragged = not DragStatus.IsDragged
	  DragStatus.CopId     = tonumber(copID)
  end)
  
  Citizen.CreateThread(function()
	  local playerPed
	  local targetPed
  
	  while true do
		  Citizen.Wait(1)
  
		  if DragStatus.IsDragged then
			  playerPed = PlayerPedId()
			  targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))
  
			  -- undrag if target is in an vehicle
			  if not IsPedSittingInAnyVehicle(targetPed) then
				  AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			  else
				  DragStatus.IsDragged = false
				  DetachEntity(playerPed, true, false)
			  end
  
			  if IsPedDeadOrDying(targetPed, true) then
				  DragStatus.IsDragged = false
				  DetachEntity(playerPed, true, false)
			  end
  
		  else
			  DetachEntity(playerPed, true, false)
		  end
	  end
  end)
  
  RegisterNetEvent('esx_policejob:putInVehicle')
  AddEventHandler('esx_policejob:putInVehicle', function()
	  local playerPed = PlayerPedId()
	  local coords = GetEntityCoords(playerPed)
  
	  if IsAnyVehicleNearPoint(coords, 5.0) then
		  local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)
  
		  if DoesEntityExist(vehicle) then
			  local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
  
			  for i=maxSeats - 1, 0, -1 do
				  if IsVehicleSeatFree(vehicle, i) then
					  freeSeat = i
					  break
				  end
			  end
  
			  if freeSeat then
				  TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				  DragStatus.IsDragged = false
			  end
		  end
	  end
  end)
  
  RegisterNetEvent('esx_policejob:OutVehicle')
  AddEventHandler('esx_policejob:OutVehicle', function()
	  local playerPed = PlayerPedId()
  
	  if not IsPedSittingInAnyVehicle(playerPed) then
		  return
	  end
  
	  local vehicle = GetVehiclePedIsIn(playerPed, false)
	  TaskLeaveVehicle(playerPed, vehicle, 16)
  end)
  
  -- Create blips
  Citizen.CreateThread(function()
  
	  for k,v in pairs(Config.PoliceStations) do
		  local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)
  
		  SetBlipSprite (blip, v.Blip.Sprite)
		  SetBlipDisplay(blip, v.Blip.Display)
		  SetBlipScale  (blip, v.Blip.Scale)
		  SetBlipColour (blip, v.Blip.Colour)
		  SetBlipAsShortRange(blip, true)
  
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString(_U('map_blip'))
		  EndTextCommandSetBlipName(blip)
	  end
  
  end)
  
  -- Display markers
  Citizen.CreateThread(function()
	  while true do
  
		  Citizen.Wait(1)
  
		  if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
  
			  local playerPed = PlayerPedId()
			  local coords    = GetEntityCoords(playerPed)
  
			  for k,v in pairs(Config.PoliceStations) do
  
				  for i=1, #v.Cloakrooms, 1 do
					  if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < Config.DrawDistance then
						  DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					  end
				  end
  
				  for i=1, #v.Armories, 1 do
					  if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.DrawDistance then
						  DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					  end
				  end
  
				  for i=1, #v.Vehicles, 1 do
					  if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < Config.DrawDistance then
						  DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					  end
				  end
  
				  for i=1, #v.VehicleDeleters, 1 do
					  if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < Config.DrawDistance then
						  DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					  end
				  end
  
				  if Config.EnablePlayerManagement and PlayerData.job.grade_name == 'boss' then
					  for i=1, #v.BossActions, 1 do
						  if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < Config.DrawDistance then
							  DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
						  end
					  end
				  end
  
			  end
  
		  else
			  Citizen.Wait(500)
		  end
  
	  end
  end)
  
  -- Enter / Exit marker events
  Citizen.CreateThread(function()
  
	  while true do
  
		  Citizen.Wait(10)
  
		  if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
  
			  local playerPed      = PlayerPedId()
			  local coords         = GetEntityCoords(playerPed)
			  local isInMarker     = false
			  local currentStation = nil
			  local currentPart    = nil
			  local currentPartNum = nil
  
			  for k,v in pairs(Config.PoliceStations) do
  
				  for i=1, #v.Cloakrooms, 1 do
					  if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < Config.MarkerSize.x then
						  isInMarker     = true
						  currentStation = k
						  currentPart    = 'Cloakroom'
						  currentPartNum = i
					  end
				  end
  
				  for i=1, #v.Armories, 1 do
					  if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.MarkerSize.x then
						  isInMarker     = true
						  currentStation = k
						  currentPart    = 'Armory'
						  currentPartNum = i
					  end
				  end
  
				  for i=1, #v.Vehicles, 1 do
					  if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < Config.MarkerSize.x then
						  isInMarker     = true
						  currentStation = k
						  currentPart    = 'VehicleSpawner'
						  currentPartNum = i
					  end
				  end
  
				  for i=1, #v.Helicopters, 1 do
					  if GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, true) < Config.MarkerSize.x then
						  isInMarker     = true
						  currentStation = k
						  currentPart    = 'HelicopterSpawner'
						  currentPartNum = i
					  end
				  end
  
				  for i=1, #v.VehicleDeleters, 1 do
					  if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < Config.MarkerSize.x then
						  isInMarker     = true
						  currentStation = k
						  currentPart    = 'VehicleDeleter'
						  currentPartNum = i
					  end
				  end
  
				  if Config.EnablePlayerManagement and PlayerData.job.grade_name == 'boss' then
					  for i=1, #v.BossActions, 1 do
						  if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < Config.MarkerSize.x then
							  isInMarker     = true
							  currentStation = k
							  currentPart    = 'BossActions'
							  currentPartNum = i
						  end
					  end
				  end
  
			  end
  
			  local hasExited = false
  
			  if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
  
				  if
					  (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					  (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				  then
					  TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					  hasExited = true
				  end
  
				  HasAlreadyEnteredMarker = true
				  LastStation             = currentStation
				  LastPart                = currentPart
				  LastPartNum             = currentPartNum
  
				  TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			  end
  
			  if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				  HasAlreadyEnteredMarker = false
				  TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			  end
  
		  else
			  Citizen.Wait(500)
		  end
  
	  end
  end)
  
  -- Key Controls
  Citizen.CreateThread(function()
	  while true do
  
		  Citizen.Wait(10)
  
		  if CurrentAction ~= nil then
			  ESX.ShowHelpNotification(CurrentActionMsg)
  
			  if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
  
				  if CurrentAction == 'menu_cloakroom' then
					  OpenCloakroomMenu()
				  elseif CurrentAction == 'menu_armory' then
					  if Config.MaxInService == -1 then
						  OpenArmoryMenu(CurrentActionData.station)
					  elseif playerInService then
						  OpenArmoryMenu(CurrentActionData.station)
					  else
						  ESX.ShowNotification(_U('service_not'))
					  end
				  elseif CurrentAction == 'menu_vehicle_spawner' then
					  OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
				  elseif CurrentAction == 'delete_vehicle' then
					  if Config.EnableSocietyOwnedVehicles then
						  local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						  TriggerServerEvent('esx_society:putVehicleInGarage', 'police', vehicleProps)
					  end
					  ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				  elseif CurrentAction == 'menu_boss_actions' then
					  ESX.UI.Menu.CloseAll()
					  TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
						  menu.close()
						  CurrentAction     = 'menu_boss_actions'
						  CurrentActionMsg  = _U('open_bossmenu')
						  CurrentActionData = {}
					  end, { wash = false }) -- disable washing money
				  elseif CurrentAction == 'remove_entity' then
					  DeleteEntity(CurrentActionData.entity)
				  end
				  
				  CurrentAction = nil
			  end
		  end -- CurrentAction end
		  
		  if IsControlJustReleased(0, Keys['F6'])  and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
			  if Config.MaxInService == -1 then
				  OpenPoliceActionsMenu()
			  elseif playerInService then
				  OpenPoliceActionsMenu()
			  else
				  ESX.ShowNotification(_U('service_not'))
			  end
		  end
		  
		  if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
			  ESX.ShowNotification(_U('impound_canceled'))
			  ESX.ClearTimeout(CurrentTask.Task)
			  ClearPedTasks(PlayerPedId())
			  
			  CurrentTask.Busy = false
		  end
  
		  if IsControlJustPressed(0, Keys['N7']) and GetLastInputMethod(2) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			  SendPoliceDistressSignal()
		  end
	  end
  end)
  
  -- Create blip for colleagues
  function createBlip(id)
	  local ped = GetPlayerPed(id)
	  local blip = GetBlipFromEntity(ped)
  
	  if not DoesBlipExist(blip) then -- Add blip and create head display on player
		  blip = AddBlipForEntity(ped)
		  SetBlipSprite(blip, 1)
		  ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		  SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		  SetBlipNameToPlayerName(blip, id) -- update blip name
		  SetBlipScale(blip, 0.85) -- set scale
		  SetBlipAsShortRange(blip, true)
		  
		  table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	  end
  end
  
  RegisterNetEvent('esx_policejob:updateBlip')
  AddEventHandler('esx_policejob:updateBlip', function()
	  
	  -- Refresh all blips
	  for k, existingBlip in pairs(blipsCops) do
		  RemoveBlip(existingBlip)
	  end
	  
	  -- Clean the blip table
	  blipsCops = {}
  
	  -- Enable blip?
	  if Config.MaxInService ~= -1 and not playerInService then
		  return
	  end
  
	  if not Config.EnableJobBlip then
		  return
	  end
	  
	  -- Is the player a cop? In that case show all the blips for other cops
	  if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		  ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			  for i=1, #players, 1 do
				  if players[i].job.name == 'police' then
					  local id = GetPlayerFromServerId(players[i].source)
					  if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						  createBlip(id)
					  end
				  end
			  end
		  end)
	  end
  
  end)
  
  AddEventHandler('playerSpawned', function(spawn)
	  isDead = false
	  TriggerEvent('esx_policejob:unrestrain')
	  
	  if not hasAlreadyJoined then
		  TriggerServerEvent('esx_policejob:spawned')
	  end
	  hasAlreadyJoined = true
  end)
  
  AddEventHandler('esx:onPlayerDeath', function(data)
	  isDead = true
  end)
  
  AddEventHandler('onResourceStop', function(resource)
	  if resource == GetCurrentResourceName() then
		  TriggerEvent('esx_policejob:unrestrain')
  
		  if Config.MaxInService ~= -1 then
			  TriggerServerEvent('esx_service:disableService', 'police')
		  end
	  end
  end)
  
  -- panik knapp
  function SendPoliceDistressSignal()
	  local playerPed     = PlayerPedId()
	  local PedPosition	= GetEntityCoords(playerPed)
  
	  
	  local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
  
	  ESX.ShowNotification(_U('distress_sent'))
  
	  TriggerServerEvent('esx_phone:send', 'police', _U('police_distress_message'), PlayerCoords, {
  
		  PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	  })
  end
  
  function ImpoundVehicle(vehicle)
	  ESX.Game.DeleteVehicle(vehicle) 
	  ESX.ShowNotification(_U('impound_successful'))
	  CurrentTask.Busy = false
  end