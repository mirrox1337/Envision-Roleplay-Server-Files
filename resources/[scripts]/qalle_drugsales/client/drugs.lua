-- Citizen.CreateThread(function()
--     Citizen.Wait(500)

--     while true do
--         local sleepThread = 500

--         local ped = PlayerPedId()
--         local pedCoords = GetEntityCoords(ped)

--         for drugAction, drugLocations in pairs(Config.DrugLocations) do
--             for locationIndex, locationData in ipairs(drugLocations) do
--                 local dstCheck = #(pedCoords - locationData["pos"])
    
--                 if dstCheck <= 4.0 then
--                     sleepThread = 5
    
--                     DrawScriptMarker({
--                         ["type"] = 6,
--                         ["pos"] = locationData["pos"] - vector3(0.0, 0.0, 0.985),
--                         ["sizeX"] = 2.3,
--                         ["sizeY"] = 2.3,
--                         ["sizeZ"] = 2.3,
--                         ["r"] = 255,
--                         ["g"] = 0,
--                         ["b"] = 0
--                     })
    
--                     if dstCheck <= 1.5 then
--                         local displayText = ("~INPUT_CONTEXT~ " .. locationData["label"]):format(ESX.Items[locationData["item"]]["label"])
    
--                         ESX.ShowHelpNotification(displayText)

--                         if IsControlJustPressed(0, 38) then
--                             DoDrugAction(locationData, drugAction)
--                         end
--                     end
--                 end
--             end
--         end

--         Citizen.Wait(sleepThread)
--     end
-- end)

-- DoDrugAction = function(locationData, drugAction)

-- end