ESX = nil
local poopDictionary = 'misschop_vehicle@back_of_van'
local poopAnimation = 'chop_lean_back_loop'
local particleDictionary = "scr_amb_chop"
local particleName = "ent_anim_dog_poo"
local poopProp = 'prop_big_shit_01'
local bagDictionary = 'anim@mp_snowball'
local bagAnimation = 'pickup_snowball'
local cachedData = {}
local cachedClientData = {
	['animal'] = nil,
	['house'] = nil,
	['picking_up_poop'] = false
}
Citizen.CreateThread(function()
	while not ESX do
		TriggerEvent('esx:getSharedObject', function(library) 
			ESX = library 
		end)
		Citizen.Wait(25)
	end
	if ESX.IsPlayerLoaded() then
		TriggerServerEvent('fivem_dogwalker:actions', {['action'] = 'load_data'})
	end
	LoadDogModels()
end)

RegisterNetEvent('fivem_dogwalker:updateData')
AddEventHandler('fivem_dogwalker:updateData', function(data)
	cachedData = data
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	TriggerServerEvent('fivem_dogwalker:actions', {['action'] = 'load_data'})
end)

DrawCircle = function(pos)
	DrawMarker(25, pos.x, pos.y, pos.z - 0.99, 0, 0, 0, 0, 0, 0.0, 0.6, 0.6, 0.01, 255, 255, 255, 0.5, 0, 0, 0,0) 
end

LoadDogModels = function()
	LoadModel(-1788665315) -- chien--
	LoadModel(1682622302) -- loup
	LoadModel(1318032802) -- husky--
	LoadModel(1125994524) -- caniche
	LoadModel(1832265812) -- carlin---coyote
	LoadModel(882848737) -- retriever----
	LoadModel(1126154828) -- berger
	LoadModel(-1384627013) -- westie--
	LoadModel(351016938)  -- rottweiler--
end

LoadAnimDict = function(dict)
	RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
	end
end

LoadParticleDict = function(dict)
	RequestNamedPtfxAsset(dict)
	while not HasNamedPtfxAssetLoaded(dict) do
		Citizen.Wait(0)
    end
end

LoadModel = function(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
end

PetshopMainMenu = function()
    ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'petshop_main_menu',
	{
		title    = _U('petshop'),
		align    = 'right',
		elements = {
			{['label'] = _U('check_jobs'), ['value'] = 'check_jobs'},
		}
    },function(data, menu)
        local value = data['current']['value']
		if value == 'check_jobs' then
			Prompt(function(state)
				if state then
					for k,v in pairs(Config.Locations) do
						if cachedData[k] == nil then
							menu.close()
							SetNewWaypoint(v['coords'])
							break
						end
					end
					if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), 'petshop_main_menu' )then
						ESX.ShowNotification(_U('sorry_no_jobs_available'))
					end
				end
			end, _U('get_coords_for_house'))
		end
    end,
	function(data, menu)
		menu.close()
	end
)
end

Prompt = function(cb, question)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fivem_apartments_prompt',
		{
            title    = question,
            align    = 'center',
			elements = {
                {['label'] = _('no'), ['value'] = 'no'},
				{['label'] = _('yes'), ['value'] = 'yes'}
            }
		},
        function(data, menu)
            if data['current']['value'] == 'no' then
                menu.close()
                cb(false)
            elseif data['current']['value'] == 'yes' then
                menu.close()
                cb(true)
            end
		end,
        function(data, menu)
            menu.close()
            cb(false)
		end
	)
end

SpawnAnimal = function(cb, dog, coords)
	local playerPed = PlayerPedId()
	local LastPosition = GetEntityCoords(playerPed)
	local GroupHandle = GetPlayerGroup(PlayerId())
	Citizen.SetTimeout(500, function()
		animal = CreatePed(28, dog, coords.x, coords.y, coords.z, 1, 1)
		SetPedAsGroupLeader(playerPed, GroupHandle)
		SetPedAsGroupMember(animal, GroupHandle)
		SetPedNeverLeavesGroup(animal, true)
		SetPedCanBeTargetted(animal, false)
		SetEntityAsMissionEntity(animal, true,true)
		cb(animal)
	end)
end

