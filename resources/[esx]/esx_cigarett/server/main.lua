ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
		if lighter.count > 0 then
			xPlayer.removeInventoryItem('cigarett', 1)
			TriggerClientEvent('esx_cigarett:startSmoke', source)
		else
			TriggerClientEvent('esx:showNotification', source, ('Du har ingen ~r~tändare'))
		end
end)

function GetJob()

	local xPlayers = ESX.GetPlayers()

	IsPolice = false
	IsAmbulance = false
	IsTaxi = false
	IsMechanic = false
	IsCardealer = false
	IsMaklare = false
	IsMiner = false
	IsSlaktare = false
	IsUnemployed = false


	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			IsAmbulance = true
		end		
		if xPlayer.job.name == 'police' then
			IsPolice = true
		end	
		if xPlayer.job.name == 'taxi' then
			IsTaxi = true
		end
		if xPlayer.job.name == 'mekaniker' then
			IsMechanic = true
		end
		if xPlayer.job.name == 'cardealer' then
			IsCardealer = true
		end
		if xPlayer.job.name == 'realestateagent' then
			IsMaklare = true
		end	
		if xPlayer.job.name == 'miner' then
			IsMiner = true
		end
		if xPlayer.job.name == 'slaughterer' then
			IsSlaktare = true
		end	
		if xPlayer.job.name == 'unemployed' then
			IsUnemployed = true
		end	

	end

end

ESX.RegisterServerCallback('scoreboard:getjobs', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  GetJob()
cb(IsAmbulance, IsPolice, IsTaxi, IsMechanic, IsCardealer, IsMaklare, IsMiner, IsSlaktare, IsUnemployed)

end)