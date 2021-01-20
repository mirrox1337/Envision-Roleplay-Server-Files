ESX = nil
local cachedNames = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function GetCharacterName(source)
	local src = source
	if cachedNames[src] then
		return cachedNames[src] 

	else
		return 'maskerad individ'
	end
end

AddEventHandler('playerDropped', function(player)--should delete the player from the cachedtable when leaving server
    local src = source
	cachedNames[src] = nil
end)

RegisterServerEvent('olsson_3d:firstLoad')
AddEventHandler('olsson_3d:firstLoad', function(event, data)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    cachedNames[src] =  MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = Player['identifier']
    })
    cachedNames[src] = cachedNames[src][1]['firstname']..' '..cachedNames[src][1]['lastname']
end)


local logEnabled = false

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	local playerName = GetCharacterName(source)
	TriggerClientEvent("olsson:metext", -1, source, playerName, text)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
	if logEnabled then
		setLog(text, source)
	end
end)

RegisterServerEvent('olsson:bilcenter')
AddEventHandler('olsson:bilcenter', function(text)
	TriggerClientEvent('bilcentermeddelande', -1, text, source)
end)

RegisterServerEvent('olsson:bennys')
AddEventHandler('olsson:bennys', function(text)
	TriggerClientEvent('bennysmeddelande', -1, text, source)
end)

RegisterServerEvent('olsson:polisen')
AddEventHandler('olsson:polisen', function(text)
	TriggerClientEvent('polisenmeddelande', -1, text, source)
end)

RegisterServerEvent('olsson:sjukhus')
AddEventHandler('olsson:sjukhus', function(text)
	TriggerClientEvent('sjukhusmeddelande', -1, text, source)
end)

RegisterServerEvent('olsson:nattklubb')
AddEventHandler('olsson:nattklubb', function(text)
	TriggerClientEvent('nattklubbmeddelande', -1, text, source)
end)

RegisterServerEvent('olsson:securitas')
AddEventHandler('olsson:securitas', function(text)
	TriggerClientEvent('securitasmeddelande', -1, text, source)
end)

RegisterServerEvent('olsson:mekonomen')
AddEventHandler('olsson:mekonomen', function(text)
	TriggerClientEvent('mekonomenmeddelande', -1, text, source)
end)

RegisterServerEvent('olsson:taxi')
AddEventHandler('olsson:taxi', function(text)
	TriggerClientEvent('taximeddelande', -1, text, source)
end)

function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	local identifier = GetPlayerIdentifiers(source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
end