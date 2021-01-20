CreateClosePed = function(pos)
    local GetRandomModel = function()
        math.randomseed(math.random() * GetGameTimer() * NetworkGetRandomInt())

        return Config.Peds[math.random(#Config.Peds)]
    end

    local randomLocation = GetCloseRandomLocation(pos)

    if type(randomLocation) == "vector3" then
        local pedModel = GetRandomModel()

        WaitForModel(pedModel)

        local pedEntity = CreatePed(5, pedModel, randomLocation - vector3(0.0, 0.0, 0.985), 0.0, true)

        local _, taskSequence = OpenSequenceTask()
        TaskGoStraightToCoord(0, GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()), 1.0, 130000, 20.0, 0.0)
        TaskAchieveHeading(0, GetEntityHeading(PlayerPedId()) - 180.0, 1500)
        CloseSequenceTask(taskSequence)

        table.insert(cachedData["peds"], {
            ["entity"] = pedEntity,
            ["offer"] = math.random(Config.RandomOffer[1], Config.RandomOffer[2]),
            ["amount"] = math.random(Config.RandomAmount[1], Config.RandomAmount[2])
        })

        TaskPerformSequence(pedEntity, taskSequence)

        Citizen.CreateThread(function()
            Citizen.Wait(150)
        
            while GetSequenceProgress(pedEntity) >= 0 do
                Citizen.Wait(0)
            end
        end)
    end
end

SellDrugs = function(pedData, pedIndex)
    if cachedData["pendingPurchase"] then return ESX.ShowNotification("Du har redan en förhandling som pågår.") end

    cachedData["pendingPurchase"] = true

    DrawBusySpinner("Säljer...")

    Citizen.Wait(5000)

    ESX.TriggerServerCallback("qalle_drugsales:sellDrugs", function(sold)
        table.remove(cachedData["peds"], pedIndex)

        if sold then
            ESX.ShowNotification("Du sålde drogerna.")

            ESX.PlayAnimation(PlayerPedId(), "mp_common", "givetake1_a", { ["flag"] = 32 })
            ESX.PlayAnimation(pedData["entity"], "mp_common", "givetake1_a", { ["flag"] = 32 })
        else
            AbortSelling()

            ESX.ShowNotification("Drogerna såldes inte (Har du verkligen droger?).")
        end

        TaskWanderStandard(pedData["entity"], 10.0, 10)
        
        Citizen.CreateThread(function()
            Citizen.Wait(30000)
            
            SetPedAsNoLongerNeeded(pedData["entity"])
        end)

        RemoveLoadingPrompt()

        cachedData["pendingPurchase"] = false
    end, pedData)
end

NegotiateDrugs = function(pedData, pedIndex)
    if cachedData["pendingPurchase"] then return ESX.ShowNotification("Du har redan en förhandling som pågår.") end
    if pedData["negotiated"] then return ESX.ShowNotification("Nej, försök inte igen.") end

    cachedData["pendingPurchase"] = true

    DrawBusySpinner("Förhandlar...")

    ESX.PlayAnimation(PlayerPedId(), "gestures@m@standing@casual", "gesture_bring_it_on", {
        ["flag"] = 32
    })

    Citizen.Wait(20000)

    RemoveLoadingPrompt()

    local randomChance = math.random(10)

    if randomChance < 5 then
        cachedData["peds"][pedIndex]["offer"] = math.ceil(pedData["offer"] * 1.05)

        ESX.ShowNotification("Hmmm, kan väl höja det lite.")
    elseif randomChance == 5 then
        cachedData["peds"][pedIndex]["offer"] = math.ceil(pedData["offer"] * 1.20)

        ESX.ShowNotification("Okej då, du får det för så mycket då.")
    elseif randomChance == 10 then
        TaskWanderStandard(pedData["entity"], 10.0, 10)
        
        Citizen.CreateThread(function()
            Citizen.Wait(30000)
            
            SetPedAsNoLongerNeeded(pedData["entity"])
        end)

        table.remove(cachedData["peds"], pedIndex)

        ESX.ShowNotification("Skit i det då, jävla idiot.")

        local pedCoords = GetEntityCoords(pedData["entity"])

        TriggerServerEvent("esx_phone:send", "police", "Någon idiot försöker sälja droger till mig, skickar position.", true, {
            ["x"] = pedCoords["x"],
            ["y"] = pedCoords["y"],
            ["z"] = pedCoords["z"]
        })
    else
        cachedData["peds"][pedIndex]["offer"] = math.ceil(pedData["offer"] * 0.80)

        ESX.ShowNotification("Nja, om du ska vara sån får du det billigare.")
    end

    cachedData["peds"][pedIndex]["negotiated"] = true

    cachedData["pendingPurchase"] = false
end

DenyDrugs = function(pedData, pedIndex)
    TaskWanderStandard(pedData["entity"], 10.0, 10)
        
    Citizen.CreateThread(function()
        Citizen.Wait(30000)
        
        SetPedAsNoLongerNeeded(pedData["entity"])
    end)

    table.remove(cachedData["peds"], pedIndex)

    ESX.ShowNotification("Skit i det då, jävla idiot.")

    if math.random(5) == 4 then
        local pedCoords = GetEntityCoords(pedData["entity"])

        TriggerServerEvent("esx_phone:send", "police", "Någon idiot försöker sälja droger till mig, skickar position.", true, {
            ["x"] = pedCoords["x"],
            ["y"] = pedCoords["y"],
            ["z"] = pedCoords["z"]
        })
    end
end

AbortSelling = function()
    cachedData["selling"] = false

    for pedIndex, pedData in ipairs(cachedData["peds"]) do
        while not NetworkHasControlOfEntity(pedData["entity"]) do
            Citizen.Wait(0)

            NetworkRequestControlOfEntity(pedData["entity"])
        end

        SetPedAsNoLongerNeeded(pedData["entity"])

        Citizen.CreateThread(function()
            Citizen.Wait(30000)

            DeleteEntity(pedData["entity"])
        end)
    end

    cachedData["peds"] = {}
end

RemoveCachedPeds = function()
    for pedIndex, pedData in ipairs(cachedData["peds"]) do
        while not NetworkHasControlOfEntity(pedData["entity"]) do
            Citizen.Wait(0)

            NetworkRequestControlOfEntity(pedData["entity"])
        end

        DeleteEntity(pedData["entity"])
    end
end

GetCloseRandomLocation = function(pos)
    local spawnPoint = nil

    local radius = 25
    local z = 1500.
    local tryCount = 0

    local startSpawnTimer = GetGameTimer()

    while true do
        Citizen.Wait(0)

        math.randomseed(NetworkGetRandomInt() * GetGameTimer())

        local diff = { r = radius * math.sqrt(GetRandomFloatInRange(0.0, 1.0)), theta = GetRandomFloatInRange(0.0, 1.0) * 2 * math.pi }
        local xDiff = diff.r * math.cos(diff.theta)
        if xDiff >= 0 then xDiff = math.max(radius, xDiff) else xDiff = math.min(-radius, xDiff) end

        local yDiff = diff.r * math.sin(diff.theta)
        if yDiff >= 0 then yDiff = math.max(radius, yDiff) else yDiff = math.min(-radius, yDiff) end

        local x = pos.x + xDiff
        local y = pos.y + yDiff

        for height = 1, 500 do
            local foundGround, zPos = GetGroundZFor_3dCoord(x, y, height + 0.0)

            if foundGround then
                local validCoords, coords = GetSafeCoordForPed(x, y, zPos + 0.0, false, 16)

                if validCoords then
                    spawnPoint = coords
                else
                    if tryCount ~= 10 then 
                        tryCount = tryCount + 1
                    else
                        radius = radius + 5
        
                        tryCount = 0
                    end
                end

                break
            end
        end

        if GetGameTimer() - startSpawnTimer > 30000 then
            spawnPoint = {}
        end

        if spawnPoint then return spawnPoint end
    end
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, true, 2, false, false, false, false)
end

DrawScriptText = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370

    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

WaitForModel = function(model)
    local DrawScreenText = function(text, red, green, blue, alpha)
        SetTextFont(4)
        SetTextScale(0.0, 0.5)
        SetTextColour(red, green, blue, alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)
    
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(0.5, 0.5)
    end

    if not IsModelValid(model) then
        return ESX.ShowNotification("Fordonsmodellen existerar ej.")
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(0)

		DrawScreenText("~g~Laddar modell " .. GetLabelText(GetDisplayNameFromVehicleModel(model)) .. "...", 255, 255, 255, 150)
	end
end

DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end