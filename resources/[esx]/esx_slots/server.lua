-- This resource was made by plesalex100#7387
-- Please respect it, don't repost it without my permission
-- This Resource started from: https://codepen.io/AdrianSandu/pen/MyBQYz
-- ESX Version: saNhje & wUNDER

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_slots:BetsAndMoney")
AddEventHandler("esx_slots:BetsAndMoney", function(bets)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    if xPlayer then
        if bets % 50 == 0 and bets >= 50 then
            if xPlayer.getMoney() >= bets then
                xPlayer.removeMoney(bets)
                TriggerClientEvent("esx_slots:UpdateSlots", _source, bets)
            else
                TriggerClientEvent('esx:showNotification', _source, "Inte tillräckligt med pengar")
            end
        else
            TriggerClientEvent('esx:showNotification', _source, "Sätt in jämna summor a. 50kr. ex: 100, 350, 2500")
        end

    end
end)

RegisterServerEvent("esx_slots:PayOutRewards")
AddEventHandler("esx_slots:PayOutRewards", function(amount)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    if xPlayer then
        amount = tonumber(amount)
        if amount > 0 then
            xPlayer.addMoney(amount)
            TriggerClientEvent('esx:showNotification', _source, "Du vann $"..amount.." snyggt !")
        else
            TriggerClientEvent('esx:showNotification', _source, "Tyvärr, är pengarna slut Bättre lycka nästa gång.")
        end
    end
end)
