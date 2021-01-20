ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Carcleankit
ESX.RegisterUsableItem('carcleankit', function(source)
	TriggerClientEvent('esx_extraitems:carcleankit', source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('carcleankit', 1)
end)

--Cigarette
ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
		if lighter.count > 0 then
			xPlayer.removeInventoryItem('cigarett', 1)
			TriggerClientEvent('esx_cigarett:startSmoke', source)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Du har ingen ~r~tändare'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ingen tändare'})
		end
end)

ESX.RegisterUsableItem('cigaretter', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
    TriggerClientEvent('esx_cigarett:openCigarettes', source)
end)

--Snus
ESX.RegisterUsableItem('snus', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerClientEvent('esx_snus:useSnus', source)
    Citizen.Wait(1500)
    xPlayer.removeInventoryItem('snus', 1)

end)

--Snusdosa
ESX.RegisterUsableItem('snusdosa', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_snus:openSnusdosa', source)
    xPlayer.removeInventoryItem('snusdosa', 1)
    xPlayer.addInventoryItem('snus', 25)

end)

RegisterServerEvent('mirrox-items:openCigaretter')
AddEventHandler('mirrox-items:openCigaretter', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cigaretter', 1)
    xPlayer.addInventoryItem('cigarett', 20)
end)