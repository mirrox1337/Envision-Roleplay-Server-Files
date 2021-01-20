ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)


RegisterServerEvent('esx_kocken:buyFixkit')
AddEventHandler('esx_kocken:buyFixkit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 8006) then
		xPlayer.removeMoney(8006)
		
		xPlayer.addInventoryItem('fixkit', 1)
		
		notification("Du köpte en ~g~Reparationslåda")
	else
		notification("Du har inte tillräckligt med ~r~pengar")
	end		
end)


RegisterServerEvent('esx_kocken:buyBulletproof')
AddEventHandler('esx_kocken:buyBulletproof', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 35000) then
		xPlayer.removeMoney(35000)
		
		xPlayer.addInventoryItem('bulletproof', 1)
		
		notification("Du köpte en ~g~Skottsäker väst")
	else
		notification("Du har inte tillräckligt med ~r~pengar")
	end		
end)


RegisterServerEvent('esx_kocken:buyDrill')
AddEventHandler('esx_kocken:buyDrill', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 45000) then
		xPlayer.removeMoney(45000)
		
		xPlayer.addInventoryItem('drill', 1)
		
		notification("Du köpte en ~g~borrmaskin")
	else
		notification("Du har inte tillräckligt med ~r~pengar")
	end		
end)


RegisterServerEvent('esx_kocken:buyBlindfold')
AddEventHandler('esx_kocken:buyBlindfold', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 16214) then
		xPlayer.removeMoney(16214)
		
		xPlayer.addInventoryItem('blindfold', 1)
		
		notification("Du köpte en ~g~ögonbindel")
	else
		notification("Du har inte tillräckligt med ~r~pengar")
	end		
end)


RegisterServerEvent('esx_kocken:buyFishingrod')
AddEventHandler('esx_kocken:buyFishingrod', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 2591) then
		xPlayer.removeMoney(2591)
		
		xPlayer.addInventoryItem('fishing_rod', 1)
		
		notification("Du köpte en ~g~fiskespö")
	else
		notification("Du har inte tillräckligt med ~r~pengar")
	end		
end)

RegisterServerEvent('esx_kocken:buyAntibiotika')
AddEventHandler('esx_kocken:buyAntibiotika', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 1239) then
		xPlayer.removeMoney(1239)
		
		xPlayer.addInventoryItem('anti', 1)
		
		notification("Du köpte en ~g~antibiotika")
	else
		notification("Du har inte tillräckligt med ~r~pengar")
	end		
end)

RegisterServerEvent('esx_kocken:buyWEAPON_SWITCHBLADE')
AddEventHandler('esx_kocken:buyWEAPON_SWITCHBLADE', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 55000) then
		xPlayer.removeMoney(55000)
		
		xPlayer.addInventoryItem('WEAPON_SWITCHBLADE', 1)
		
		notification("Du köpte en  ~g~switchblade")
	else
		notification("Du har inte tillräckligt med ~r~pengar")
	end		
end)


-----Sälj
RegisterServerEvent('esx_kocken:sellring')
AddEventHandler('esx_kocken:sellring', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local ring = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "ring" then
			ring = item.count
		end
	end
    
    if ring > 0 then
        xPlayer.removeInventoryItem('ring', 1)
        xPlayer.addAccountMoney('black_money', 800)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon ring att sälja !')
    end
end)

RegisterServerEvent('esx_kocken:sellsmycke')
AddEventHandler('esx_kocken:sellsmycke', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local smycke = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "smycke" then
			smycke = item.count
		end
	end
    
    if smycke > 0 then
        xPlayer.removeInventoryItem('smycke', 1)
        xPlayer.addAccountMoney('black_money', 700)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon smycke att sälja!')
    end
end)

RegisterServerEvent('esx_kocken:sellklocka')
AddEventHandler('esx_kocken:sellklocka', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local rolex = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "rolex" then
			rolex = item.count
		end
	end
    
    if rolex > 0 then
        xPlayer.removeInventoryItem('rolex', 1)
        xPlayer.addAccountMoney('black_money', 5500)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon klocka att sälja !')
    end
end)

