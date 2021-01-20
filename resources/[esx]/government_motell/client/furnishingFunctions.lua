StartFurnishing = function()
    if cachedData["furnishing"] then return end

    cachedData["furnishing"] = true

    local DrawInstructions = function()
        BeginTextCommandDisplayHelp("furnishing_instructions")
        EndTextCommandDisplayHelp(0, 0, 1, -1)
    end 

    while cachedData["furnishing"] do
        Citizen.Wait(5)

        DrawInstructions()

        for keyLabel, keyValue in pairs(Config.Keys) do
            DisableControlAction(0, keyValue, true)

            if IsDisabledControlPressed(0, keyValue) then
                ButtonPressed(keyLabel)
            end
        end

        local furProp = cachedData["furnishingProp"]

        if furProp then
            local handle = furProp["handle"]

            if DoesEntityExist(handle) then
                DrawScriptText(furProp["coords"], furProp["description"])
                DrawScriptText(furProp["coords"] - vector3(0.0, 0.0, 0.4), "Rotation: " .. math.ceil(furProp["rotation"]["z"]))
            end
        end
    end

    if cachedData["furnishingProp"] and DoesEntityExist(cachedData["furnishingProp"]["handle"]) then
        DeleteEntity(cachedData["furnishingProp"]["handle"])
    end
end

