ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterServerEvent('esx_policejob:giveWeapon')
AddEventHandler('esx_policejob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weapon, ammo)
end)

RegisterServerEvent('esx_policejob:confiscatePlayerItem')
AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	--[[if sourceXPlayer.job.name ~= 'police' then
		print(('esx_policejob: %s attempted to confiscate!'):format(xPlayer.identifier))
		return
	end]]

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)
		--sourceXPlayer.addInventoryItem   ('clip', 1)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
	end
end)

RegisterServerEvent('esx_policejob:lyfter')
AddEventHandler('esx_policejob:lyfter', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('esx_policejob:upplyft', targetPlayer.source, source)
end)

RegisterServerEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target)
  --TriggerClientEvent('esx_handcuffs:cuff', source)
  TriggerClientEvent('esx_policejob:handcuff', target)
end)

RegisterServerEvent('esx_policejob:unhandcuff')
AddEventHandler('esx_policejob:unhandcuff', function(source)
  TriggerClientEvent('esx_handcuffs:uncuff', source)
end)

RegisterServerEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	TriggerClientEvent('esx_policejob:drag', target, source)
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
  TriggerClientEvent('esx_policejob:putInVehicle', target)
end)

RegisterServerEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
  TriggerClientEvent('esx_policejob:OutVehicle', target)
end)

RegisterServerEvent('esx_policejob:getStockItem')
AddEventHandler('esx_policejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)

end)

RegisterServerEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

	end)

end)

ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target)

	if Config.EnableESXIdentity then

		local xPlayer = ESX.GetPlayerFromId(target)

		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)

	MySQL.Async.fetchAll(
	    'SELECT * FROM fine_types WHERE category = @category',
	    {
		    ['@category'] = category
	    },
	    function(fines)
		    cb(fines)
	    end
	)
  
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)

	if Config.EnableESXIdentity then
  
	    MySQL.Async.fetchAll(
		    'SELECT * FROM owned_vehicles',
		    {},
		    function(result)
  
		        local foundIdentifier = nil
  
		        for i=1, #result, 1 do
  
			        local vehicleData = json.decode(result[i].vehicle)
  
			        if vehicleData.plate == plate then
			            foundIdentifier = result[i].owner
			            break
			        end
  
		        end
  
		        if foundIdentifier ~= nil then
  
			        MySQL.Async.fetchAll(
			            'SELECT * FROM users WHERE identifier = @identifier',
			            {
				            ['@identifier'] = foundIdentifier
			            },
			            function(result)
  
				            local ownerName = result[1].firstname .. " " .. result[1].lastname
  
				            local infos = {
				                plate = plate,
				                owner = ownerName,
				                identifier = foundIdentifier,
								name = result[1].name
				            }
  
				            cb(infos)
  
			            end
			        )
  
		        else
  
			        local infos = {
			            plate = plate
			        }
  
			        cb(infos)
  
		        end
  
		    end
	    )
  
	else
  
	    MySQL.Async.fetchAll(
		    'SELECT * FROM owned_vehicles',
		    {},
		    function(result)
  
		        local foundIdentifier = nil
  
		        for i=1, #result, 1 do
  
			        local vehicleData = json.decode(result[i].vehicle)
  
			        if vehicleData.plate == plate then
			            foundIdentifier = result[i].owner
			            break
			        end
  
		        end
  
		        if foundIdentifier ~= nil then
  
			        MySQL.Async.fetchAll(
			            'SELECT * FROM users WHERE identifier = @identifier',
			            {
				            ['@identifier'] = foundIdentifier
			            },
			            function(result)
  
				            local infos = {
				                plate = plate,
				                owner = result[1].name
				            }
  
				            cb(infos)
  
			            end
			        )
  
		        else
  
			        local infos = {
			            plate = plate
			        }
  
			        cb(infos)
  
		        end
   
		    end
	    )
  
	end
  
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)

	end)

end)

