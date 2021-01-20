local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData = {}
local CurrentActionData = {}
local lastTime = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer 
end)


-- Start of Carcleankit

RegisterNetEvent('esx_extraitems:carcleankit')
AddEventHandler('esx_extraitems:carcleankit', function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

		if IsPedSittingInAnyVehicle(playerPed) then
			exports['mythic_notify']:SendAlert('error', (_U('inside_vehicle')))
			return
		end

		if DoesEntityExist(vehicle) then
			exports['mythic_progbar']:Progress({
				name = "mechanicWash",
				duration = 60000,
				label = "Tvättar",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
					animation = {
						animDict = "amb@world_human_maid_clean@base",
						anim = "base",
					},
					prop = {
						model = "prop_sponge_01",
						bone = 58870,
						coords = { x = 0.00, y = 0.05, z = 0.0 },
						rotation = { x = 180.0, y = 0.0, z = 0.0 },
					}
				}, function(cancelled)
					if not cancelled then
					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)
					exports['mythic_notify']:SendAlert('success', (_U('vehicle_cleaned')))
				else
					ClearPedTasksImmediately(PlayerPed)
					end
				end)
			else
				exports['mythic_notify']:SendAlert('error', (_U('no_vehicle_nearby')))
			end
end)

-- End of Carcleankit
-- Start of cigarettes

RegisterNetEvent('esx_cigarett:startSmoke')
AddEventHandler('esx_cigarett:startSmoke', function(source)
    SmokeAnimation()
end)

function SmokeAnimation()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)               
	end)
end

RegisterNetEvent("esx_cigarett:openCigarettes")
AddEventHandler("esx_cigarett:openCigarettes", function(item)
    local playerPed = PlayerPedId()
    exports['mythic_progbar']:Progress({
        name = "openCigarettes",
        duration = 1000,
        label = 'Öppnar cigarett paket',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "ng_proc_cigpak01b",
            bone = 18905,
            coords = { x = 0.10, y = 0.02, z = 0.02 },
            rotation = { x = -0.0, y = 0.0, z = 0.0 },
        },
    }, function(cancelled)
        if not cancelled then
            TriggerServerEvent('mirrox-items:openCigaretter')
            exports['mythic_notify']:SendAlert('inform', 'Du öppnade ditt paket och tog ut cigaretterna')
        else
            ClearPedTasksImmediately(PlayerPedId)
        end
    end)

-- End of ciggarettes
-- Start of Snus

AddEventHandler('esx:onPlayerDeath', function()
    isDead = true
end)

RegisterNetEvent('esx_snus:useSnus')
AddEventHandler('esx_snus:useSnus', function(source)

    local spelare = GetPlayerPed(-1)

    if not usingSnus and not isDead then
        usingSnus = true

        ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
            TaskPlayAnim(spelare, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
            Citizen.Wait(1000)
            ClearPedSecondaryTask(spelare)
            usingSnus = false
            --ESX.ShowNotification('Du satte upp en snus under läppen')
            exports['mythic_notify']:SendAlert('inform', 'Du satte upp en snus under läppen')
        
        end)
    end
end)


RegisterNetEvent('esx_snus:openSnusdosa')
AddEventHandler('esx_snus:openSnusdosa', function(source)

    --ESX.ShowNotification('Du öppnade din snusdosa och tog ut snuset')
    exports['mythic_notify']:SendAlert('inform', 'Du öppnade din snusdosa och tog ut snuset')
    
end) end)