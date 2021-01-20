ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local stuff = {
    serverCooldown = 0,
    anyoneDoing = false,
    currentlyDoing = 0,
}

RegisterServerEvent('loffe_carthief:policeBlip')
AddEventHandler('loffe_carthief:policeBlip', function(coords)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('loffe_carthief:addBlip', xPlayers[i], coords)
            TriggerClientEvent('esx:showNotification', xPlayers[i], 'Pågående bilstöld! Kolla din karta för att se var bilen befinner sig!')
        end
    end
end)

RegisterServerEvent('loffe_carthief:updatePosition')
AddEventHandler('loffe_carthief:updatePosition', function(coords)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('loffe_carthief:addBlip', xPlayers[i], coords)
        end
    end
end)

RegisterServerEvent('loffe_carthief:removeBlip')
AddEventHandler('loffe_carthief:removeBlip', function()
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('loffe_carthief:removeBlip', xPlayers[i])
        end
    end
end)

RegisterServerEvent('loffe_carthief:finished')
AddEventHandler('loffe_carthief:finished', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local nextMission = os.time() + ((3600 * 24) * Config.DaysBetween)
    local randomWeapon = Config.Reward.Weapons[math.random(1, #Config.Reward.Weapons)]
    local randomMoney = math.random(Config.Reward.Money[1], Config.Reward.Money[2])
    xPlayer.addWeapon(('weapon_%s'):format(randomWeapon.Weapon), 100)
    xPlayer.addMoney(randomMoney)
    pNotify(src, ('Tack för hjälpen! <br>Som tack får du en <b>%s</b> och <b style="color:limegreen">%s</b> SEK'):format(randomWeapon.Title, randomMoney), 'success', 5000)

    stuff.anyoneDoing = false
    stuff.currentlyDoing = 0
    stuff.serverCooldown = os.time() + (60 * Config.ServerCooldown)

    MySQL.Async.execute("UPDATE users SET carthiefv2=@carthiefv2 WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@carthiefv2'] = nextMission})
end)

RegisterServerEvent('loffe_carthief:start')
AddEventHandler('loffe_carthief:start', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name ~= 'police' then
        local nextMission = os.time() + ((3600 * 24) * Config.DaysBetween)
        local police = 0
        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers do 
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if player.job.name == 'police' then
                police = police + 1
            end
        end

        if police >= Config.PoliceRequired then
            if stuff.serverCooldown <= os.time() and not stuff.anyoneDoing then
                MySQL.Async.fetchScalar('SELECT carthiefv2 FROM users WHERE identifier=@identifier', {['@identifier'] = xPlayer.identifier}, function(nextMission)
                    if os.time() >= nextMission then
                        stuff.currentlyDoing = src
                        stuff.anyoneDoing = true
                        TriggerClientEvent('loffe_carthief:startCl', src)
                    else
                        if Config.DaysBetween == 1 then
                            pNotify(src, ('Du måste vänta <b>%s dag</b> mellan varje uppdrag!'):format(Config.DaysBetween), 'error', 5000)
                        else
                            pNotify(src, ('Du måste vänta <b>%s dagar</b> mellan varje uppdrag!'):format(Config.DaysBetween), 'error', 5000)
                        end
                    end
                end)
            else
                pNotify(src, ('Någon har precis träffat %s, kom tillbaka senare.'):format(Config.Name), 'error', 5000)
            end
        else
            pNotify(src, 'Det är inte tillräckligt med poliser online!', 'error', 5000)
        end
    else
        pNotify(src, 'Du kan inte göra detta om du är polis!', 'error', 5000)
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    if stuff.currentlyDoing == src and stuff.anyoneDoing then
        stuff.anyoneDoing = false
        stuff.currentlyDoing = 0
        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers do 
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                TriggerClientEvent('loffe_carthief:removeBlip', xPlayers[i])
            end
        end
    end
end)

pNotify = function(src, message, messagetype, messagetimeout)
    TriggerClientEvent("pNotify:SendNotification", src, {
        text = (message),
        type = messagetype,
        timeout = (messagetimeout),
        layout = "bottomCenter",
        queue = "global"
    })
end