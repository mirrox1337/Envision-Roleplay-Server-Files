-- ================================================================================================--
-- ==                                VARIABLES - DO NOT EDIT                                     ==--
-- ================================================================================================--
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount))
    end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bank').money
    if amount == nil or amount <= 0 or amount > base then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
    end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    TriggerClientEvent('currentbalance1', _source, balance)

end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil then
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money
        if tonumber(_source) == tonumber(to) then
            -- advanced notification with bank icon
            TriggerClientEvent('esx:showAdvancedNotification', _source, 'Nordea',
                               'Bank Överföring',
                               '~r~Du kan inte skicka pengar till dig själv!',
                               'CHAR_BANK_MAZE', 9)
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <=
                0 then
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Nordea', 'Bank Överföring',
                                   '~r~Saknas Täckning!',
                                   'CHAR_BANK_MAZE', 9)
            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Nordea', 'Bank Överföring',
                                   'Du förde över ~g' .. amountt ..
                                    'kr~s~ Till ~b~' .. to .. ' .',
                                   'CHAR_BANK_MAZE', 9)
                TriggerClientEvent('esx:showAdvancedNotification', to, 'Nordea',
                                   'Bank Överföring', 'Du har fått en betalning på ~g~' ..
                                       amountt .. 'kr ~s~ från ~b~' .. _source ..
                                       ' .', 'CHAR_BANK_MAZE', 9)
            end

        end
    end

end)
