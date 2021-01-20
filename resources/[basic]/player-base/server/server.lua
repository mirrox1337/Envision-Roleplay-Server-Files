RegisterServerEvent('handsup:getSurrenderStatus')
AddEventHandler('handsup:getSurrenderStatus', function(event,targetID)
	TriggerClientEvent("handsup:getSurrenderStatusPlayer",targetID,event,source)
end)

RegisterServerEvent('handsup:sendSurrenderStatus')
AddEventHandler('handsup:sendSurrenderStatus', function(event,targetID,handsup)
	TriggerClientEvent(event,targetID,handsup)
end)

RegisterServerEvent('handsup:reSendSurrenderStatus')
AddEventHandler('handsup:reSendSurrenderStatus', function(event,targetID,handsup)
	TriggerClientEvent(event,targetID,handsup)
end)