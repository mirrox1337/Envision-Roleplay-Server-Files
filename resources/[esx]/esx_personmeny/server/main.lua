
local Handcuffed = {}

local ESX = nil
TriggerEvent("esx:getSharedObject", function(library) ESX = library end)


RegisterServerEvent('menu:Lyft')
AddEventHandler('menu:Lyft', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)
	TriggerClientEvent('menu:bliLyft', targetPlayer.source, source)
	TriggerClientEvent('menu:lyftPerson', source, target)
end)

RegisterServerEvent("menu:removeItem")
AddEventHandler("menu:removeItem", function(item, count)
	local player = ESX.GetPlayerFromId(source)
	player.removeInventoryItem(item, count)
end)

ESX.RegisterServerCallback('menu:getPlayerData', function(source, cb, target)

	local xPlayer = ESX.GetPlayerFromId(target)
  
	local data = {
		name = GetPlayerName(target),
		inventory = xPlayer.inventory,
		accounts = xPlayer.accounts,
		money = xPlayer.get('money'),
		weapons = xPlayer.loadout
	}
  
	cb(data)
  end)

RegisterServerEvent('menu:taItem')
AddEventHandler('menu:taItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if itemType == 'item_standard' then
		local label = sourceXPlayer.getInventoryItem(itemName).label
        local playerItemCount = targetXPlayer.getInventoryItem(itemName).count

        if playerItemCount >= amount then
			local targetItem = targetXPlayer.getInventoryItem(itemName)
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)

			if targetItem.count > 0 and targetItem.count <= amount then

				if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then

					TriggerClientEvent('esx:showNotification', _source, 'Ogiltigt summa...')

				else

					targetXPlayer.removeInventoryItem(itemName, amount)
					sourceXPlayer.addInventoryItem(itemName, amount)
					TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Du tog <span style="color:yellow">' .. amount .. ' ' .. sourceItem.label .. '</span> från personen.')
					TriggerClientEvent('esx:showNotification', targetXPlayer.source, 'Någon tog <span style="color:yellow">' .. amount .. ' ' .. sourceItem.label .. '</span> från dig.')
				end
			else
				TriggerClientEvent('esx:showNotification', _source, 'Ogiltigt summa...')
			end
		end

	elseif itemType == 'item_money' then
		if targetXPlayer.getMoney() >= amount then
			targetXPlayer.removeMoney(amount)
			sourceXPlayer.addMoney(amount)

			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Du tog <span style="color:green">' .. amount .. ' SEK</span> från personen.')
			TriggerClientEvent('esx:showNotification', targetXPlayer.source, 'Någon tog <span style="color:green">' .. amount .. ' SEK </span> från dig.')
		end

	elseif itemType == 'item_weapon' then

			targetXPlayer.removeWeapon(itemName)
			sourceXPlayer.addWeapon(itemName, amount)
		
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Du snodde ' .. ESX.GetWeaponLabel(itemName) .. ' från ' .. targetXPlayer.name, 'success', 4500)
			TriggerClientEvent('esx:showNotification', targetXPlayer.source, ' Snodde ' .. ESX.GetWeaponLabel(itemName) .. ' från dig', 'error', 4500)
		
	end
end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

ESX.RegisterServerCallback('menu:requestPlayerCars', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent("menu:giveMoney")
AddEventHandler("menu:giveMoney", function(target, amount)
	local player = ESX.GetPlayerFromId(source)
	local player2 = ESX.GetPlayerFromId(target)
	if tonumber(player.getMoney()) >= tonumber(amount) then
		player.removeMoney(amount)
		player2.addMoney(amount)
		TriggerClientEvent("esx:showNotification", source, "Du gav iväg " .. amount .. "kr.")
		TriggerClientEvent("esx:showNotification", target, "Du fick " .. amount .. "kr.")
	else
		TriggerClientEvent("esx:showNotification", source, "Du har inte " .. amount .. " SEK på dig.")
	end
end)

RegisterServerEvent("blackmarket:buy")
AddEventHandler("blackmarket:buy", function(data)
	local player = ESX.GetPlayerFromId(source)

	if player.getMoney() >= data.price then
		player.removeMoney(data.price)
		if data.type == "item" then
			player.addInventoryItem(data.item, 1)
		elseif data.type == "weapon" then
			player.addWeapon(data.item, 44)
			print("BLACKMARKET: " .. GetPlayerName(player) .. " köpte " .. data.item)
		end
	else
		TriggerClientEvent("esx:showNotification", source, "Du har inte tillräckligt med pengar på dig.")
	end
end)

