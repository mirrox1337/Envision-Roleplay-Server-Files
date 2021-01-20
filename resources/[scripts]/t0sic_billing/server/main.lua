ESX = nil

TriggerEvent("esx:getSharedObject", function(sharedObject) 
    ESX = sharedObject 
end)


RegisterServerEvent("t0sic-billing:insert")
AddEventHandler("t0sic-billing:insert", function(data, player)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local target = ESX.GetPlayerFromId(player)
    local result = GetCharacterName(xPlayer.identifier)
    local result2 = GetCharacterName(target.identifier)
    local xTarget = ESX.GetPlayerFromIdentifier(target)

    local name = result[1]["firstname"] .. ' ' .. result[1]["lastname"]
    local receiverName = result2[1]["firstname"] .. ' ' .. result2[1]["lastname"]

    TriggerClientEvent("esx:showNotification", src, "Du har skickat en faktura till ".. receiverName)
    TriggerClientEvent("esx:showNotification", target, "Du mottog en faktura av " .. name)
    
    MySQL.Async.execute("INSERT INTO user_billings (identifier, reason, date, amount, sender, senderName, receiverName, jobb) VALUES (@identifier, @reason, @date, @amount, @sender, @senderName, @receiverName, @jobb)",

        {
            ['@identifier']  = target["identifier"],
            ['@reason']      = data["reason"],
            ['@date']        = data["date"],
            ['@amount']      = data["sum"],
            ['@sender']      = xPlayer["identifier"],
            ["senderName"]   = name,
            ["receiverName"] = receiverName,
            ["jobb"]         = xPlayer.getJob().name

        }
    )
end)

RegisterServerEvent("t0sic-billing:hospital1")
AddEventHandler("t0sic-billing:hospital1", function(reason, sum)
    local target = ESX.GetPlayerFromId(source)
    local result2 = GetCharacterName(target.identifier)
    local xTarget = ESX.GetPlayerFromIdentifier(target)

    local receiverName = result2[1]["firstname"] .. ' ' .. result2[1]["lastname"]

    TriggerClientEvent("esx:showNotification", target, "Du mottog en faktura av Sjukhuset")
    
    MySQL.Async.execute("INSERT INTO user_billings (identifier, reason, amount, sender, senderName, receiverName, jobb) VALUES (@identifier, @reason, @date, @amount, @sender, @senderName, @receiverName, @jobb)",

        {
            ['@identifier']  = target["identifier"],
            ['@reason']      = reason,
            ['@amount']      = sum,
            ['@sender']      = 'Sjukhuset',
            ["senderName"]   = 'Gunnel',
            ["receiverName"] = receiverName,
            ["jobb"]         = ambulance

        }
    )
end)

RegisterServerEvent("t0sic-billing:hospital2")
AddEventHandler("t0sic-billing:hospital2", function(reason, sum, player)
    local target = ESX.GetPlayerFromId(player)
    local result2 = GetCharacterName(target.identifier)
    local xTarget = ESX.GetPlayerFromIdentifier(target)

    local receiverName = result2[1]["firstname"] .. ' ' .. result2[1]["lastname"]

    TriggerClientEvent("esx:showNotification", target, "Du mottog en faktura av Sjukhuset")
    
    MySQL.Async.execute("INSERT INTO user_billings (identifier, reason, amount, sender, senderName, receiverName, jobb) VALUES (@identifier, @reason, @date, @amount, @sender, @senderName, @receiverName, @jobb)",

        {
            ['@identifier']  = target["identifier"],
            ['@reason']      = reason,
            ['@amount']      = sum,
            ['@sender']      = 'Sjukhuset',
            ["senderName"]   = 'Gunnel',
            ["receiverName"] = receiverName,
            ["jobb"]         = ambulance

        }
    )
end)


ESX.RegisterServerCallback("t0sic-billing:getCharacterNames", function(source, cb, receiver)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local receiverUser = ESX.GetPlayerFromId(receiver)

    local receiverCharacter = GetCharacterName(receiverUser.identifier)
    local senderCharacter = GetCharacterName(xPlayer.identifier)
    
    cb(senderCharacter, receiverCharacter)

end)


ESX.RegisterServerCallback("t0sic-billing:fetchBillings", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT * FROM user_billings WHERE identifier = @identifier", 
    {
        ['@identifier'] = xPlayer["identifier"]
    
    }, function(result)
        local bills = {}


        for i=1, #result, 1 do
            table.insert(bills, {
                id              = result[i]["id"],
                reason          = result[i]["reason"],
                date            = result[i]["date"],
                amount          = result[i]["amount"],
                identifier      = result[i]["identifier"],
                sender          = result[i]["sender"],
                senderName      = result[i]["senderName"],
                receiverName    = result[i]["receiverName"],
                jobb            = result[i]["jobb"]
                
            })
        end
        cb(bills)
    end)
end)

RegisterServerEvent("t0sic-billing:payBill")
AddEventHandler("t0sic-billing:payBill", function(id, price)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll('SELECT * FROM user_billings WHERE id = @id', {
        ['@id'] = id
    }, function(result)


    local targetType = result[1].target_type
    local target     = result[1].sender
    local amount     = result[1].amount
    local jobb       = result[1].jobb

        if price ~= nil then
        
            TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..jobb, function(account) 
            
                if xPlayer.getAccount("bank")["money"] >= price then
            
                    xPlayer.removeAccountMoney('bank', price)
                    account.addMoney(amount)
            
                    TriggerClientEvent("esx:showNotification", src, "Du betalade en faktura på " .. price )
            
                    MySQL.Async.execute("DELETE from user_billings WHERE id = @id", {
                        ["@id"] = id
                    })

                else
                    TriggerClientEvent("esx:showNotification", src, "Du har inte tillräckligt med pengar på banken...")
                end
            end)
        end
    end)
end)

ESX.RegisterServerCallback("t0sic_billing:fetchSent", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local fetch = [[
        SELECT
            *
        FROM
            user_billings
        WHERE
            sender = @identifier
    ]]

    MySQL.Async.fetchAll(fetch, {
        ["@identifier"] = xPlayer.identifier
    },function(data)
    
        if data ~= nil then
            cb(data)
        else
            cb(nil)
        end
    end)
end)


GetCharacterName = function(identifier)
    
    local fetch = [[
        SELECT
            firstname, lastname
        FROM
            users
        WHERE
            identifier = @identifier
    ]]

    local names = MySQL.Sync.fetchAll(fetch, {["@identifier"] = identifier})
    return names
end
