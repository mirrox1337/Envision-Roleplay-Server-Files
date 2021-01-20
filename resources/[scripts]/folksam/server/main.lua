local ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)


TriggerEvent('esx_phone:registerNumber', 'forsakring', 'Folksam', true, true)
TriggerEvent('esx_society:registerSociety', 'forsakring', 'forsakring', 'society_forsakring', 'society_forsakring', 'society_forsakring', {type = 'private'})

RegisterServerEvent('nxrp-forsakringsbolaget:forsakraFordon')
AddEventHandler('nxrp-forsakringsbolaget:forsakraFordon', function(plate, insure, model)
	local player = ESX.GetPlayerFromId(source)
	if insure then
		MySQL.Sync.execute("UPDATE owned_vehicles SET forsakrad = @insure WHERE plate= @plate",{
			['@insure'] = 1, ['@plate'] = plate}
		)
		MySQL.Async.fetchAll('SELECT owner, vehicle FROM owned_vehicles WHERE plate = @plate', {
			['@plate'] = plate
		}, function(result)
			if result[1] ~= nil then
				--discordMSG(player.identifier, result[1]["owner"], model, plate)
			end
		end)
	else
		MySQL.Sync.execute("UPDATE owned_vehicles SET forsakrad = @insure WHERE plate= @plate",{
			['@insure'] = 0, ['@plate'] = plate}
		)
	end
end)

--discordMSG = function(source, customer, model, plate)
	--local sellerName = getIdentity(source)
	--local customerName = getIdentity(customer)
    --local date = os.date('%d/%m/%Y • %H:%M')
    --local embeds = {
        --{
            --["title"]= "Ett fordon försäkrades av " .. sellerName["firstname"] .. " " .. sellerName["lastname"],
            --["type"]="rich",
            --["color"] = 56108,
            --["description"] = "**Kund:** " .. customerName["firstname"] .. " " .. customerName["lastname"] .. "\n**Modell:** " .. model .. "\n**Registreringsnummer:** " .. plate .. "\n**Datum:** " .. date
        --}
    --}
	--PerformHttpRequest('https://canary.discordapp.com/api/webhooks/630431859393691658/VTcIO4NGEfISJjAe7eoow8vjBMg1FFAmE7siIgcXv6InJYmsRHyx6kGg3hZm79x6WkwW', function(err, text, headers) end, 'POST', json.encode({username = "Bokföring", embeds = embeds}), { ['Content-Type'] = 'application/json' })
--end

function getIdentity(source)
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = source})
	if result[1] ~= nil then
		local identity = result[1]
  
		return {
			job = identity['job'],
			firstname = identity['firstname'],
			lastname = identity['lastname']
		}
	else
		return nil
	end
  end 

ESX.RegisterServerCallback('nxrp-forsakringsbolaget:searchPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner, vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then
			local callback = {}
			table.insert(callback, {
				["props"] = json.decode(result[1]["vehicle"])
			})
			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)
				
				MySQL.Async.fetchAll('SELECT forsakrad FROM owned_vehicles WHERE plate = @plate', {
					['@plate'] = plate
				}, function(result3)
					if result3[1]["forsakrad"] then
						cb(callback, result2[1].firstname .. ' ' .. result2[1].lastname, true, true)
					else
						cb(callback, result2[1].firstname .. ' ' .. result2[1].lastname, true, false)
					end
				end)
			end)
		else
			cb(false, false, false)
		end
	end)
end)

function GetName(source)
	MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
		['@identifier'] = source
	}, function(result2)
		return (result2[1].firstname .. ' ' .. result2[1].lastname)
	end)
end


RegisterServerEvent('nxrp-forsakringsbolaget:getStockItem')
AddEventHandler('nxrp-forsakringsbolaget:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_forsakring', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, 'Ogiltigt nummer...')
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Du tog ut ' .. count .. ' ' .. inventoryItem.label .. ' från förrådet.')
			end
		else
			TriggerClientEvent('esx:showNotification', _source, 'Ogiltigt nummer...')
		end
	end)
end)

RegisterServerEvent('nxrp-forsakringsbolaget:putStockItems')
AddEventHandler('nxrp-forsakringsbolaget:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_forsakring', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du lade ' .. count .. ' ' .. inventoryItem.label .. ' i förrådet.')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Ogiltigt nummer...')
		end
	end)
end)

local active = false

ESX.RegisterServerCallback('nxrp-forsakringsbolaget:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_forsakring', function(inventory)

		TriggerEvent('esx_datastore:getSharedDataStore', 'society_forsakring', function(store)
			local weapons = store.get('weapons')
	
			if weapons == nil then
				weapons = {}
			end
	
			cb(inventory.items, weapons, active)
		end)
	end)
end)

ESX.RegisterServerCallback('nxrp-forsakringsbolaget:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

ESX.RegisterServerCallback('nxrp-forsakringsbolaget:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_forsakring', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('nxrp-forsakringsbolaget:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_forsakring', function(store)
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

ESX.RegisterServerCallback('nxrp-forsakringsbolaget:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_forsakring', function(store)

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

RegisterServerEvent("nxrp-forsakringsbolaget:active")
AddEventHandler("nxrp-forsakringsbolaget:active", function(bool)
	active = bool
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'forsakring')
	end
end)