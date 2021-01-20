ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('quest', function(source, callback)
    MySQL.Async.fetchAll('SELECT queststate FROM users WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(source)[1]}, function(players)
    	callback(players[1].queststate)
    end)
end)

RegisterServerEvent('updatequest')
AddEventHandler('updatequest', function(queststate)
	local identifier = ESX.GetPlayerFromId(source).identifier
    MySQL.Async.execute('UPDATE users SET queststate=@queststate WHERE identifier=@identifier', {['@identifier'] = identifier, ['@queststate'] = queststate}, function(players)
    	print("Uppdaterad quest för " ..identifier.. " nivå " ..queststate)
    end)
end)	

ESX.RegisterServerCallback('cooldown', function(source, callback)
	MySQL.Async.fetchAll('SELECT cooldown FROM users WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(source)[1]}, function(cooldown)
		callback(cooldown[1].cooldown)
	end)
end)	


RegisterServerEvent('cooldowntick')
AddEventHandler('cooldowntick', function()
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchScalar('SELECT cooldown FROM users WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(source)[1]}, function(cooldown)

		if cooldown ~= 0 then
			local newtime = cooldown - 1
			MySQL.Async.execute("UPDATE users SET cooldown=@cooldown WHERE identifier=@identifier", {['@identifier'] = identifier, ['@cooldown'] = newtime})
		end
	end)
end)

RegisterServerEvent('addcooldown')
AddEventHandler('addcooldown', function(cooldown)
    MySQL.Async.execute('UPDATE users SET cooldown=@cooldown WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(source)[1], ['@cooldown'] = cooldown}, function(players)
    	print("Uppdaterad cooldown till " .. cooldown .. "minuter")
    end)
end)	

RegisterServerEvent('dailyquest:reward')
AddEventHandler('dailyquest:reward', function()
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer ~= nil then
    local randomNumber = math.random(11)

    local weapon = ''

    if randomNumber == 11 then
      xPlayer.addMoney(3990)
      weapon = '3990kr'
    elseif randomNumber == 10 then
      xPlayer.addInventoryItem('methlab', 1)
      weapon = 'Portabel spis'
    elseif randomNumber == 9 then
      xPlayer.addInventoryItem('lUbait', 1)
      weapon = 'Stetoskop'
    elseif randomNumber == 8 then
      xPlayer.addInventoryItem('handcuff', 1)
      weapon = 'Buntband'
    elseif randomNumber == 7 then
      xPlayer.addInventoryItem('scratchoff', 15)
      weapon = 'Trisslott'
    elseif randomNumber == 6 then
      xPlayer.addInventoryItem('dildo', 1)
      weapon = 'Använd dildo'
    elseif randomNumber == 5 then
      xPlayer.addInventoryItem('weed', 20)
      weapon = 'Joint'
    elseif randomNumber == 4 then
      xPlayer.addMoney(3400)
      weapon = '3400kr'
    elseif randomNumber == 3 then
      xPlayer.addMoney(5900)
      weapon = '5900kr'
    else
      xPlayer.addMoney(4800)
      weapon = '4800kr '
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du får ' .. weapon .. ' av mig!', length = 2500 })    

end
end)