RegisterServerEvent('esx_kocken:sellarmband')
AddEventHandler('esx_kocken:sellarmband', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local dildo = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "dildo" then
			dildo = item.count
		end
	end
    
    if dildo > 0 then
        xPlayer.removeInventoryItem('dildo', 1)
        xPlayer.addAccountMoney('black_money', 500)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon dildo att sälja!')
    end
end)
-- Sälj Dildo
RegisterServerEvent('esx_kocken:sellhalsband')
AddEventHandler('esx_kocken:sellhalsband', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local dildo = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "dildo" then
			dildo = item.count
		end
	end
    
    if dildo > 0 then
        xPlayer.removeInventoryItem('dildo', 1)
        xPlayer.addAccountMoney('black_money', 100)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon dildo att sälja!')
    end
end)

RegisterServerEvent('esx_kocken:selltelefon')
AddEventHandler('esx_kocken:selltelefon', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local mp3 = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "mp3" then
			mp3 = item.count
		end
	end
    
    if mp3 > 0 then
        xPlayer.removeInventoryItem('mp3', 1)
        xPlayer.addAccountMoney('black_money', 62)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte några mp3 att sälja!')
    end
end)

RegisterServerEvent('esx_kocken:sellfishingrod')
AddEventHandler('esx_kocken:sellfishingrod', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local fishingrod = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "fishingrod" then
			fishingrod = item.count
		end
	end
  
    if fishingrod > 0 then
        xPlayer.removeInventoryItem('fishingrod', 1)
        xPlayer.addAccountMoney('black_money', 1)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte något fiskespö att sälja!')
    end
end)

RegisterServerEvent('esx_kocken:selldrill')
AddEventHandler('esx_kocken:selldrill', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local drill = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "drill" then
			drill = item.count
		end
	end
    
    if drill > 0 then
        xPlayer.removeInventoryItem('drill', 1)
        xPlayer.addAccountMoney('black_money', 1)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon borrmaskin att sälja!')
    end
end)

RegisterServerEvent('esx_kocken:sellblindfold')
AddEventHandler('esx_kocken:sellblindfold', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local ipod = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "ipod" then
			ipod = item.count
		end
	end
    
    if ipod > 0 then
        xPlayer.removeInventoryItem('ipod', 1)
        xPlayer.addAccountMoney('black_money', 300)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon ipod att sälja!')
    end
end)

--- SÄLJ Systemkamera
RegisterServerEvent('esx_kocken:sellshirt')
AddEventHandler('esx_kocken:sellshirt', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local systemkamera = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "systemkamera" then
			systemkamera = item.count
		end
	end
    
    if systemkamera > 0 then
        xPlayer.removeInventoryItem('systemkamera', 1)
        xPlayer.addAccountMoney('black_money', 350)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon kamera att sälja!')
    end
end)

--- SÄLJ Kondom
RegisterServerEvent('esx_kocken:sellpants')
AddEventHandler('esx_kocken:sellpants', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local kondom = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "kondom" then
			kondom = item.count
		end
	end
    
    if kondom > 0 then
        xPlayer.removeInventoryItem('kondom', 1)
        xPlayer.addAccountMoney('black_money', 50)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon kondom att sälja!')
    end
end)

--- SÄLJ Iphoneladdare
RegisterServerEvent('esx_kocken:sellshoes')
AddEventHandler('esx_kocken:sellshoes', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local laddare = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "laddare" then
			laddare = item.count
		end
	end
    
    if laddare > 0 then
        xPlayer.removeInventoryItem('laddare', 1)
        xPlayer.addAccountMoney('black_money', 249)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon laddare att sälja!')
    end
end)

--- SÄLJ Rolex
RegisterServerEvent('esx_kocken:selldildo')
AddEventHandler('esx_kocken:selldildo', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local dildo = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "dildo" then
			dildo = item.count
		end
	end
    
    if dildo > 0 then
        xPlayer.removeInventoryItem('dildo', 1)
        xPlayer.addAccountMoney('black_money', 500)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon dildos att sälja!')
    end
end)

-- Sälj extranyckel
--- SÄLJ dildo
RegisterServerEvent('esx_kocken:sellextranyckel')
AddEventHandler('esx_kocken:sellextranyckel', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local extranyckel = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "extranyckel" then
			extrancykel = item.count
		end
	end
    
    if extranyckel > 0 then
        xPlayer.removeInventoryItem('extranyckel', 1)
        xPlayer.addAccountMoney('black_money', 1)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du har inte någon extranyckel att sälja!')
    end
end)


function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end