OpenControlMenu = function()
    local menuElements = {
        {
            ["label"] = "Placera en ny möbel",
            ["action"] = "furnish"
        },
        {
            ["label"] = "Hantera existerande möbler",
            ["action"] = "refurnish"
        }
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "control_motel_room", {
        ["title"] = "Välj ett alternativ",
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local action = menuData["current"]["action"]

        if action == "furnish" then
            OpenFurnishingMenu()
        elseif action == "refurnish" then
            OpenRefurnishMenu()
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

OpenFurnishingMenu = function()
    local menuElements = {}

    local currentMotel = DecorGetInt(PlayerPedId(), "currentInstance")

    if not cachedData["furnishings"][currentMotel] then return exports['mythic_notify']:SendAlert('error', ('Du har inte köpt några möbler.')) --[[ESX.ShowNotification("Du har inte köpt möbler")--]] end
    if not cachedData["furnishings"][currentMotel]["ownedFurnishing"] or #cachedData["furnishings"][currentMotel]["ownedFurnishing"] == 0 then return exports['mythic_notify']:SendAlert('error', ('Du har inte köpt några möbler.')) --[[ESX.ShowNotification("Du har inte köpt möbler.")--]] end

    for furnishingIndex, furnishingData in ipairs(cachedData["furnishings"][currentMotel]["ownedFurnishing"]) do
        furnishingData["index"] = furnishingIndex
        furnishingData["handle"] = nil

        table.insert(menuElements, {
            ["label"] = furnishingData["label"],
            ["action"] = furnishingData
        })
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "furnishing_motel_room", {
        ["title"] = "Välj möbel.",
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local action = menuData["current"]["action"]

        if type(action) == "table" then
            FurnishingProp(action)
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

OpenRefurnishMenu = function()
    local menuElements = {}

    for furnishId, furnishData in pairs(cachedData["props"]) do
        if furnishData["data"]["index"] then
            furnishData["data"]["index"] = nil
        end

        furnishData["data"]["uuid"] = furnishId
        furnishData["data"]["handle"] = furnishData["handle"]

        table.insert(menuElements, {
            ["label"] = furnishData["data"]["label"],
            ["action"] = furnishData["data"]
        })
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "refurnishing_motel_room", {
        ["title"] = "Välj möbel att hantera",
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local action = menuData["current"]["action"]

        if type(action) == "table" then
            FurnishingProp(action)
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

FurnishingProp = function(furnishingData)
    if cachedData["furnishingProp"] then
        DeleteEntity(cachedData["furnishingProp"]["handle"])
    end

    cachedData["furnishingProp"] = furnishingData

    if WaitForModel(furnishingData["model"]) then
        if not furnishingData["handle"] then
            cachedData["furnishingProp"]["handle"] = CreateObject(furnishingData["model"], GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()), false)
        end
            
        cachedData["furnishingProp"]["coords"] = GetEntityCoords(cachedData["furnishingProp"]["handle"])
        cachedData["furnishingProp"]["rotation"] = GetEntityRotation(cachedData["furnishingProp"]["handle"])

        FreezeEntityPosition(cachedData["furnishingProp"]["handle"], true)
    end
end

EditFurnishingProp = function()
    if not cachedData["furnishingProp"] then return end
    if not DoesEntityExist(cachedData["furnishingProp"]["handle"]) then return end
    if not cachedData["furnishingProp"]["rotation"] then return end
    if not cachedData["furnishingProp"]["coords"] then return end

    local handle = cachedData["furnishingProp"]["handle"]

    SetEntityRotation(handle, cachedData["furnishingProp"]["rotation"])
    SetEntityCoords(handle, cachedData["furnishingProp"]["coords"])
end

SpawnFurnishing = function(furnishingRoom)
    local furnishingData = cachedData["furnishings"][furnishingRoom]

    if not furnishingData then return end
    if not furnishingData["furnishing"] then return end

    if cachedData["props"] then RemoveSpawnedProps() else cachedData["props"] = {} end

    for furnishId, furnishData in pairs(furnishingData["furnishing"]) do
        if WaitForModel(furnishData["model"]) then
            local furnishCoords = vector3(furnishData["coords"]["x"], furnishData["coords"]["y"], furnishData["coords"]["z"])
            local furnishRotation = vector3(furnishData["rotation"]["x"], furnishData["rotation"]["y"], furnishData["rotation"]["z"])

            cachedData["props"][furnishId] = {
                ["handle"] = CreateObject(furnishData["model"], furnishCoords, false),
                ["data"] = furnishData
            }

            SetEntityCoords(cachedData["props"][furnishId]["handle"], furnishCoords)
            SetEntityRotation(cachedData["props"][furnishId]["handle"], furnishRotation)

            FreezeEntityPosition(cachedData["props"][furnishId]["handle"], true)
        end
    end
end

RemoveSpawnedProps = function()
    if not cachedData["props"] then return end

    for furnishId, furnishData in pairs(cachedData["props"]) do
        if DoesEntityExist(furnishData["handle"]) then
            DeleteEntity(furnishData["handle"])
        end
    end

    cachedData["props"] = {}
end

ButtonPressed = function(keyLabel)
    if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "furnishing_motel_room") or ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "refurnish_motel_room") or ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "control_motel_room") then return end
    
    local furProp = cachedData["furnishingProp"]
    local furHandle = furProp and cachedData["furnishingProp"]["handle"] or nil
    
    if keyLabel == "F" then
        OpenControlMenu()
    elseif keyLabel == "X" then
        cachedData["furnishing"] = false
    end
    
    if DoesEntityExist(furHandle) then
        local speed = IsControlPressed(0, 209) and 0.03 or 0.005

        if keyLabel == "ARROW UP" then
            furProp["coords"] = furProp["coords"] + vector3(0.0, speed, 0.0)
        elseif keyLabel == "ARROW DOWN" then
            furProp["coords"] = furProp["coords"] - vector3(0.0, speed, 0.0)
        elseif keyLabel == "ARROW LEFT" then
            furProp["coords"] = furProp["coords"] - vector3(speed, 0.0, 0.0)
        elseif keyLabel == "ARROW RIGHT" then
            furProp["coords"] = furProp["coords"] + vector3(speed, 0.0, 0.0)
        elseif keyLabel == "INSERT" then
            furProp["coords"] = furProp["coords"] + vector3(0.0, 0.0, speed)
        elseif keyLabel == "DELETE" then
            furProp["coords"] = furProp["coords"] - vector3(0.0, 0.0, speed)
        elseif keyLabel == "Q" then
            furProp["rotation"] = furProp["rotation"] + vector3(0.0, 0.0, speed * 10)
        elseif keyLabel == "E" then
            furProp["rotation"] = furProp["rotation"] - vector3(0.0, 0.0, speed * 10)
        elseif keyLabel == "G" then
            PlaceObjectOnGroundProperly(furHandle)

            furProp["coords"] = GetEntityCoords(furHandle)
        elseif keyLabel == "ENTER" then
            DrawBusySpinner("Sparar Möblering...")
    
            Citizen.Wait(1500)
    
            RemoveLoadingPrompt()
            
            local currentMotel = DecorGetInt(PlayerPedId(), "currentInstance")
    
            if not cachedData["furnishings"][currentMotel] then
                cachedData["furnishings"][currentMotel] = {}
            end

            if not cachedData["furnishings"][currentMotel]["furnishing"] then
                cachedData["furnishings"][currentMotel]["furnishing"] = {}
            end
    
            local furnishingUUID = furProp["uuid"] or UUID()
    
            cachedData["furnishings"][currentMotel]["furnishing"][furnishingUUID] = furProp
            cachedData["furnishings"][currentMotel]["furnishing"][furnishingUUID]["coords"] = { ["x"] = furProp["coords"]["x"], ["y"] = furProp["coords"]["y"], ["z"] = furProp["coords"]["z"] }   
            cachedData["furnishings"][currentMotel]["furnishing"][furnishingUUID]["rotation"] = { ["x"] = furProp["rotation"]["x"], ["y"] = furProp["rotation"]["y"], ["z"] = furProp["rotation"]["z"] }  
            
            if cachedData["furnishingProp"]["index"] then
                table.remove(cachedData["furnishings"][currentMotel]["ownedFurnishing"], cachedData["furnishingProp"]["index"])
            end
    
            ESX.TriggerServerCallback("james_motels:saveFurnishing", function(savedFurnishing)
                if savedFurnishing then
                    GlobalFunction("update_furnishing", {
                        ["motelId"] = currentMotel,
                        ["furnishingData"] = cachedData["furnishings"][currentMotel]["furnishing"]
                    })
    
                    exports['mythic_notify']:SendAlert('inform', ('Du placerade ut möbeln.')) --ESX.ShowNotification("Du placerade möblerna")
                else
                    exports['mythic_notify']:SendAlert('inform', ('Vänligen försök placera ut den igen.')) --ESX.ShowNotification("Försök placera den igen.")
                end
            end, currentMotel, cachedData["furnishings"][currentMotel]["furnishing"], cachedData["furnishings"][currentMotel]["ownedFurnishing"])

            DeleteEntity(furHandle)
        end

        EditFurnishingProp()
    end
