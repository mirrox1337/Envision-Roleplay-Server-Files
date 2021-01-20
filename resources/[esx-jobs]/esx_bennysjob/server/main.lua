local ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

TriggerEvent('esx_phone:registerNumber', 'bennys', 'Bennys', true, true)
TriggerEvent('esx_society:registerSociety', 'bennys', 'bennys', 'society_bennys', 'society_bennys', 'society_bennys', {type = 'private'})


RegisterServerEvent('nxrp-bennys:getStockItem')
AddEventHandler('nxrp-bennys:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bennys', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, 'Ogiltigt nummer...')
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent("nxrp-bennys:updateStorage", -1)
				TriggerClientEvent('esx:showNotification', _source, 'Du tog ut ' .. count .. ' ' .. inventoryItem.label .. ' från förrådet.')
			end
		else
			TriggerClientEvent('esx:showNotification', _source, 'Ogiltigt nummer...')
		end
	end)
end)

RegisterServerEvent('nxrp-bennys:putStockItems')
AddEventHandler('nxrp-bennys:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bennys', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent("nxrp-bennys:updateStorage", -1)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du lade ' .. count .. ' ' .. inventoryItem.label .. ' i förrådet.')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Ogiltigt nummer...')
		end
	end)
end)


ESX.RegisterServerCallback('nxrp-bennys:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bennys', function(inventory)

		TriggerEvent('esx_datastore:getSharedDataStore', 'society_bennys', function(store)
			local weapons = store.get('weapons')
	
			if weapons == nil then
				weapons = {}
			end
	
			cb(inventory.items, weapons)
		end)
	end)
end)

ESX.RegisterServerCallback('nxrp-bennys:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

ESX.RegisterServerCallback('nxrp-bennys:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_bennys', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('nxrp-bennys:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_bennys', function(store)
		TriggerClientEvent("nxrp-bennys:updateStorage", -1)
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

ESX.RegisterServerCallback('nxrp-bennys:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_bennys', function(store)
		TriggerClientEvent("nxrp-bennys:updateStorage", -1)

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

RegisterServerEvent("nxrp-bennys:inKopning")
AddEventHandler("nxrp-bennys:inKopning", function(item, label, count, price, job)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
		if price < account["money"] then
			account.removeMoney(price)
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_' .. job, function(inventory)
				inventory.addItem(item, count)
				TriggerClientEvent('esx:showNotification', source, 'Du köpte in <span style="color:yellow">' .. count .. ' ' .. label .. '</span> till företaget. Du hittar det du köpt i företagets förråd.')
			end)
		else
			TriggerClientEvent('esx:showNotification', source, 'Företaget har inte tillräckligt med pengar.')
		end
	end)
end)
