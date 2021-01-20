local ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

RegisterServerEvent("slizzarn-parkstadning:getPaid")
AddEventHandler("slizzarn-parkstadning:getPaid", function(reward)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addMoney(reward)
end)