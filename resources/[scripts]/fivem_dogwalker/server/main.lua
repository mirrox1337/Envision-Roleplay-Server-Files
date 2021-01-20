ESX = nil
cachedStorages = {}
cachedData = {} 
TriggerEvent('esx:getSharedObject', function(library) 
	ESX = library 
end)

RegisterServerEvent('fivem_dogwalker:actions')
AddEventHandler('fivem_dogwalker:actions', function(data)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	if data['action'] == 'load_data' then
		TriggerClientEvent('fivem_dogwalker:updateData', src, cachedData)
	elseif data['action'] == 'walk_dog' then
		if cachedData[data['house']] == nil then
			cachedData[data['house']] = data['table']
			cachedData[data['house']]['time'] = os.time()
			TriggerClientEvent('fivem_dogwalker:updateData', -1, cachedData)
		else
			TriggerClientEvent('ESX.Shownotiofication', src, 'hmm error')
		end
	elseif data['action'] == 'return_dog' then
		Player.addMoney(Config.Payment)	
		cachedData[data['house']]['dog_state'] = 'home'
		TriggerClientEvent('fivem_dogwalker:updateData', -1, cachedData)
	elseif data['action'] == 'return_dead_dog' then
		cachedData[data['house']]['dog_state'] = 'dead'
		TriggerClientEvent('fivem_dogwalker:updateData', -1, cachedData)
	end
end)

ESX.RegisterServerCallback('fivem_dogwalker:hasBag', function(source, cb)
   	local Player = ESX.GetPlayerFromId(source)
	local bag = Player.getInventoryItem('blackplasticbag')
	if bag.count > 0 then 
		Player.removeInventoryItem('blackplasticbag', 1)
		cb(true)
	else
		cb(false)
	end
end)

Citizen.CreateThread(function()
	while true do
		local currentTime = os.time()
		for k,v in pairs(cachedData) do
			Wait(100)
			if v['dog_state'] ~= 'dead' then
				local diff = math.floor(os.difftime(currentTime, v['time']))
				if v['dog_state'] == 'out' then
					if (diff / 60) / 60 > Config.ResetTime then -- 2 hours then reset if dog isnt back
						cachedData[k] = nil 
						TriggerClientEvent('fivem_dogwalker:clientEvent', -1, cachedData)
					end
				elseif v['dog_state'] == 'home' then
					if diff / 60 > Config.BackOnTheMarketTime then  -- 45min then back on the market
						cachedData[k] = nil 
						TriggerClientEvent('fivem_dogwalker:clientEvent', -1, cachedData)
					end
				end
			end
		end
		Citizen.Wait(1000)
	end
end)