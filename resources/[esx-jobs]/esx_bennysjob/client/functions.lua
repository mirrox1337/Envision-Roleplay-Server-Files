

OpenCloakroom = function()
    ESX.UI.Menu.CloseAll()
    local elements = { 
        { ["label"] = "Civilklädsel", ["usage"] = "civilwear" },
    }
    for k,v in ipairs(Config["clothes"]) do
        table.insert(elements, {
            ["label"] = v["label"],
            ["clothe"] = v["clothe"]
        })
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
    {
        ["title"] = "Omklädningsmeny",
        ["align"] = "right",
        ["elements"] = elements
    }, function(data, menu)
        if data["current"]["usage"] == "civilwear" then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
                local playerPed = GetPlayerPed(-1)
                SetPedArmour(playerPed, 0)
                ClearPedBloodDamage(playerPed)
                ResetPedVisibleDamage(playerPed)
                ClearPedLastWeaponDamage(playerPed)
            end)
        else
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin["sex"] == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, data["current"]["clothe"]["male"])
                else
                    TriggerEvent('skinchanger:loadClothes', skin, data["current"]["clothe"]["female"])
                end
                local playerPed = GetPlayerPed(-1)
                SetPedArmour(playerPed, 0) ClearPedBloodDamage(playerPed) ResetPedVisibleDamage(playerPed) ClearPedLastWeaponDamage(playerPed)      
            end)
        end

    end, function(data, menu)
        menu.close()
    end
    )
end

Locations = function(place)
    if place == "cloakroom" then OpenCloakroom()
	elseif place == "storage" then OpenStorage()
	elseif place == "billing" then exports["t0sic_billing"]:SendBilling()
	elseif place == "Bestallningar" then
	elseif place == "bossmeny" then 
		OpenBossAction()
	end
end

DrawAdvancedMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, markerData["a"] or 100, false, true, 2, false, false, false, false)
end

help = function(msg)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

OpenBossAction = function()
	if ESX.PlayerData["job"]["grade_name"] == "boss" then
	  ESX.UI.Menu.CloseAll()
	  ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'boss', {
		["title"] = "Företagshandlingar",
		["align"] = "right",
		["elements"] = {
		  {
			["label"] = "Inköpning",
		  },
		  {
			["label"] = "Chef-handlingar"
		  }
		}
	  }, function(data, menu)
		local action = data["current"]["label"]
		if action == "Inköpning" then
		  local items = {}
		  local elements = {}
		  for itemIndex, itemData in pairs(Config["Inkopning"]["Items"]) do
			table.insert(elements, {
			  ["label"] = itemData["label"] .. " - <span style='color:green'>" .. itemData["price"] .. " SEK</span>",
			  ["itemLabel"] = itemData["label"],
			  ["item"] = itemData["item"],
			  ["price"] = itemData["price"]
			})
		  end
		  ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'inkopning', {
			["title"] = "Inköpning",
			["align"] = "right",
			["elements"] = elements
		  }, function(data2, menu2)
  
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'item', {
			  ["title"] = data2["current"]["itemLabel"],
			  ["align"] = "right",
			  ["elements"] = {
				{ ["label"] = "Köp in " .. data2["current"]["itemLabel"], ["value"] = 1, ["type"] = "slider", ["min"] = 1, ["max"] = 999999 }
			  }
			}, function(data3, menu3)
			  ESX.UI.Menu.CloseAll()
			  TriggerServerEvent("nxrp-bennys:inKopning", data2["current"]["item"], data2["current"]["itemLabel"], data3["current"]["value"], data2["current"]["price"], 'bennys')
			end, function(data3, menu3)
			  menu3.close()
			end
			)
			
		  end, function(data2, menu2)
			menu2.close()
		  end
		  )
		elseif action == "Chef-handlingar" then
		  TriggerEvent('esx_society:openBossMenu', 'bennys', function(data, menu)
			menu.close()
		  end)
		end
	  end, function(data, menu)
		menu.close()
	  end
	  )
	else
	  ESX.ShowNotification("Du är inte chef över detta företag.")
	end
  end

RegisterNetEvent("nxrp-bennys:updateStorage")
AddEventHandler("nxrp-bennys:updateStorage", function()
	if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "storagee") then
		local openedMenu = ESX.UI.Menu.GetOpened("default", GetCurrentResourceName(), "storagee")

		if openedMenu then
			openedMenu.close()
			OpenStorage()
		end
	end
end)

OpenStorage = function()
	ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('nxrp-bennys:getStockItems', function(items, weapons)
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

		ESX.UI.Menu.Open("default", GetCurrentResourceName(), "storagee", {
			["title"] = "Förrådet",
			["align"] = "right",
			["elements"] = elements
		}, function(data, menu)
			local value = data["current"]["value"]
			if value == 'additem' then
				AddItemToStorage()
			else
				if data["current"]["type"] == 'weapon' then
					ESX.TriggerServerCallback('nxrp-bennys:removeArmoryWeapon', function()
						OpenStorage()
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
							TriggerServerEvent('nxrp-bennys:getStockItem', itemName, count)
		
							Citizen.Wait(300)
							OpenStorage()
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end


		end, function(data, menu)
			menu.close()
		end
		)
	end)
end

AddItemToStorage = function()
	ESX.TriggerServerCallback('nxrp-bennys:getPlayerInventory', function(inventory)
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
						TriggerServerEvent('nxrp-bennys:putStockItems', itemName, count)
						Wait(300)
	
						AddItemToStorage()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			else
				ESX.TriggerServerCallback('nxrp-bennys:addArmoryWeapon', function()
					AddItemToStorage()
				end, data["current"]["value"], true)
			end
		end, function(data, menu)
			menu.close()
			OpenStorage()
		end
		)

	end)
end