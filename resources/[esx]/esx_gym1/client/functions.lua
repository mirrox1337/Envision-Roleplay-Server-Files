local doingRest = false
local lastWorkout = nil

workoutsDone = 0

StartWorkout = function(workoutInfo, workoutType)
    if workoutType == "Omklädningsrum" then
        OpenWardrobe()
        return
    end

    if workoutType == lastWorkout then
        ESX.ShowNotification("Dela upp dina övningar lite, kör inte samma efter varandra.")
        return
    end

    local timeStarted, doingWorkout = GetGameTimer(), true
    
    math.randomseed(timeStarted)

    local strengthSkill = math.random(6, 10) / 10
    local gymSkill = math.random(6, 10) / 10
    local randomDamage = math.random(1, 3)

    if workoutInfo["Animation"] then
        while not HasAnimDictLoaded(workoutInfo["Animation"]["dict"]) do
            RequestAnimDict(workoutInfo["Animation"]["dict"])

            Citizen.Wait(10)
        end

        PlayAnimation(PlayerPedId(), workoutInfo["Animation"]["dict"], workoutInfo["Animation"]["anim"], {
            ["flag"] = 11
        })
    else
        TaskStartScenarioAtPosition(PlayerPedId(), workoutInfo["Scenario"], workoutInfo["Pos"], workoutInfo["Heading"] or GetEntityHeading(PlayerPedId()), 60000, false, true)
    end

    Citizen.Wait(1000)

    while doingWorkout do
        Citizen.Wait(5)

        local percent = (GetGameTimer() - timeStarted) / Config.WorkoutTimer * 100

        ESX.Game.Utils.DrawText3D({ ["x"] = workoutInfo["Pos"]["x"], ["y"] = workoutInfo["Pos"]["y"], ["z"] = workoutInfo["Pos"]["z"] + 0.500 }, "Gymmar... ~g~" .. math.floor(percent) .. "%")

        if workoutInfo["Animation"] then
            if not IsEntityPlayingAnim(PlayerPedId(), workoutInfo["Animation"]["dict"], workoutInfo["Animation"]["anim"], 3) then
                ESX.ShowNotification("Du avbröt din träning.")

                return
            end
        else
            if not IsPedUsingScenario(PlayerPedId(), workoutInfo["Scenario"]) then
                ESX.ShowNotification("Du avbröt din träning.")

                return
            end
        end

        if IsControlJustPressed(0, 73) then
            return ClearPedTasks(PlayerPedId())
        end

        if randomDamage == 2 then
            if doingRest then
                if percent > 50 then
                    ESX.ShowNotification("Du måste vila, så du inte skadar dig!")

                    SetPedToRagdoll(PlayerPedId(), 1100, 1100, 0)

                    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 5)

                    exports["skills"]:RemoveSkillLevel("Gym", tonumber(skill))

                    Citizen.Wait(1000)

                    ClearPedTasksImmediately(PlayerPedId())

                    return
                end
            end
        end

        if percent >= 100 then
            doingWorkout = false
        end
    end

    exports["gamz-skillsystem"]:UpdateSkill("Kondition", tonumber(gymSkill))
    exports["gamz-skillsystem"]:UpdateSkill("Styrka", tonumber(strengthSkill))

    workoutsDone = workoutsDone + 1
    lastWorkout = workoutType

    ClearPedTasks(PlayerPedId())

    Rest()
end	

OpenWardrobe = function()
	ESX.TriggerServerCallback("esx_eden_clotheshop:getPlayerDressing", function(dressings)
		local menuElements = {}

		for dressingIndex, dressingLabel in ipairs(dressings) do
		    table.insert(menuElements, {
                ["label"] = dressingLabel, 
                ["outfit"] = dressingIndex
            })
		end

		ESX.UI.Menu.Open("default", GetCurrentResourceName(), "motel_main_dressing_menu", {
			["title"] = "Garderob",
			["align"] = Config.AlignMenu,
			["elements"] = menuElements
        }, function(menuData, menuHandle)
            local currentOutfit = menuData["current"]["outfit"]

			TriggerEvent("skinchanger:getSkin", function(skin)
                ESX.TriggerServerCallback("esx_eden_clotheshop:getPlayerOutfit", function(clothes)
                    TriggerEvent("skinchanger:loadClothes", skin, clothes)
                    TriggerEvent("esx_skin:setLastSkin", skin)

                    TriggerEvent("skinchanger:getSkin", function(skin)
                        TriggerServerEvent("esx_skin:save", skin)
                    end)
                    
                    ESX.ShowNotification("Du bytte outfit.")
                end, currentOutfit)
			end)
        end, function(menuData, menuHandle)
			menuHandle.close()
        end)
	end)
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

        if settings["speed"] ~= nil then
          speed = settings["speed"]
        end

        if settings["speedMultiplier"] ~= nil then
          speedMultiplier = settings["speedMultiplier"]
        end

        if settings["duration"] ~= nil then
          duration = settings["duration"]
        end

        if settings["flag"] ~= nil then
          flag = settings["flag"]
        end

        if settings["playbackRate"] ~= nil then
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

Rest = function()
    timeStarted, doingRest = GetGameTimer(), true

    HandleSkill()

    Citizen.CreateThread(function()
        while doingRest do
            Citizen.Wait(5)

            local percent = (GetGameTimer() - timeStarted) / Config.RestTimer * 100

            if percent >= 100 then
                doingRest = false
            end
        end
    end)
end

HandleSkill = function()
    local gymSkill = exports["skills"]:GetSkillLevel("Stamina")
    local strengthSkill = exports["skills"]:GetSkillLevel("Strength")

    StatSetInt(GetHashKey("MP0_STAMINA"), math.floor(gymSkill), true)
    StatSetInt(GetHashKey("MP0_STRENGTH"), math.floor(strengthSkill), true)
end

LoadBlip = function()
    local WorkoutBlip = AddBlipForCoord(Config.BlipCoords)
    SetBlipSprite(WorkoutBlip, 311)
    SetBlipScale(WorkoutBlip, 0.7)
    SetBlipColour(WorkoutBlip, 30)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gymmet")
    EndTextCommandSetBlipName(WorkoutBlip)
end