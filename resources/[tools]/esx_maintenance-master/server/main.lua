ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getPlayerFromId(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifier(identifiers)
    return player
end

function getIdentifier(id)
    for _, v in ipairs(id) do
        return v
    end
end

AddEventHandler('playerConnecting', function(peerName, setKickReason)
    local numIds = GetNumPlayerIdentifiers(source)
	for i,allowedID in ipairs(cfg.AllowedIDs) do
        for i = 0, numIds-3 do
            if cfg.isOnMaintenance == true and getPlayerFromId(source) ~= allowedID then
                print('-----------------ESX MAINTENANCE SYSTEM-----------')
                print('Dropping Connection for: [' .. peerName ..']      ')
                print('-----------------ESX MAINTENANCE SYSTEM-----------')
                
				setKickReason('Serverunderhåll: Vi håller på och flyttar till en ny host. Vi annonserar ut på våran Discord när vi klara!')
				CancelEvent()
			end
		end
    end
end)
