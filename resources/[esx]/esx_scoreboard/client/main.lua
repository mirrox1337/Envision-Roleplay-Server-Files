
local idVisable = true
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(2000)
	ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)


RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)


function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList = {}
	local ems = '<i class="fas fa-medkit" style="color:#656565"></i>'
	local police = '<i class="fas fa-user-shield" style="color:#656565"></i>'
	local mecano = '<i class="fas fa-wrench" style="color:#656565"></i>'
	local cardealer = '<i class="fas fa-car" style="color:#656565"></i>'
	local bennys = '<i class="fas fa-spray-can" style="color:#656565"></i>'
	local realestateagent = '<i class="fas fa-home" style="color:#656565"></i>'
	local lawyer = '<i class="fas fa-gavel" style="color:#656565"></i>'
	local Securitas = '<i class="fas fa-shield-alt" style="color:#656565"></i>'
	local players = 0
	
	
	for k,v in pairs(connectedPlayers) do
		--table.insert(formattedPlayerList, ('<tr><td>?</td><td>%s</td></tr>'):format(v.id))
		players = players + 1

		if v.job == 'ambulance' then
			ems = ('<i class="fa fa-medkit" style="color:#f1eeeee6"></i>')
		elseif v.job == 'police' then
			police = ('<i class="fas fa-user-shield" style="color:#f1eeeee6"></i>')
		elseif v.job == 'mekaniker' then
			mecano = ('<i class="fas fa-wrench" style="color:#f1eeeee6"></i>')
		elseif v.job == 'cardealer' then
			cardealer = ('<i class="fas fa-car" style="color:#f1eeeee6"></i>')
		elseif v.job == 'realestateagent' then
			realestateagent = ('<i class="fas fa-home" style="color:#f1eeeee6"></i>')
		elseif v.job == 'bennys' then
			bennys = ('<i class="fas fa-spray-can" style="color:#f1eeeee6"></i>')
		elseif v.job == 'lawyer' then
			lawyer = ('<i class="fas fa-gavel" style="color:#f1eeeee6"></i>')
		elseif v.job == 'Securitas' then
			Securitas = ('<i class="fas fa-shield-alt style="color:#f1eeeee6"></i>')
		end
	end

	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ems = ems, police = police, Securitas = Securitas, lawyer = lawyer, mecano = mecano, bennys = bennys, cardealer = cardealer, realestateagent = realestateagent, player_count = players}
	})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlPressed(0, 10) and IsInputDisabled(0) then
			ToggleScoreBoard()
			Citizen.Wait(200)

		-- D-pad up on controllers works, too!
		elseif IsControlJustReleased(0, 172) and not IsInputDisabled(0) then
			ToggleScoreBoard()
			Citizen.Wait(200)
		end
	end
end)

-- Close scoreboard when game is paused
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end