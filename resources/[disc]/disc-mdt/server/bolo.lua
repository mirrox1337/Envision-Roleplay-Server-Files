ESX.RegisterServerCallback('disc-mdt:setBolo', function(source, cb, data)
    print(data.bolo)
    MySQL.Async.execute('UPDATE owned_vehicles SET bolo = @bolo WHERE plate = @plate', {
        ['@plate'] = data.plate,
        ['@bolo'] = data.bolo
    }, function()
        cb(true)
        local msg = "Efterlysning på " .. data.plate
        if data.bolo then
            msg = msg .. ' Utfärdad'
        else
            msg = msg .. ' Tog Bort'
        end
        TriggerClientEvent('disc-mdt:addNotification', -1, {
            message = msg
        })
    end)
end)