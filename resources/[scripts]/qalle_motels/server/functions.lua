CreateMotel = function(source, motelRoom, callback)
    local player = ESX.GetPlayerFromId(source)

    local characterNames = player["character"]

    if player then
        local motelData = {
            ["displayLabel"] = characterNames["firstname"] .. " " .. characterNames["lastname"],
            ["owner"] = player["identifier"],
            ["room"] = motelRoom or 1,
            ["uniqueId"] = UUID()
        }

        local sqlQuery = [[
            INSERT
                INTO
            world_motels
                (userIdentifier, motelData)
            VALUES
                (@identifier, @data)
        ]]

        MySQL.Async.execute(sqlQuery, {
            ["@identifier"] = player["identifier"],
            ["@data"] = json.encode(motelData)
        }, function(rowsChanged)
            if rowsChanged > 0 then
                if not cachedData["motels"][motelRoom or 1] then
                    cachedData["motels"][motelRoom or 1] = {}
                    cachedData["motels"][motelRoom or 1]["rooms"] = {}
                end
    
                table.insert(cachedData["motels"][motelRoom or 1]["rooms"], {
                    ["motelData"] = motelData
                })

                TriggerClientEvent("qalle_motels:eventHandler", -1, "update_motels", cachedData["motels"])

                if callback then
                    callback(true, motelData["uniqueId"])
                end
            else
                if callback then
                    callback(false)
                end
            end
        end)
    end
end

UpdateStorageDatabase = function(storageId, newTable)
    local sqlQuery = [[
        INSERT
            INTO
        world_storages
            (storageId, storageData)
        VALUES
            (@id, @data)
        ON DUPLICATE KEY UPDATE
            storageData = @data
    ]]

    MySQL.Async.execute(sqlQuery, {
        ["@id"] = storageId,
        ["@data"] = json.encode(newTable)
    })
end