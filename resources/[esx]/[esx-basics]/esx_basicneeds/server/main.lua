ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)

ESX.RegisterUsableItem('cheesebows', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('cheesebows', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)
	
ESX.RegisterUsableItem('chips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('chips', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)
	
ESX.RegisterUsableItem('marabou', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('marabou', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)
	
ESX.RegisterUsableItem('pizza', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('pizza', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)
	
ESX.RegisterUsableItem('burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('burger', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 240000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)
	
ESX.RegisterUsableItem('burger1', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('burger1', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 240000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('burgare3', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('burgare3', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 240000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('burger2', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('burger2', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 240000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('burger3', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('burger3', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 240000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('burger4', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('burger4', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 240000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('burgare1', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('burgare1', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 240000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)
	
ESX.RegisterUsableItem('pastacarbonara', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('pastacarbonara', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('bolcacahuetes', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('bolcacahuetes', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('bolnoixcajou', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('bolnoixcajou', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('bolpistache', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('bolpistache', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('bolchips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('bolchips', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('saucisson', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('saucisson', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)

ESX.RegisterUsableItem('grapperaisin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('grapperaisin', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)
	
ESX.RegisterUsableItem('macka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('macka', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)
	
ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('water', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst',250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('cocacola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('cocacola', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('fanta', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('fanta', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('sprite', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('loka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('loka', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)


ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('icetea', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)

ESX.RegisterUsableItem('drpepper', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('drpepper', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('limonade', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('limonade', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 300000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('drpepper', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('drpepper', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('energy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('energy', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 400000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)

ESX.RegisterUsableItem('jusfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('jusfruit', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 400000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)

ESX.RegisterUsableItem('soda', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('soda', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 400000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('mixapero', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
		
	xPlayer.removeInventoryItem('mixapero', 1)
	
	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_status:remove', source, 'thirst', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)

end)
	
ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodka', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('fireball', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fireball', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('sourz', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sourz', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('jager', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('jager', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 320000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('vinva', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('vinva', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 320000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('rhum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('rhum', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 240000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('rhumcoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('rhumcoca', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 240000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('whisky', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('jagerbomb', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('jagerbomb', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('hotshot', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('hotshot', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('golem', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('golem', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('whiskycoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('whiskycoca', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('teqpaf', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('teqpaf', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('metreshooter', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('metreshooter', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 220000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('rhumfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('rhumfruit', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 280000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('tequila', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 280000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('bira', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('bira', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 280000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('tequilasunrise', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('tequilasunrise', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 280000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('colada', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('colada', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 280000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('vodkafruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('vodkafruit', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 280000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('jagercerbere', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('jagercerbere', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 290000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('mojito', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('mojito', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('martini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('martini', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 220000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('martini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('martini', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 220000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('champagne', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('champagne', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 220000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

ESX.RegisterUsableItem('cider', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('cider', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)
	
ESX.RegisterUsableItem('vodkaenergy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('vodkaenergy', 1)
	
	TriggerClientEvent('esx_status:add', source, 'drunk', 500000)
	TriggerClientEvent('esx_status:remove', source, 'hunger', 1000)
	TriggerClientEvent('esx_status:remove', source, 'thirst', 7000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)

end)

TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local playerId = tonumber(args[1])

		-- is the argument a number?
		if playerId then
			-- is the number a valid player?
			if GetPlayerName(playerId) then
				print(('esx_basicneeds: %s healed %s'):format(GetPlayerIdentifier(source, 0), GetPlayerIdentifier(playerId, 0)))
				TriggerClientEvent('esx_basicneeds:healPlayer', playerId)
				TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'You have been healed.' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player id.' } })
		end
	else
		print(('esx_basicneeds: %s healed self'):format(GetPlayerIdentifier(source, 0)))
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})