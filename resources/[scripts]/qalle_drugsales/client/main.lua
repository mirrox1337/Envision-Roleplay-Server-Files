ESX = nil

cachedData = {
	["peds"] = {}
}

Citizen.CreateThread(function()
	while not ESX do
		--Fetching esx library, due to new to esx using this.

		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end

	RemoveLoadingPrompt()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

RegisterCommand("startselling", function()
	if cachedData["selling"] then AbortSelling() return end

	local ped = PlayerPedId()

	local closeToArea = false

	for areaIndex, areaCoords in ipairs(Config.SellAreas) do
		if #(GetEntityCoords(ped) - areaCoords) < Config.AreaRadius then
			closeToArea = true

			break
		end
	end

	if not closeToArea then return ESX.ShowNotification("Vänligen hitta ett bättre ställe att sälja på.") end

	ESX.ShowNotification("Vänligen stå still för att kunderna ska hitta dig.")

	cachedData["sellingArea"] = GetEntityCoords(ped)
	cachedData["selling"] = true
end)

AddEventHandler("onResourceStop", function(resourceName)
	if resourceName == GetCurrentResourceName() then
		RemoveCachedPeds()
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)

	if Config.Debug then
		for sellAreaIndex, sellAreaPosition in ipairs(Config.SellAreas) do
			local pinkCageBlip = AddBlipForCoord(sellAreaPosition)

			SetBlipSprite(pinkCageBlip, 140)
			SetBlipScale(pinkCageBlip, 1.5)
			SetBlipColour(pinkCageBlip, 25)
			SetBlipAsShortRange(pinkCageBlip, true)
		
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Säljposition")
			EndTextCommandSetBlipName(pinkCageBlip)
		end
	end

	while true do
		local sleepThread = 500

		local playerPed = PlayerPedId()
		local playerPedCoords = GetEntityCoords(playerPed)

		if cachedData["selling"] then
			sleepThread = 5

			if cachedData["sellingArea"] then
				local dstCheck = #(playerPedCoords - cachedData["sellingArea"])

				if dstCheck > 5 then
					AbortSelling()

					ESX.ShowNotification("Du rörde dig för långt ifrån din utgångspunkt och avbröt försäljningen.")
				end

				if GetGameTimer() - (cachedData["lastPed"] or 0) > Config.PedSpawnCooldown then
					cachedData["lastPed"] = GetGameTimer()

					CreateClosePed(playerPedCoords)
				end
			end

			for pedIndex, pedData in ipairs(cachedData["peds"]) do
				if IsPedDeadOrDying(pedData["entity"]) then table.remove(cachedData["peds"], pedIndex) end

				local pedCoords = GetEntityCoords(pedData["entity"])

				local dstCheck = #(playerPedCoords - pedCoords)

				if dstCheck <= 2.0 then
					local displayText = ("[~g~E~s~] Sälj ~b~%sst~s~ för ~g~%s:-~s~ | [~o~G~s~] Förhandla | [~r~N~s~] Neka"):format(pedData["amount"], pedData["offer"] * pedData["amount"])

					DrawScriptText(pedCoords, displayText)

					if IsControlJustPressed(0, 38) then
						SellDrugs(pedData, pedIndex)
					elseif IsControlJustPressed(0, 47) then
						NegotiateDrugs(pedData, pedIndex)
					elseif IsControlJustPressed(0, 306) then
						DenyDrugs(pedData, pedIndex)
					end
				end

				-- DrawLine(playerPedCoords, pedCoords, 0, 255, 0, 100)

				debug(pedIndex, "distance:", math.ceil(#(playerPedCoords - pedCoords)), "offer:", pedData["offer"], "negotiated: ", tostring(pedData["negotiated"]) or "false")
			end
		end

		Citizen.Wait(sleepThread)
	end
end)