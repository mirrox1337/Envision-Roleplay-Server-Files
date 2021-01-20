  ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'raddningstjansten', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'raddningstjansten', _U('alert_raddningstjansten'), true, true)
TriggerEvent('esx_society:registerSociety', 'raddningstjansten', 'raddningstjansten', 'society_raddningstjansten', 'society_raddningstjansten', 'society_raddningstjansten', {type = 'private'})

RegisterServerEvent('esx_raddningstjansten:giveWeapon')
AddEventHandler('esx_raddningstjansten:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'raddningstjansten' then
		xPlayer.addWeapon(weapon, ammo)
	else
		print(('esx_raddningstjansten: %s attempted to give weapon!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_raddningstjansten:OutVehicle')
AddEventHandler('esx_raddningstjansten:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'raddningstjansten' then
		TriggerClientEvent('esx_raddningstjansten:OutVehicle', target)
	end
end)

ESX.RegisterServerCallback('esx_raddningstjansten:buyfire', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('WEAPON_FIREEXTINGUISHER', 1)
	xPlayer.removeMoney(1000)
	exports['mythic_notify']:SendAlert('inform', ('Du köpte en brandsläckare för 1000kr'))
end)

ESX.RegisterServerCallback('esx_raddningstjansten:buyradio', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('radio', 1)
	xPlayer.removeMoney(500)
	exports['mythic_notify']:SendAlert('inform', ('Du köpte en radio för 500kr'))
end)

ESX.RegisterServerCallback('esx_raddningstjansten:buyammo', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('disc_ammo_fireextinguisher', 1)
	xPlayer.removeMoney(250)
	exports['mythic_notify']:SendAlert('inform', ('Du köpte pulver för 250kr'))
end)

ESX.RegisterServerCallback('esx_raddningstjansten:buyaxe', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('WEAPON_BATTLEAXE', 1)
	xPlayer.removeMoney(1000)
	exports['mythic_notify']:SendAlert('inform', ('Du köpte en yxa för 1000kr'))
end)

ESX.RegisterServerCallback('esx_raddningstjansten:buyflash', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('WEAPON_FLASHLIGHT', 1)
	xPlayer.removeMoney(500)
	exports['mythic_notify']:SendAlert('inform', ('Du köpte en ficklampa för 500kr'))
end)

ESX.RegisterServerCallback('esx_raddningstjansten:buycrow', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('WEAPON_CROWBAR', 1)
	xPlayer.removeMoney(500)
	exports['mythic_notify']:SendAlert('inform', ('Du köpte en kofot för 500kr'))
end)

ESX.RegisterServerCallback('esx_raddningstjansten:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_raddningstjansten', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)

end)

RegisterServerEvent('esx_raddningstjansten:spawned')
AddEventHandler('esx_raddningstjansten:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'raddningstjansten' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_raddningstjansten:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_raddningstjansten:forceBlip')
AddEventHandler('esx_raddningstjansten:forceBlip', function()
	TriggerClientEvent('esx_raddningstjansten:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_raddningstjansten:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_raddningstjansten:message')
AddEventHandler('esx_raddningstjansten:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)
