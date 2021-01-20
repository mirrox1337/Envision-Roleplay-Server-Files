local ped = nil
local policeBlip = nil
local stuff = {
    inMission = false,
    vehicle = false,
    hasTracker = false,
    driveVehicle = false,
    stolenVehicle = false,
    randomArrive = nil,
    driver = false,
    trackerBlip = false,
    areaBlip = false
}
local defaultStuff = {}

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    local thisthingidk = json.decode(json.encode(stuff))
    defaultStuff = thisthingidk
end)

RegisterNetEvent('loffe_carthief:removeBlip')
AddEventHandler('loffe_carthief:removeBlip', function()
    RemoveBlip(policeBlip)
end)

RegisterNetEvent('loffe_carthief:addBlip')
AddEventHandler('loffe_carthief:addBlip', function(coords)
    if not DoesBlipExist(policeBlip) then
        policeBlip = AddBlipForCoord(coords, coords.x, coords.y, coords.z)
        
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Bilstöld')
        EndTextCommandSetBlipName(policeBlip)
    else
        SetBlipCoords(policeBlip, coords.x, coords.y, coords.z)
    end
end)

RegisterNetEvent('loffe_carthief:startCl')
AddEventHandler('loffe_carthief:startCl', function()
    stuff.inMission = true
    local cutsceneOver = GetGameTimer() + (1000 * Config.SoundfileLength)
    local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
    SetCamCoord(cam, Config.StartMission.CamCoord)
    RenderScriptCams(1, 0, 0, 1, 1)

    TriggerServerEvent("InteractSound_SV:PlayOnSource", Config.Soundfile, 1.0)

    while cutsceneOver >= GetGameTimer() do
        for i = 0, 255 do
            DisableAllControlActions(i)
        end
        PointCamAtEntity(cam, ped, 0.0, 0.0, 0.0, true)
        SetCamFov(cam, GetCamFov(cam)-0.05)
        Wait(5)
    end
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam)

    local vehicleModel = GetHashKey(Config.Vehicle.name)
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do Wait(0) end
    local randomPosition = math.random(1, #Config.Vehicle.spawnlocations)
    stuff.vehicle = CreateVehicle(vehicleModel, Config.Vehicle.spawnlocations[randomPosition].coords, Config.Vehicle.spawnlocations[randomPosition].heading, true, true)
    NetworkRegisterEntityAsNetworked(stuff.vehicle)
    SetVehicleDoorsLocked(stuff.vehicle, 4)
    SetVehicleDoorsLockedForAllPlayers(stuff.vehicle, true)

    stuff.areaBlip = AddBlipForRadius(GetOffsetFromEntityInWorldCoords(stuff.vehicle, math.random(15, 30), math.random(15,30), 0.0), 75.0)
    SetBlipColour(stuff.areaBlip, 33)
    SetBlipAlpha(stuff.areaBlip, 100)

    while stuff.inMission do
        Citizen.Wait(0)
        if not stuff.hasTracker then
            if HasEntityClearLosToEntity(PlayerPedId(), stuff.vehicle, 19) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(stuff.vehicle), true) <= 50.0 then
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(stuff.vehicle), true) <= 5.5 then
                    BeginTextCommandDisplayHelp('STRING')
                    AddTextComponentSubstringPlayerName('~INPUT_CONTEXT~ Sätt en GPS på bilen')
                    EndTextCommandDisplayHelp(0, false, true, -1)
                    if IsControlJustReleased(0, 38) then
                        RemoveBlip(stuff.areaBlip)
                        stuff.trackerBlip = AddBlipForEntity(stuff.vehicle)
                        stuff.driveVehicle = GetGameTimer() +math.random(40000, 75000)
                        stuff.hasTracker = true
                    end
                else
                    drawTxt('Gå till bilen och sätt en GPS på den.')
                end
            else
                drawTxt(('Åk till ~y~området~w~ och leta efter en %s'):format(Config.Vehicle.label))
            end
        else
            if not stuff.stolenVehicle then
                if GetGameTimer() >= stuff.driveVehicle then
                    if not DoesEntityExist(stuff.driver) then
                        local hash = 988062523
                        RequestModel(hash)
                        while not HasModelLoaded(hash) do Wait(5) end
                        stuff.driver = CreatePedInsideVehicle(stuff.vehicle, 4, hash, -1, true, false)
                        SetPedHearingRange(stuff.driver, 0.0)
                        SetPedSeeingRange(stuff.driver, 0.0)
                        SetPedAlertness(stuff.driver, 0.0)
                        SetBlockingOfNonTemporaryEvents(stuff.driver, true)

                        stuff.randomArrive = Config.Vehicle.arrivelocations[math.random(1, #Config.Vehicle.arrivelocations)]
                        local parking = false
                        TaskVehicleDriveToCoordLongrange(stuff.driver, stuff.vehicle, stuff.randomArrive.coords, 20.0, 387, 5)
                        Wait(1500)
                    end
                    if GetIsVehicleEngineRunning(stuff.vehicle) then
                        drawTxt('Förfölj bilen.')
                        if GetDistanceBetweenCoords(GetEntityCoords(stuff.vehicle), stuff.randomArrive.coords, true) <= 250.0 and not parking then
                            parking = true
                            ClearPedTasks(stuff.driver)
                            ClearPedSecondaryTask(stuff.driver)
                            TaskVehiclePark(stuff.driver, stuff.vehicle, stuff.randomArrive.coords, stuff.randomArrive.heading, 0, 40.0, false)
                        end
                    else
                        SetVehicleDoorsLocked(stuff.vehicle, 7)
                        SetVehicleDoorsLockedForAllPlayers(stuff.vehicle, false)
                        TaskLeaveVehicle(stuff.driver, stuff.vehicle, 0)
                        stuff.stolenVehicle = false

                        if not stuff.stolenVehicle then
                            TaskWanderInArea(stuff.driver, stuff.randomArrive.coords, 15.0, 5, 10)
                            RemoveBlip(stuff.trackerBlip)
                            local beatenUp = false
                            while not beatenUp do
                                Wait(5)
                                if not IsPedDeadOrDying(stuff.driver) then
                                    drawTxt('Mörda personen!')
                                    DrawMarker(0, GetOffsetFromEntityInWorldCoords(stuff.driver, 0.0, 0.0, 1.0), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 0.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                                else
                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(stuff.driver), false) <= 2.0 then
                                        BeginTextCommandDisplayHelp('STRING')
                                        AddTextComponentSubstringPlayerName('~INPUT_CONTEXT~ Leta efter bilnycklarna')
                                        EndTextCommandDisplayHelp(0, false, true, -1)
                                        if IsControlJustReleased(0, 38) then
                                            RequestAnimDict('anim@gangops@facility@servers@bodysearch@')
                                            while not HasAnimDictLoaded('anim@gangops@facility@servers@bodysearch@') do Wait(0) end
                                            TaskPlayAnim(PlayerPedId(), 'anim@gangops@facility@servers@bodysearch@', 'player_search', 8.0, -8.0, -1, 48, 0, false, false, false)
                                            while not IsEntityPlayingAnim(PlayerPedId(), 'anim@gangops@facility@servers@bodysearch@', 'player_search', 3) do Wait(0) end
                                            while IsEntityPlayingAnim(PlayerPedId(), 'anim@gangops@facility@servers@bodysearch@', 'player_search', 3) do for i = 0, 255 do DisableAllControlActions(i) end Wait(1) end
                                            local pedBlip = AddBlipForEntity(ped)
                                            TriggerServerEvent('loffe_carthief:policeBlip', GetEntityCoords(stuff.vehicle))
                                            local removePoliceBlip = GetGameTimer() + (1000 * Config.BlipTimer)

                                            Citizen.CreateThread(function()
                                                while not stuff.stolenVehicle do
                                                    Citizen.Wait(3500) -- väntar 3,5 sekunder istället för att spamma servern var 5ms.

                                                    if removePoliceBlip <= GetGameTimer() then
                                                        TriggerServerEvent('loffe_carthief:removeBlip')
                                                    else
                                                        TriggerServerEvent('loffe_carthief:updatePosition', GetEntityCoords(stuff.vehicle))
                                                    end
                                                end
                                            end)

                                            while not stuff.stolenVehicle do
                                                Wait(5)

                                                if not IsPedInVehicle(PlayerPedId(), stuff.vehicle, true) then
                                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped), true) <= 10.0 and GetDistanceBetweenCoords(GetEntityCoords(stuff.vehicle), GetEntityCoords(ped), true) <= 15.0 then
                                                        drawTxt(('Gå till %s och lämna över nycklarna.'):format(Config.Name))
                                                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped), true) <= 2.5 then
                                                            BeginTextCommandDisplayHelp('STRING')
                                                            AddTextComponentSubstringPlayerName(('~INPUT_CONTEXT~ Ge nycklarna till %s'):format(Config.Name))
                                                            EndTextCommandDisplayHelp(0, false, true, -1)
                                                            if IsControlJustReleased(0, 38) then
                                                                -- GetVehicleBodyHealth(stuff.vehicle)
                                                                TriggerServerEvent('loffe_carthief:finished')
                                                                DeleteVehicle(stuff.vehicle)
                                                                DeletePed(stuff.driver)
                                                                RemoveBlip(pedBlip)
                                                                stuff = defaultStuff
                                                                return
                                                            end
                                                        end
                                                    else
                                                        drawTxt('Sätt dig i bilen')
                                                    end
                                                else
                                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped), true) <= 10.0 then
                                                        drawTxt('Parkera bilen.')
                                                    else
                                                        drawTxt(('Kör tillbaka till %s och lämna bilen.'):format(Config.Name))
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        drawTxt('Sno bilnycklarna!')
                                    end
                                end
                            end
                        end
                    end
                else
                    drawTxt('Invänta personen.')
                end
            end
        end
        Wait(5)
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    ped = createPed(Config.PedHash, Config.StartMission.coords, Config.StartMission.heading)
    FreezeEntityPosition(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_AA_SMOKE', 0, true)
    while true do
        local me = PlayerPedId()
        local sleep = 200
        local distance = GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(ped))
        if distance > 2.5 or stuff.inMission then
            sleep = 200
        else
            sleep = 5
            BeginTextCommandDisplayHelp('STRING')
            AddTextComponentSubstringPlayerName(('~INPUT_CONTEXT~ Snacka med %s'):format(Config.Name))
            EndTextCommandDisplayHelp(0, false, true, -1)
            if IsControlJustReleased(0, 38) then
                sleep = 500

                -- TriggerEvent('loffe_carthief:startCl')
                TriggerServerEvent('loffe_carthief:start')
            end
        end
        Wait(sleep)
    end
end)

drawTxt = function(text, x, y)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
    AddTextComponentString(text)
    if not x and not y then
        DrawText(0.5, 0.95)
    else
        DrawText(x, y)
    end
end

createPed = function(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(5) end
    local peds = CreatePed(4, hash, coords, false, false)
    SetEntityHeading(peds, heading)
    SetEntityAsMissionEntity(peds, true, true)
    SetEntityInvincible(peds, true)
    SetPedHearingRange(peds, 0.0)
    SetPedSeeingRange(peds, 0.0)
    SetPedAlertness(peds, 0.0)
    SetBlockingOfNonTemporaryEvents(peds, true)
    SetPedCombatAttributes(peds, 46, true)
    SetPedFleeAttributes(peds, 0, 0)
    return peds
end
