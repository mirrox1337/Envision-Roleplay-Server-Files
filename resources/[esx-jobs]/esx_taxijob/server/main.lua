local ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

TriggerEvent('esx_phone:registerNumber', 'taxi', 'Taxi', true, true)
TriggerEvent('esx_society:registerSociety', 'taxi', 'taxi', 'society_taxi', 'society_taxi', 'society_taxi', {type = 'private'})

RegisterServerEvent('nxrp-taxi:getStockItem')
AddEventHandler('nxrp-taxi:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, 'Ogiltigt nummer...')
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent("nxrp-taxi:updateStorage", -1)
				TriggerClientEvent('esx:showNotification', _source, 'Du tog ut ' .. count .. ' ' .. inventoryItem.label .. ' från förrådet.')
			end
		else
			TriggerClientEvent('esx:showNotification', _source, 'Ogiltigt nummer...')
		end
	end)
end)

RegisterServerEvent('nxrp-taxi:putStockItems')
AddEventHandler('nxrp-taxi:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent("nxrp-taxi:updateStorage", -1)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du lade ' .. count .. ' ' .. inventoryItem.label .. ' i förrådet.')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Ogiltigt nummer...')
		end
	end)
end)

local active = false

ESX.RegisterServerCallback('nxrp-taxi:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)

		TriggerEvent('esx_datastore:getSharedDataStore', 'society_taxi', function(store)
			local weapons = store.get('weapons')
	
			if weapons == nil then
				weapons = {}
			end
	
			cb(inventory.items, weapons, active)
		end)
	end)
end)

ESX.RegisterServerCallback('nxrp-taxi:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

ESX.RegisterServerCallback('nxrp-taxi:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_taxi', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('nxrp-taxi:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_taxi', function(store)
		TriggerClientEvent("nxrp-taxi:updateStorage", -1)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('nxrp-taxi:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_taxi', function(store)
		TriggerClientEvent("nxrp-taxi:updateStorage", -1)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

RegisterServerEvent("nxrp-taxi:active")
AddEventHandler("nxrp-taxi:active", function(bool)
	active = bool
end)

RegisterServerEvent("nxrp-taxi:giveReward")
AddEventHandler("nxrp-taxi:giveReward", function()
	local player = ESX.GetPlayerFromId(source)
	local random = math.random(12, 30)
	player.addMoney(random)
	TriggerClientEvent("esx:showNotification", source, "Du fick " .. random .. "kr")
end)