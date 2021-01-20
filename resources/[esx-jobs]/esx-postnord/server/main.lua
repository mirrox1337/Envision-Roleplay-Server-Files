ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx-kocken-postnord:receiveMoney')
AddEventHandler('esx-kocken-postnord:receiveMoney', function()
    local _source = source
    local Player = ESX.GetPlayerFromId(_source)
    local moneytoget = math.random(50, 150)
    Player.addMoney(moneytoget)
    Player.addMoney(moneytoget)
    sendNotification(_source, 'Du klarade av körningen och tog emot ~g~'..moneytoget..' SEK')
end)


--notification
function sendNotification(xSource, message)
    TriggerClientEvent('notification', xSource, message)
end