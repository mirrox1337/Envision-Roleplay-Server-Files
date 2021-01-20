ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

----lagligqueststate2
ESX.RegisterServerCallback('quest1', function(source, callback)
    MySQL.Async.fetchAll('SELECT queststate2 FROM users WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(source)[1]}, function(players)
    	callback(players[1].queststate2)
    end)
end)

RegisterServerEvent('updatequest1')
AddEventHandler('updatequest1', function(queststate2)
	local identifier = ESX.GetPlayerFromId(source).identifier
    MySQL.Async.execute('UPDATE users SET queststate2=@queststate2 WHERE identifier=@identifier', {['@identifier'] = identifier, ['@queststate2'] = queststate2}, function(players)
    	print("Uppdaterad quest för " ..identifier.. " nivå " ..queststate2)
    end)
end)
----kriminellqueststate2


ESX.RegisterServerCallback('cooldown2', function(source, callback)
	MySQL.Async.fetchAll('SELECT cooldown2 FROM users WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(source)[1]}, function(cooldown2)
		callback(cooldown2[1].cooldown2)
	end)
end)	


RegisterServerEvent('cooldown2tick')
AddEventHandler('cooldown2tick', function()
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchScalar('SELECT cooldown2 FROM users WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(source)[1]}, function(cooldown2)

		if cooldown2 ~= 0 then
			local newtime = cooldown2 - 1
			MySQL.Async.execute("UPDATE users SET cooldown2=@cooldown2 WHERE identifier=@identifier", {['@identifier'] = identifier, ['@cooldown2'] = newtime})
		end
	end)
end)

RegisterServerEvent('addcooldown2')
AddEventHandler('addcooldown2', function(cooldown2)
    MySQL.Async.execute('UPDATE users SET cooldown2=@cooldown2 WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(source)[1], ['@cooldown2'] = cooldown2}, function(players)
    	print("Uppdaterad cooldown2 till " .. cooldown2 .. "minuter")
    end)
end)

RegisterServerEvent('removemoney')
AddEventHandler('removemoney', function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(money)
end)

RegisterServerEvent('fishes')
AddEventHandler('fishes', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local Fishquantity = xPlayer.getInventoryItem('lfish').count

	if Fishquantity > 39 then
		TriggerClientEvent('swizz:update', _source)
        xPlayer.removeInventoryItem('lfish', 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Tack för hjälpen!', length = 2500 })	
        TriggerServerEvent('dailyquest:reward2')
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Vart är dom då? Kom tillbaks senare!', length = 2500 })	
	end	
end)

RegisterServerEvent('dailyquest:reward2')
AddEventHandler('dailyquest:reward2', function()
  local xPlayer = ESX.GetPlayerFromId(source)


  if xPlayer ~= nil then
    local randomNumber = math.random(11)

    local weapon = ''

    if randomNumber == 11 then
      xPlayer.addMoney(1990)
      weapon = '1990kr'
      print("Pengar")
    elseif randomNumber == 10 then
      xPlayer.addInventoryItem('methlab', 1)
      weapon = 'Portabel spis'
    elseif randomNumber == 9 then
      xPlayer.addInventoryItem('scratchoff', 15)
      weapon = 'Trisslotter'
    elseif randomNumber == 8 then
      xPlayer.addInventoryItem('lfish', 50)
      weapon = 'Torsk'
    elseif randomNumber == 7 then
      xPlayer.addInventoryItem('pizza', 15)
      weapon = 'Kebabpizza'
    elseif randomNumber == 6 then
      xPlayer.addInventoryItem('acetone', 5)
      weapon = 'Aceton'
    elseif randomNumber == 5 then
      xPlayer.addInventoryItem('bread', 15)
      weapon = 'Bröd'
    elseif randomNumber == 4 then
      xPlayer.addMoney(1400)
      weapon = '1400kr'
      print("Pengar")
    elseif randomNumber == 3 then
      xPlayer.addMoney(1590)
      weapon = '1590kr'
      print("Pengar")
    else
      xPlayer.addMoney(3000)
      weapon = '3000kr'
      print("Pengar")
    end

      TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du får ' .. weapon .. ' av mig!', length = 2500 })    

  end
end)

