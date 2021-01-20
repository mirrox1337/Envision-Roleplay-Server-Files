LastVehicles = {}
ESX = nil
InNPC = false
PickupPed = false

CreateThread(function()
	while not ESX do

		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)

		Wait(0)
	end
	
	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(Config["locations"]["garage"]["coords"])

		SetBlipSprite(blip, 56)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 46)
		SetBlipDisplay(blip, 4)
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Strings["blipName"])
		EndTextCommandSetBlipName(blip)
	end	

	while true do
		local sleep = 1000
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if ESX.PlayerData["job"] ~= nil and ESX.PlayerData["job"]["name"] == "taxi" then
			sleep = 5
			if IsControlJustReleased(0, 167) then
				local elements = {
					{ ["label"] = "Ge faktura", ["action"] = "billing" }
				}

				if InNPC then
					table.insert(elements, {
						["label"] = "Stoppa NPC-jobb", ["action"] = "stopnpc"
					})
				else
					table.insert(elements, {
						["label"] = "Starta NPC-jobb", ["action"] = "startnpc"
					})
				end

				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open("default", GetCurrentResourceName(), "f6meny", {
					["title"] = "Taxi",
					["align"] = "right",
					["elements"] = elements
				}, function(data, menu)
					local action = data["current"]["action"]
					if action == "billing" then
						exports["t0sic_billing"]:SendBilling()
						menu.close()
					elseif action == "startnpc" then
						if IsPedInAnyVehicle(playerPed, false) then
							local veh = GetVehiclePedIsIn(playerPed, false)
							if GetEntityModel(veh) == GetHashKey('gle450') then
								menu.close()
								StartNPC()
							else
								ESX.ShowNotification("Du måste ha en taxibil för detta...")
							end
						else
							ESX.ShowNotification("Du måste ha en taxibil för detta...")
						end
					elseif action == "stopnpc" then
						menu.close()
						ESX.ShowNotification("Du stoppade NPC-jobbet...")
						ped, PickupPed, InNPC = nil, false, false
					end
				end, function(data, menu)
					menu.close()
				end
				)
			end

			for place,value in pairs(Config["locations"]) do
				if GetDistanceBetweenCoords(coords, value["coords"], true) <= 30 then
					local dst = GetDistanceBetweenCoords(coords, value["coords"])
					if dst <= 30 then
						sleep = 5
						DrawAdvancedMarker({
							["type"] = 6,
							["pos"] = value["coords"] - vector3(0.0, 0.0, 0.98),
							["r"] = value["r"],
							["g"] = value["g"],
							["b"] = value["b"],
							["sizeX"] = value["sizeX"],
							["sizeY"] = value["sizeY"],
							["sizeZ"] = value["sizeZ"],
							["rotate"] = true
						})
						if dst <= (value["range"] or 1) then 
							help(value["text"])
							if IsControlJustReleased(0, 38) then
								Locations(place)
							end
						end
					end
				end
			end
		end
		Wait(sleep)
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)
