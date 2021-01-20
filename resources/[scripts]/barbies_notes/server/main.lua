ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('barbies_notes:saveNote')
AddEventHandler('barbies_notes:saveNote', function(label, subject, id)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if id ~= 'nil' and id ~= nil then
		MySQL.Async.execute('Update notes SET charid = @charid, label = @label, subject = @subject, x = @x, y = @y, z = @z WHERE id = @id',
		{
			['@id']  = id,
			['@charid']  = xPlayer.identifier,
			['@label']   = label,
			['@subject'] = subject,
			['@x'] 		 = nil,
			['@y'] 		 = nil,
			['@z'] 		 = nil
		})
	else
		MySQL.Async.execute('INSERT INTO notes (charid, label, subject, x, y, z) VALUES (@charid, @label, @subject, @x, @y, @z)',
		{
			['@charid']  = xPlayer.identifier,
			['@label']   = label,
			['@subject'] = subject,
			['@x'] 		 = nil,
			['@y'] 		 = nil,
			['@z'] 		 = nil
		})		
	end
	TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du sparade en anteckning')
end)

RegisterServerEvent('barbies_notes:dropNote')
AddEventHandler('barbies_notes:dropNote', function(label, subject, x, y, z, id)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	if id ~= 'nil' and id ~= nil then
		MySQL.Async.execute('Update notes SET charid = @charid, label = @label, subject = @subject, x = @x, y = @y, z = @z WHERE id = @id',
		{
			['@id']  = id,
			['@charid']  = nil,
			['@label']   = label,
			['@subject'] = subject,
			['@x'] 		 = x,
			['@y'] 		 = y,
			['@z'] 		 = z
		})
	else
		MySQL.Async.execute('INSERT INTO notes (charid, label, subject, x, y, z) VALUES (@charid, @label, @subject, @x, @y, @z)',
		{
			['@charid']  = nil,
			['@label']   = label,
			['@subject'] = subject,
			['@x'] 		 = x,
			['@y'] 		 = y,
			['@z'] 		 = z
		})
	end
    
    for i=1, #xPlayers, 1 do
        TriggerClientEvent('barbies_notes:reSync', xPlayers[i], id)
    end
	TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du kastade en anteckning')
end)

RegisterServerEvent('barbies_notes:deleteNote')
AddEventHandler('barbies_notes:deleteNote', function(id)
	if id ~= 'nil' and id ~= nil then
		MySQL.Async.execute('DELETE FROM notes WHERE id = @id',
		{
			['@id']  = id
		})
	end
end)

RegisterServerEvent('barbies_notes:removeSyncedNote')
AddEventHandler('barbies_notes:removeSyncedNote', function(x, y, z)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('barbies_notes:removeSyncedNote', xPlayers[i], x, y, z)
		TriggerClientEvent('barbies_notes:reSync', xPlayers[i], id)
    end
end)

RegisterServerEvent('barbies_notes:createSyncedNote')
AddEventHandler('barbies_notes:createSyncedNote', function(x, y, z)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
        TriggerClientEvent('barbies_notes:createSyncedNote', xPlayers[i], x, y, z)
    end
end)

ESX.RegisterServerCallback('barbies_notes:fetchNotes', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)	
	MySQL.Async.fetchAll('SELECT * FROM notes WHERE charid = @charid', {
		['@charid'] = xPlayer.identifier
	}, function(result)
		local notes = {}
		for i=1, #result, 1 do
			table.insert(notes, {
				id         = result[i].id,
				label      = result[i].label,
			})
		end
		cb(notes)
	end)
end)

ESX.RegisterServerCallback('barbies_notes:fetchNotesOnGround', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)	
	MySQL.Async.fetchAll('SELECT * FROM notes', {}, function(notes)
		if notes[1] ~= nil then
            cb(notes, id)
        else
            cb(nil)
        end
	end)
end)

RegisterServerEvent('barbies_notes:foundNote')
AddEventHandler('barbies_notes:foundNote', function(id)
	local src = source
	local identifier = ESX.GetPlayerFromId(src).identifier
	MySQL.Async.execute('UPDATE notes SET charid = @charid, x = @x, y = @y, z = @z WHERE id = @id', {['@charid'] = identifier, ['@id'] = id, ['@x'] = nil, ['@y'] = nil, ['@z'] = nil})
	--local xPlayers = ESX.GetPlayers()
	--for i=1, #xPlayers, 1 do
	   
	--end
	TriggerClientEvent('barbies_notes:foundNote', source, id)
end)


ESX.RegisterServerCallback('barbies_notes:showNote', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)	
	MySQL.Async.fetchAll('SELECT * FROM notes WHERE id = @id', {
		['@id'] = id
	}, function(result)
		local note = {}
		for i=1, #result, 1 do
			table.insert(note, {
				id         = result[i].id,
				label      = result[i].label,
				subject    = result[i].subject,
			})
		end
		cb(note)
	end)
end)