end

OpenFurnishingComputer = function()
    local ownedMotel = GetPlayerMotel()

    if not ownedMotel then return exports['mythic_notify']:SendAlert('error', ('Du måste äga ett motellrum för att komma åt datorn.')) --[[ESX.ShowNotification("Du måste äga ett motellrum för att komma åt datorn")--]] end

    local menuElements = {}

    for category, categoryProps in pairs(Config.FurnishingPurchasables) do
        table.insert(menuElements, {
            ["label"] = category,
            ["props"] = categoryProps
        })
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_furnishing_computer", {
        ["title"] = "IKEA - Katalog",
        ["align"] = "right",
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local currentProps = menuData["current"]["props"]

        if not currentProps then return end

        OpenFurnishingCategory(currentProps)
    end, function(menuData, menuHandle)
        menuHandle.close()

        if cachedData["furnishingProp"] then
            DeleteEntity(cachedData["furnishingProp"]["handle"])
        end
    end)
end

OpenFurnishingCategory = function(categoryProps)
    local menuElements = {}

    for propName, propData in pairs(categoryProps) do
        propData["name"] = propName

        table.insert(menuElements, {
            ["label"] = propData["label"],
            ["prop"] = propData
        })
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_furnishing_computer_category", {
        ["title"] = "Möbel - Katalog",
        ["align"] = "right",
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local currentProp = menuData["current"]["prop"]

        if not currentProp then return end

        FurnishingProp(currentProp)

        cachedData["furnishingProp"]["coords"] = Config.MegaMall["object"]["pos"]
        cachedData["furnishingProp"]["rotation"] = Config.MegaMall["object"]["rotation"]

        EditFurnishingProp()

        ComputerTick(cachedData["furnishingProp"])
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

ComputerTick = function(currentProp)
    local PurchaseProp = function()
        DeleteEntity(currentProp["handle"])

        local ownedMotel = GetPlayerMotel()

        ESX.TriggerServerCallback("james_motels:purchaseFurnishing", function(purchased)
            DrawBusySpinner("Verifierar ditt köp..")

            Citizen.Wait(1500)

            RemoveLoadingPrompt()

            if purchased then
                exports['mythic_notify']:SendAlert('success', ('Ditt köp lyckades, paketet levereras till ditt motellrum!')) --ESX.ShowNotification("Ditt köp lyckades, paketet levereras till ditt motellrum!")
            else
                exports['mythic_notify']:SendAlert('error', ('Köp medges ej!')) --ESX.ShowNotification("Ditt köp misslyckades, kolla dina pengar")
            end
        end, currentProp, ownedMotel["uniqueId"])
    end

    Citizen.CreateThread(function()
        while DoesEntityExist(currentProp["handle"]) do
            Citizen.Wait(5)

            DrawScriptText(cachedData["furnishingProp"]["coords"] or Config.MegaMall["object"]["pos"], cachedData["furnishingProp"]["price"] .. ":-")
            DrawScriptText((cachedData["furnishingProp"]["coords"] or Config.MegaMall["object"]["pos"]) - vector3(0.0, 0.0, 0.25), "[~b~G~s~] för att köpa.")

            if IsControlJustPressed(0, 47) then
                return PurchaseProp()
            end

            cachedData["furnishingProp"]["rotation"] = (cachedData["furnishingProp"]["rotation"] or Config.MegaMall["object"]["rotation"]) + vector3(0.0, 0.0, 0.5)

            EditFurnishingProp()
        end
    end)    
end

UseWaterCan = function(furnishId)
    
end 

UseArcadeMachine = function(furnishId)
    
end

DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

GetCategory = function(furnishName)
    for category, categoryProps in pairs(Config.FurnishingPurchasables) do
        for propName, propData in pairs(categoryProps) do
            if propName == furnishName then
                return category
            end
        end
    end
end