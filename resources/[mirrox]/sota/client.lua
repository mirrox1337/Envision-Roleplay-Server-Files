local time = 5 -- how long the particle lasts
local SIZE = 1.0
local particleDict = "core"
local particleName = "ent_amb_generator_smoke"
local bone = "exhaust"
local key = 73

-- [EFFECTS FROM CORE ONLY]
-- veh_exhaust_truck_rig [size = 3.0]
-- ent_amb_smoke_general [size = 1.0]
-- ent_amb_generator_smoke [size = 1.0]

local allowedVehicles = {
	"sandking"
}

local car_net = nil
local CanStart = false

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)

        
        
        local ped = GetPlayerPed(PlayerId())
        local vehicle = GetVehiclePedIsIn(ped, false)

        isAllowed( GetVehiclePedIsIn(ped, false ))

        if  IsControlJustPressed(1, key) and IsPedTheDriver(vehicle, ped) and CanStart then


            RequestNamedPtfxAsset(particleDict)
            
            while not HasNamedPtfxAssetLoaded(particleDict) do
                Citizen.Wait(10)
            end
            
            local netid = VehToNet(vehicle)

            SetNetworkIdExistsOnAllMachines(netid, 1)
            NetworkSetNetworkIdDynamic(netid, 0)
            SetNetworkIdCanMigrate(netid, 0)
            
            car_net = netid
            TriggerServerEvent("Smoke:SyncStartParticles", car_net)
        else
            if IsControlJustPressed(1, key) then
                print ("You cannot do this as passenger") 
            end
        end
    end
end)

RegisterNetEvent("Smoke:StartParticles")
AddEventHandler("Smoke:StartParticles", function(carid)
    local entity = NetToVeh(carid)

    local part = GetWorldPositionOfEntityBone(entity, bone)
    
    local loopAmount = 250
    
    local particleEffects = {}

    for x=0,loopAmount do

        UseParticleFxAssetNextCall(particleDict)

        local particle = StartParticleFxLoopedOnEntityBone(particleName, entity, part.x, part.y, part.z, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(entity, bone), SIZE, false, false, false)

        SetParticleFxLoopedEvolution(particle, particleName, SIZE, 0)

        table.insert(particleEffects, 1, particle)
        Citizen.Wait(0)
    end

    Citizen.Wait(time)
    for _,particle in pairs(particleEffects) do
        StopParticleFxLooped(particle, true)
    end
end)

function IsPedTheDriver(vehicle, ped)
    local driverPed = GetPedInVehicleSeat(vehicle, -1)
    if driverPed == ped then
        return true
    else
        return false
    end
end

function isAllowed(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

        if isCarAllowed(carModel) then
            CanStart = true
        else
            CanStart = false
        end
	end
end

function isCarAllowed(model)
	for _, allowedVehicle in pairs(allowedVehicles) do
		if model == GetHashKey(allowedVehicle) then
            return true
        else
            return false
        end
    end
end