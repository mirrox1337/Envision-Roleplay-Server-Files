Citizen.CreateThread(function()
	for i = 1, 15 do
		EnableDispatchService(i, true)--false 22:32 2020-02-21
	end
end)

Citizen.CreateThread(function()
      while true do
	       Wait(0)
           SetScenarioTypeEnabled("WORLD_HUMAN_COP_IDLES", false)
           SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE", false)
           SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR", false)
           SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR", false)
		   SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR", false)
		   SetScenarioTypeEnabled("CODE_HUMAN_POLICE_CROWD_CONTROL", false)
		   SetScenarioTypeEnabled("CODE_HUMAN_POLICE_INVESTIGATE", false)
		end
end)

Citizen.CreateThread(function()
       while true do
        Citizen.Wait(0)
          local playerPed = GetPlayerPed(-1)
          local playerLocalisation = GetEntityCoords(playerPed)
          ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
        end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        RemoveVehiclesFromGeneratorsInArea(-44.08, -1098.32, 26.42, -51.8, -1066.71, 27.51)
    end
end)