ESX.RegisterServerCallback('esx_policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

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

ESX.RegisterServerCallback('esx_policejob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

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

ESX.RegisterServerCallback('esx_policejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_policejob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	end

	-- Weapon
	if type == 1 then
		if xPlayer.getMoney() >= selectedWeapon.price then
			xPlayer.removeMoney(selectedWeapon.price)
			xPlayer.addWeapon(weaponName, 100)

			cb(true)
		else
			cb(false)
		end

	-- Weapon Component
	elseif type == 2 then
		local price = selectedWeapon.components[weaponComponent]
		local weaponNum, weapon = ESX.GetWeapon(weaponName)

		local component = weapon.components[componentNum]

		if component then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeaponComponent(weaponName, component.name)

				cb(true)
			else
				cb(false)
			end
		else
			print(('esx_policejob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
			cb(false)
		end
	end
end)

RegisterServerEvent('esx_policejob_brottsregister:add')
AddEventHandler('esx_policejob_brottsregister:add', function(id, reason)
  local identifier = ESX.GetPlayerFromId(id).identifier
  local date = os.date("%Y-%m-%d")
  MySQL.Async.fetchAll(
    'SELECT firstname, lastname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if result[1] ~= nil then
      MySQL.Async.execute('INSERT INTO qalle_brottsregister (identifier, firstname, lastname, dateofcrime, crime) VALUES (@identifier, @firstname, @lastname, @dateofcrime, @crime)',
        {
          ['@identifier']   = identifier,
          ['@firstname']    = result[1].firstname,
          ['@lastname']     = result[1].lastname,
          ['@dateofcrime']  = date,
          ['@crime']        = reason,
        }
      )
    end
  end)
end)

function getIdentity(source)
  local identifier = GetPlayerIdentifiers(source)[1]
  local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
  if result[1] ~= nil then
    local identity = result[1]

    return {
      identifier = identity['identifier'],
      firstname = identity['firstname'],
      lastname = identity['lastname'],
      dateofbirth = identity['dateofbirth'],
      sex = identity['sex'],
      height = identity['height']
    }
  else
    return nil
  end
end

ESX.RegisterServerCallback('esx_policejob_brottsregister:grab', function(source, cb, target)
  local identifier = ESX.GetPlayerFromId(target).identifier
  local name = getIdentity(target)
  MySQL.Async.fetchAll("SELECT identifier, firstname, lastname, dateofcrime, crime FROM `qalle_brottsregister` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if identifier ~= nil then
        local crime = {}

      for i=1, #result, 1 do
        table.insert(crime, {
          crime = result[i].crime,
          name = result[i].firstname .. ' - ' .. result[i].lastname,
          date = result[i].dateofcrime,
        })
      end
      cb(crime)
    end
  end)
end)

RegisterServerEvent('esx_policejob_brottsregister:remove')
AddEventHandler('esx_policejob_brottsregister:remove', function(id, crime)
  local identifier = ESX.GetPlayerFromId(id).identifier
  MySQL.Async.fetchAll(
    'SELECT firstname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if (result[1] ~= nil) then
      MySQL.Async.execute('DELETE FROM qalle_brottsregister WHERE identifier = @identifier AND crime = @crime',
      {
        ['@identifier']    = identifier,
        ['@crime']     = crime
      }
    )
    end
  end)
end)

ESX.RegisterServerCallback('esx_policejob:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)

end)

ESX.RegisterServerCallback('esx_policejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_policejob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_policejob:spawned')
AddEventHandler('esx_policejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_policejob:forceBlip')
AddEventHandler('esx_policejob:forceBlip', function()
	TriggerClientEvent('esx_policejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)

RegisterServerEvent('esx_policejob:message')
AddEventHandler('esx_policejob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('esx_policejob:getKey')
AddEventHandler('esx_policejob:getKey', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local getKeyQuantity = xPlayer.getInventoryItem('policecard').count

	if getKeyQuantity >= 1 then
		TriggerClientEvent('esx:showNotification', _source, 'Du har redan ett nyckelkort.')
	else
	  xPlayer.addInventoryItem('policecard', 1)		
		TriggerClientEvent('esx:showNotification', _source, 'Du tog ut ett nyckelkort.')
	end
end)

RegisterServerEvent('esx_policejob:putKey')
AddEventHandler('esx_policejob:putKey', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local removeKeyQuantity = xPlayer.getInventoryItem('policecard').count
	
	if removeKeyQuantity >= 1 then
		xPlayer.removeInventoryItem('policecard', 1)
		TriggerClientEvent('esx:showNotification', _source, 'Du lämnade in ditt nyckelkort.')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Du har inget nyckelkort.')
	end
end)