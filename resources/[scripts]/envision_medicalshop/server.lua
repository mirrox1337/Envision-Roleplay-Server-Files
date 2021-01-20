ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('strandsatt_medicalshop:buyItem')
AddEventHandler('strandsatt_medicalshop:buyItem', function(item, cost)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = tonumber(cost)
	if(xPlayer.getMoney() >= price) then
		xPlayer.removeMoney(price)
		xPlayer.addInventoryItem(item, 1)
	else
		TriggerClientEvent('esx:showNotification', source, "Du har inte tillräckligt med ~r~pengar")
	end		
end)