Shit = function()
	cachedClientData['is_dog_need_active'] = false
	LoadAnimDict(poopDictionary)
	TaskPlayAnim(cachedClientData['animal'], poopDictionary, poopAnimation, 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(1000)
	ESX.Game.SpawnObject(poopProp, GetEntityCoords(cachedClientData['animal']) - (GetEntityForwardVector(cachedClientData['animal']) * 0.45), function(poop)
		FreezeEntityPosition(poop, true)
		PlaceObjectOnGroundProperly(poop)
		SetEntityAsMissionEntity(poop, true, false)
		SetEntityCollision(poop, false, true)
	end)
	Wait(800)
	ESX.ShowNotification(_U('dog_just_shat'))
	ESX.Game.SpawnObject(poopProp, GetEntityCoords(cachedClientData['animal']) - (GetEntityForwardVector(cachedClientData['animal']) * 0.45), function(poop)
		FreezeEntityPosition(poop, true)
		PlaceObjectOnGroundProperly(poop)
		SetEntityAsMissionEntity(poop, true, false)
		SetEntityCollision(poop, false, true)
	end)
    Wait(3500)
    StopParticleFxLooped(effect, 0)
end

PickupPoop = function(prop)
	cachedClientData['picking_up_poop'] = true
	LoadAnimDict(poopDictionary)
	if Config.BagNeeded then
		ESX.TriggerServerCallback('fivem_dogwalker:hasBag', function(state)
			if state  then
				LoadAnimDict(bagDictionary)
				TaskPlayAnim(PlayerPedId(), bagDictionary, bagAnimation, 8.0, -8.0, -1, 0, 0, false, false, false)
				Wait(800)
				NetworkFadeOutEntity(prop, false, false)
				SetEntityAsMissionEntity(prop, false, false)
				ESX.Game.DeleteObject(prop)  
				Wait(50)
				local poop = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.2, GetHashKey(poopProp))
				if DoesEntityExist(poop) then
					NetworkFadeOutEntity(poop, false, false)
					SetEntityAsMissionEntity(poop, false, false)
					ESX.Game.DeleteObject(poop)  
				end
			else 
				ESX.ShowNotification(_U('error_need_bag'))
			end
		end)
	else
		LoadAnimDict(bagDictionary)
		TaskPlayAnim(PlayerPedId(), bagDictionary, bagAnimation, 8.0, -8.0, -1, 0, 0, false, false, false)
		Wait(800)
		NetworkFadeOutEntity(prop, false, false)
		SetEntityAsMissionEntity(prop, false, false)
		ESX.Game.DeleteObject(prop)  
		Wait(50)
		local poop = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.2, GetHashKey(poopProp))
		if DoesEntityExist(poop) then
			NetworkFadeOutEntity(poop, false, false)
			SetEntityAsMissionEntity(poop, false, false)
			ESX.Game.DeleteObject(poop)  
		end
	end
	cachedClientData['picking_up_poop'] = false
end


Citizen.CreateThread(function()
	while true do

		local sleepThread = 2000
		if cachedClientData['house'] ~= nil then
			if cachedClientData['is_dog_need_active'] then
				if cachedClientData['gametime'] + math.random(5000, 35000) < GetGameTimer() then
					local chance = math.random(1, 5)
					if chance == 1 then 
						Shit()
					else
						cachedClientData['gametime'] = GetGameTimer()
					end
				end
			end
		end
		Citizen.Wait(sleepThread)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleepThread = 800
		if ESX ~= nil then
			local playerPed = PlayerPedId()
			local pedCoords = GetEntityCoords(playerPed)
			local dstCheckToShop = GetDistanceBetweenCoords(pedCoords, Config.Petshop, true)
			if cachedClientData['picking_up_poop'] == false then
				local poop = GetClosestObjectOfType(pedCoords, 1.2, GetHashKey(poopProp))
				if DoesEntityExist(poop) then
					sleepThread = 10
					if IsControlJustReleased(0, 38) then
						PickupPoop(poop)
					end
				end
			end
			if dstCheckToShop < 10.0 then
				sleepThread = 5
				DrawCircle(Config.Petshop)
				if dstCheckToShop < 0.5 then
					if IsControlJustReleased(0, 38) then
						PetshopMainMenu()
					end
				end
			else
				if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), 'petshop_main_menu' )then
					local menu = ESX.UI.Menu.GetOpened("default", GetCurrentResourceName(), 'petshop_main_menu')
					if menu then
						menu.close()
					end
				elseif ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), 'petshop_item_menu') then
					local menu = ESX.UI.Menu.GetOpened("default", GetCurrentResourceName(), 'petshop_item_menu')
					if menu then
						menu.close()
					end
				end
			end
			for k,v in pairs(Config.Locations) do
				local dstCheck = GetDistanceBetweenCoords(pedCoords, v['coords'], true)
				if dstCheck < 10.0 then
					sleepThread = 5
					DrawCircle(v['coords'])
					if dstCheck < 0.5 then
						if IsControlJustReleased(0, 38) then
							if cachedData[k] == nil then
								SpawnAnimal(function(animal)
									print(k)
									TriggerServerEvent('fivem_dogwalker:actions', {['action'] = 'walk_dog', ['house'] = k, ['table'] = {
										['model'] = v['dog_model'],
										['animal'] = animal,
										['dog_state'] = 'out'
									}})
									cachedClientData['animal'] = animal
									cachedClientData['house'] = k
									cachedClientData['is_dog_need_active'] = true
									cachedClientData['gametime'] = GetGameTimer()
								end, v['dog_model'], v['coords'])
							elseif cachedClientData['house'] == k then
								if GetEntityHealth(cachedClientData['animal']) > 100 then
									if GetDistanceBetweenCoords(pedCoords, GetEntityCoords(cachedClientData['animal'])) < 10  then
										if cachedClientData['is_dog_need_active'] == false then 
											DeleteEntity(cachedClientData['animal'])
											ESX.ShowNotification(_U('thanks_payment'))
											cachedClientData['house'] = nil
											TriggerServerEvent('fivem_dogwalker:actions', {['action'] = 'return_dog', ['house'] = k, ['table'] = {
												['model'] = v['dog_model'],
												['animal'] = animal
											}})
										else 
											ESX.ShowNotification(_U('take_another_turn'))
										end
									else
										ESX.ShowNotification(_U('where_is_my_dog'))
									end
								else
									cachedClientData['house'] = nil
									ESX.ShowNotification(_U('you_killed_my_dog'))
								end
							else
								ESX.ShowNotification(_U('no_need_for_walk'))
							end
						end
					end
				end
			end	
		end
		Citizen.Wait(sleepThread)
	end
end)