openInsuranceMenu = function()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'insurancemenu',
    {
        ["title"] = "Försäkringsmenyn",
        ["align"] = "right",
        ["elements"] = {
			{ ["label"] = "Sök upp fordon", ["usage"] = "forsakra" },
			{ ["label"] = "Ge faktura", ["usage"] = "bill" },
			{ ["label"] = "Öppna chefmenyn", ["usage"] = "boss" }
        }
    }, function(data, menu)
        local usage = data["current"]["usage"]
        if usage == "forsakra" then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'searchafterlicenseplate', {
				["tile"] = "Sök efter registeringsskyltar (ex: ABC 123)"
			}, function(data2, menu2)
				local plate = data2.value

				if plate == nil then
					ESX.ShowNotification('Du måste ange ett giltigt registeringsnummer...')
				else
					menu2.close()
					menu.close()
					OpenSearchMenu(plate)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif usage == "bill" then
			exports["t0sic_billing"]:SendBilling()

		elseif usage == "boss" then
			if ESX.PlayerData["job"]["grade_name"] == "boss" then
				TriggerEvent('esx_society:openBossMenu', 'forsakring', function(data, menu)
					menu.close()
				end)
			else
				ESX.ShowNotification("Du är inte chef.")
			end
		end

    end, function(data, menu)
        menu.close()
    end
    )
end

OpenSearchMenu = function(plate)
    ESX.TriggerServerCallback('nxrp-forsakringsbolaget:searchPlate', function(vehicle, owner, exists, forsakrad)
        local elements = {}
        if not exists then
            table.insert(elements, { ["label"] = "Inget fordon hittades.", ["usage"] = ""})
        else
            for k,v in ipairs(vehicle) do
                local vehicleProps = v["props"]
                if not forsakrad then
                    table.insert(elements, { ["label"] = "Försäkra fordonet", ["usage"] = "forsakra", ["model"] = GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps["model"]))} )
                else
                    table.insert(elements, { ["label"] = "Ta bort försäkringen", ["usage"] = "tabort"})
                end
                table.insert(elements, { ["label"] = "Ägare: " .. owner, ["usage"] = ""})
                table.insert(elements, { ["label"] = "Plåt: " .. vehicleProps["plate"], ["usage"] = ""})
                table.insert(elements, { ["label"] = "Modell: " .. GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps["model"])), ["usage"] = ""})
            end
        end
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'searchmenu',
        {
            ["title"] = "Fordonsökning",
            ["align"] = "right",
            ["elements"] = elements
        }, function(data, menu)
            local usage = data["current"]["usage"]
            if usage == "forsakra" then
                TriggerServerEvent('nxrp-forsakringsbolaget:forsakraFordon', plate, true, data["current"]["model"])
                Wait(100)
                OpenSearchMenu(plate)
            elseif usage == "tabort" then
                TriggerServerEvent('nxrp-forsakringsbolaget:forsakraFordon', plate, false, false)
                Wait(100)
                OpenSearchMenu(plate)
            end
        end, function(data, menu)
            menu.close()
        end
        )
    end, plate)
end

DrawAdvancedMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, markerData["a"] or 100, false, true, 2, false, false, false, false)
end

help = function(msg)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

OpenStorage = function(bool)
	ESX.UI.Menu.CloseAll()
    ESX.TriggerServerCallback('nxrp-forsakringsbolaget:getStockItems', function(items, weapons, active)
        if bool == false then
            if active then return ESX.ShowNotification(Strings["waitforyourturn"]) end
        end
		TriggerServerEvent("nxrp-forsakringsbolaget:active", true)
		
		local elements = {
			{
				["label"] = "Lägg in",
				["value"] = "additem"
			}
		}

		for i=1, #items, 1 do
			if items[i]["count"] > 0 then
				table.insert(elements, {
					label = items[i]["label"] .. ' - ' .. items[i]["count"] .. 'st',
					type = 'item',
					value = items[i]["name"]
				})
			end
		end

		for i=1, #weapons, 1 do
			if weapons[i]["count"] > 0 then
				table.insert(elements, {
					label = ESX.GetWeaponLabel(weapons[i]["name"]) .. ' - ' .. weapons[i]["count"] .. 'st' ,
					type = 'weapon',
					value = weapons[i]["name"]
				})
			end
		end

		ESX.UI.Menu.Open("default", GetCurrentResourceName(), "32323", {
			["title"] = "Förrådet",
			["align"] = "right",
			["elements"] = elements
		}, function(data, menu)
			local value = data["current"]["value"]
			if value == 'additem' then
				AddItemToStorage()
			else
				if data["current"]["type"] == 'weapon' then
					ESX.TriggerServerCallback('nxrp-forsakringsbolaget:removeArmoryWeapon', function()
						OpenStorage(true)
					end, data["current"]["value"])
				elseif data["current"]["type"] == 'item' then
					local itemName = data["current"]["value"]

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_323232323item_count', {
						title ='Hur mycket?'
					}, function(data2, menu2)
						local count = tonumber(data2["value"])
		
						if count == nil then
							ESX.ShowNotification('Ogiltigt nummer...')
						else
							menu2.close()
							menu.close()
							TriggerServerEvent('nxrp-forsakringsbolaget:getStockItem', itemName, count)
		
							Citizen.Wait(300)
							OpenStorage(true)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end


		end, function(data, menu)
			menu.close()
			TriggerServerEvent("nxrp-forsakringsbolaget:active", false)
		end
		)
	end)
end

AddItemToStorage = function()
	ESX.TriggerServerCallback('nxrp-forsakringsbolaget:getPlayerInventory', function(inventory)
		local elements = {}

		local playerPed  = PlayerPedId()
		local weaponList = ESX.GetWeaponList()
	
		for i=1, #weaponList, 1 do
			local weaponHash = GetHashKey(weaponList[i]["name"])
	
			if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i]["name"] ~= 'WEAPON_UNARMED' then
				table.insert(elements, {
					label = weaponList[i]["label"],
					value = weaponList[i]["name"]
				})
			end
		end

		for i=1, #inventory["items"], 1 do
			local item = inventory["items"][i]

			if item["count"] > 0 then
				table.insert(elements, {
					label = item["label"] .. ' - ' .. item["count"] .. 'st',
					type = 'item_standard',
					value = item["name"]
				})
			end
		end

		ESX.UI.Menu.Open("default", GetCurrentResourceName(), "3232444", {
			["title"] = "Lägg in",
			["align"] = "right",
			["elements"] = elements
		}, function(data, menu)
			if data["current"]["type"] == 'item_standard' then
				local itemName = data["current"]["value"]

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
					title = 'Hur mycket?'
				}, function(data2, menu2)
					local count = tonumber(data2["value"])
	
					if count == nil then
						ESX.ShowNotification('Ogiltigt nummer...')
					else
						menu2.close()
						menu.close()
						ESX.UI.Menu.CloseAll()
						TriggerServerEvent('nxrp-forsakringsbolaget:putStockItems', itemName, count)
						Wait(300)
	
						AddItemToStorage()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			else
				ESX.TriggerServerCallback('nxrp-forsakringsbolaget:addArmoryWeapon', function()
					AddItemToStorage()
				end, data["current"]["value"], true)
			end
		end, function(data, menu)
            menu.close()
			OpenStorage(true)
		end
		)

	end)
end