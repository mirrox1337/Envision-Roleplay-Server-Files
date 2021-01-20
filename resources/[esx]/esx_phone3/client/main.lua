local PhoneData = {["phoneNumber"] = 0, ["contacts"] = {}}
local CurrentActionMsg, CurrentActionData = '', {}
local HasFocus, IsOpen = false
local CellphoneProp = nil

local activeChannel = 0
DecorRegister("phoneChannel", 1)

ESX = nil

Citizen.CreateThread(function()
    while not ESX do
        Citizen.Wait(5)

        ESX = exports["es_extended"]:getSharedObject()
    end


	if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

		TriggerServerEvent('esx_phone:firstLoad')
    end

        SetNuiFocus(false)
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData

	TriggerServerEvent('esx_phone:firstLoad')
end)

RegisterNetEvent("esx_phone:loadData")
AddEventHandler("esx_phone:loadData", function(number, contacts, name, tweets)
	PhoneData["phoneNumber"] = number
	PhoneData["contacts"] = contacts
	PhoneData["characterName"] = name

	SendNUIMessage({
		["reloadPhone"] = true,
		["phoneData"] = PhoneData
	})

	for i=1, #tweets do
		SendNUIMessage({
			["reloadTweets"] = true,
			["date"] = tweets[i]["date"],
			["message"] = tweets[i]["message"]
		})
	end
end)

RegisterNetEvent("esx_phone:refreshContacts")
AddEventHandler("esx_phone:refreshContacts", function(contacts)
	PhoneData["contacts"] = contacts

	SendNUIMessage({
		["reloadPhone"] = true,
		["phoneData"] = PhoneData
	})
end)

RegisterNetEvent('esx_phone:onMessage')
AddEventHandler('esx_phone:onMessage', function(phoneNumber, message, position, anon, job, dispatch)

	if hasPhone() then
		if job == 'player' then
			ESX.ShowNotification('Nytt meddelande')
		else
			ESX.ShowNotification(job .. ' - ' .. message)
		end

		PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
		Citizen.Wait(300)
		PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
		Citizen.Wait(300)
		PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)

		if dispatch then

			CurrentAction = 'dispatch'
			CurrentActionMsg = 'Tryck ~INPUT_CONTEXT~ för att svara.\nTryck ~INPUT_DETONATE~ för att ignorera samtalet.'

			CurrentActionData = {
				["phoneNumber"] = anon and '-1' or phoneNumber,
				["position"] = position
			}

			SetTimeout(15000, function()
				if CurrentAction then
					CurrentAction = nil
				end
			end)
		end
	end

	SendNUIMessage({
		["newMessage"] = true,
		["phoneNumber"] = anon and '-1' or phoneNumber,
		["message"] = message,
		["position"] = position,
		["anon"] = anon,
		["job"] = job
	})
end)

RegisterNetEvent('esx_phone:tweet')
AddEventHandler('esx_phone:tweet', function(message)
	SendNUIMessage({
		["newTweet"] = true,
		["message"] = message
	})
end)

RegisterNetEvent('esx_phone:incomingCall')
AddEventHandler('esx_phone:incomingCall', function(target, channel, number, emergency)
	if not IsPedDeadOrDying(PlayerPedId()) then
		TriggerServerEvent('esx_phone:tryOpenPhoneCalling', target, channel, number, emergency)
	else
		TriggerServerEvent('esx_phone:tryOpenPhoneCalling', target, channel, number, emergency)
	end
end)

RegisterNetEvent('esx_phone:openPhoneCalling')
AddEventHandler('esx_phone:openPhoneCalling', function(target, channel, number, emergency)
	if not IsOpen then
		OpenPhone()
	end

	SendNUIMessage({
		["incomingCall"] = true,
		["target"] = target,
		["channel"] = channel,
		["number"] = number,
		["emergency"] = emergency
	})
end)

RegisterNetEvent('esx_phone:onAcceptCall')
AddEventHandler('esx_phone:onAcceptCall', function(channel, target, answered)
	SendNUIMessage({
		["acceptedCall"] = answered,
		["channel"] = channel,
		["target"] = target,
    ["isCaller"] = false,
	})

	if not Config.EnableTokoVoip then
    	DecorSetInt(PlayerPedId(), "phoneChannel", channel + 1)
	else
		exports["tokovoip_script"]:addPlayerToRadio(channel + 1)
	end

	activeChannel = channel + 1
end)

RegisterNetEvent('esx_phone:endCall')
AddEventHandler('esx_phone:endCall', function(msg)
	if msg then
		ESX.ShowNotification(msg)
	end

	SendNUIMessage({ ["endCall"] = true})

	if not Config.EnableTokoVoip then
		DecorSetInt(PlayerPedId(), "phoneChannel", 0)
	else
		if activeChannel ~= 0 then
			exports["tokovoip_script"]:removePlayerFromRadio(activeChannel)
			loadAnim()
			TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_text_read_base', 1.0, -1, -1, 50, 0, false, false, false)
		end
	end

	activeChannel = 0
end)

RegisterNUICallback('activate_gps', function(data)
	SetNewWaypoint(data["x"], data["y"])
	ESX.ShowNotification('Position angiven via GPS')
end)

RegisterNUICallback('start_call', function(data, cb)
	loadAnim()
	TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0, -1, -1, 50, 0, false, false, false)

	TriggerServerEvent('esx_phone:startCall', data["number"], PhoneData["phoneNumber"])
	cb('OK')
end)

RegisterNUICallback('accept_call', function(data, cb)

	loadAnim()
	TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0, -1, -1, 50, 0, false, false, false)

	TriggerServerEvent('esx_phone:acceptCall', data["target"], data["channel"])

	if not Config.EnableTokoVoip then
    	DecorSetInt(PlayerPedId(), "phoneChannel", data["channel"] + 1)
	else
		exports["tokovoip_script"]:addPlayerToRadio(data["channel"] + 1)
	end

	activeChannel = data["channel"] + 1

	cb('OK')
end)

RegisterNUICallback('remove_call', function(data, cb)
	TriggerServerEvent('esx_phone:removeCall', data["target"])
	cb('OK')
end)

RegisterNUICallback('end_call', function(data, cb)
	TriggerEvent('esx_phone:endCall', "Samtalet avslutades")
	TriggerServerEvent('esx_phone:endCall', data["channel"], data["target"], data["answered"])
	cb('OK')
end)

RegisterNUICallback('send', function(data)
	local phoneNumber = data["number"]
	local coords = GetEntityCoords(PlayerPedId())

	if tonumber(phoneNumber) then
		phoneNumber = 0 .. tonumber(phoneNumber)
	end

	TriggerServerEvent('esx_phone:send', phoneNumber, data["message"], data["anon"], {
		["x"] = coords["x"],
		["y"] = coords["y"],
		["z"] = coords["z"]
	}, false)

	ESX.ShowNotification('Meddelande skickat')
end)

RegisterNUICallback('tweet', function(data)

	TriggerServerEvent('esx_phone:tweet', data["message"], data["date"])

	ESX.ShowNotification('Tweet skickat')
end)

RegisterNUICallback('remove_contact', function(data, cb)
	if Config.NumberToJob[tonumber(data["number"])] then
		number = tonumber(data["number"])
	else
		number = 0 .. tonumber(data["number"])
	end

	ESX.ShowNotification("Du tog bort en kontakt med numret " .. number)
	TriggerServerEvent('esx_phone:removePlayerContact', number)

	ClosePhone()

	for i=1, #PhoneData["contacts"] do
		if tostring(PhoneData["contacts"][i]["number"]) == tostring(number) then
			table.remove(PhoneData["contacts"], i)

			SendNUIMessage({
				["reloadPhone"] = true,
				["phoneData"] = PhoneData
			})
		end
	end

	cb('OK')
end)

RegisterNUICallback('add_contact', function(data, cb)
	if tonumber(data["phoneNumber"]) then
		if Config.NumberToJob[tonumber(data["phoneNumber"])] then
			number = tonumber(data["phoneNumber"])
		else
			number = 0 .. tonumber(data["phoneNumber"])
		end

		local contactName = tostring(data["contactName"])

		TriggerServerEvent('esx_phone:addPlayerContact', number, contactName)

		ClosePhone()
	else
		ESX.ShowNotification("Du måste skriva in ett giltigt telefonnummer")
	end

	cb('OK')
end)

RegisterNUICallback('escape', function()
	ClosePhone()
end)

RegisterNUICallback('request_focus', function()
	HasFocus = true
	SetNuiFocus(true, true)
end)

RegisterNUICallback('release_focus', function()
  	HasFocus = false
	SetNuiFocus(false)
end)

RegisterNUICallback('send_swish', function(data, cb)
	if tonumber(data["phoneNumber"]) and tonumber(data["amount"]) then
		TriggerServerEvent('esx_phone:swish', tonumber(data["amount"]), tonumber(data["phoneNumber"]))
	else
		ESX.ShowNotification('Ogiltigt beglopp')
	end
end)

Citizen.CreateThread(function()
  	while true do

		Wait(0)

		if IsOpen then

			if IsControlJustReleased(0, 27) then
				SendNUIMessage({
					["controlPressed"] = true,
					["control"] = 'TOP'
				})
			end

			if IsControlJustReleased(0, 173) then
				SendNUIMessage({
					["controlPressed"] = true,
					["control"] = 'DOWN'
				})
			end

			if IsControlJustReleased(0, 174) then
				SendNUIMessage({
					["controlPressed"] = true,
					["control"] = 'LEFT'
				})
			end

			if IsControlJustReleased(0, 175) then
				SendNUIMessage({
					["controlPressed"] = true,
					["control"] = 'RIGHT'
				})
			end

			if IsControlJustReleased(0, 191) then
				SendNUIMessage({
					["controlPressed"] = true,
					["control"] = 'ENTER'
				})
			end

			if IsControlJustReleased(0, 177) then
				SendNUIMessage({
					["controlPressed"] = true,
					["control"] = 'BACKSPACE'
				})
			end

			if IsControlJustReleased(0, 318) then
				SendNUIMessage({ ["activateGPS"] = true })
			end

		else
			if IsControlJustReleased(0, 288) and not IsPedDeadOrDying(PlayerPedId()) and PhoneData["phoneNumber"] ~= 0 then
				if hasPhone() then
					OpenPhone()
				else
					ESX.ShowNotification("Du har ingen telefon")
				end
			end
		end

		if HasFocus then
			DisableControlAction(0, 1,    true) -- LookLeftRight
			DisableControlAction(0, 2,    true) -- LookUpDown
			DisableControlAction(0, 25,   true) -- Input Aim
			DisableControlAction(0, 106,  true) -- Vehicle Mouse Control Override

			DisableControlAction(0, 24,   true) -- Input Attack
			DisableControlAction(0, 140,  true) -- Melee Attack Alternate
			DisableControlAction(0, 141,  true) -- Melee Attack Alternate
			DisableControlAction(0, 142,  true) -- Melee Attack Alternate
			DisableControlAction(0, 257,  true) -- Input Attack 2
			DisableControlAction(0, 263,  true) -- Input Melee Attack
			DisableControlAction(0, 264,  true) -- Input Melee Attack 2

			DisableControlAction(0, 12,   true) -- Weapon Wheel Up Down
			DisableControlAction(0, 14,   true) -- Weapon Wheel Next
			DisableControlAction(0, 15,   true) -- Weapon Wheel Prev
			DisableControlAction(0, 16,   true) -- Select Next Weapon
			DisableControlAction(0, 17,   true) -- Select Prev Weapon
		end
  	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, 38) then

				if CurrentAction == 'dispatch' then
					ESX.TriggerServerCallback('esx_phone:getIdentity', function(firstname)
						local job = ESX.GetPlayerData()["job"]["name"]
						if job == 'ambulance' then
							TriggerServerEvent('esx_phone:alertEmployees', job, 'En ambulans åker på senaste samtal.')
							TriggerServerEvent('esx_phone:send', CurrentActionData["phoneNumber"], 'SOS Operatör: Ambulans är på väg mot din angivna larmposition. Vid skada på andra part, kontrollera så personen har puls och fria luftvägar. Om inte, påbörja hjärt- och lungräddning!', false)
						elseif job == 'police' then
							TriggerServerEvent('esx_phone:alertEmployees', job, 'En patrull åker på senaste samtal.')
							--TriggerServerEvent('esx_phone:send', CurrentActionData["phoneNumber"], 'SOS Operatör: Polis är på väg mot din angivna larmpostion. Vänligen invänta ingripande patrull för att ange uppgifter. Vid personskador, larma ambulans och försäkra dig om att personen har puls och fria luftvägar. Om inte, påbörja hjärt- och lungräddning!', false)
						else
							TriggerServerEvent('esx_phone:alertEmployees', job, firstname .. ' tar det samtalet.')
							TriggerServerEvent('esx_phone:send', CurrentActionData["phoneNumber"], firstname .. ' kommer så fort som möjligt, var god vänta på platsen.', false)
						end
					end)

					if CurrentActionData["position"] then
						SetNewWaypoint(CurrentActionData["position"]["x"],  CurrentActionData["position"]["y"])
					end
				end
				CurrentAction = nil
			elseif IsControlJustReleased(0, 47) then
				CurrentAction = nil
			end
		end
	end
end)

Citizen.CreateThread(function()
	if not Config.EnableTokoVoip then
		while true do
			for _, i in ipairs(GetActivePlayers()) do
				if NetworkIsPlayerActive(i) and DecorExistOn(GetPlayerPed(i), "phoneChannel") and activeChannel ~= 0 and DecorGetInt(GetPlayerPed(i), "phoneChannel") == activeChannel then
					NetworkOverrideSendRestrictions(i, true)
				elseif NetworkIsPlayerActive(i) then
					NetworkOverrideSendRestrictions(i, false)
				end
			end

			Citizen.Wait(250)
		end
	end
end)

function OpenPhone()

	IsOpen = true
	HasFocus = false
  TriggerEvent('esx_phone:loadCallHistory')
	SendNUIMessage({ ["showPhone"] = true })

	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local bone = GetPedBoneIndex(playerPed, 28422)
	local phoneModel = GetHashKey('prop_npc_phone_02')

	Citizen.CreateThread(function()

		loadAnim()
		TaskPlayAnim(playerPed, 'cellphone@', 'cellphone_text_read_base', 1.0, -1, -1, 50, 0, false, false, false)

		RequestModel(phoneModel)
		while not HasModelLoaded(phoneModel) do
			Citizen.Wait(0)
		end

		CellphoneProp = CreateObject(phoneModel, coords, 1, 1, 0)
		AttachEntityToEntity(CellphoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	end)
end

function ClosePhone()
	IsOpen = false
	HasFocus = false

	if activeChannel ~= 0 then
		TriggerEvent('esx_phone:endCall')
	end

	DeleteObject(CellphoneProp)
	CellphoneProp = nil
	SendNUIMessage({ ["showPhone"] = false })
	SetNuiFocus(false)

	loadAnim()
	TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_text_out', 1.0, -1, -1, 50, 0, false, false, false)

	Citizen.Wait(900)

	ClearPedTasks(PlayerPedId())
end

function loadAnim()
	RequestAnimDict('cellphone@')
	while not HasAnimDictLoaded('cellphone@') do
	  	Citizen.Wait(5)
	end
end

function hasPhone()
	local inventory = ESX.GetPlayerData()["inventory"]

	if inventory then
		for i=1, #inventory do
			if inventory[i]["name"] == "phone" then
				if inventory[i]["count"] > 0 then
					return true
				end
			end
		end
	end

	return false
end

RegisterNetEvent("esx_phone:loadData")
AddEventHandler("esx_phone:loadData", function(number, contacts, name, tweets)
  TriggerEvent('esx_phone:loadSavedMessages')
  TriggerEvent('esx_phone:loadCallHistory')
	PhoneData["phoneNumber"] = number
	PhoneData["contacts"] = contacts
	PhoneData["characterName"] = name

	SendNUIMessage({
		["reloadPhone"] = true,
		["phoneData"] = PhoneData
	})

	for i=1, #tweets do
		SendNUIMessage({
			["reloadTweets"] = true,
			["date"] = tweets[i]["date"],
			["message"] = tweets[i]["message"]
		})
	end
end)

--Falafelkungen Snippets
RegisterNetEvent('esx_phone:loadCallHistory')
AddEventHandler('esx_phone:loadCallHistory', function()

ESX.TriggerServerCallback('esx_phone:retrieveCallHistory', function(messages)
for i, message in ipairs(messages) do
  SendNUIMessage({
    ["callHistory"] = true,
    ["caller"] = messages[i]["caller"],
    ["timestamp"] = messages[i]["date"],
    ["number"] = messages[i]["number"],
    ["missedCall"] = messages[i]["missedCall"],
    ["prefix"] = messages[i]["prefix"],
  })
end
end)

end)

RegisterNetEvent('esx_phone:loadSavedMessages')
AddEventHandler('esx_phone:loadSavedMessages', function()

ESX.TriggerServerCallback('esx_phone:retrieveSavedMassages', function(messages)
for i, message in ipairs(messages) do
  SendNUIMessage({
    ["oldMessage"] = true,
    ["phoneNumber"] = messages[i]["number"],
    ["message"] = messages[i]["message"],
    ["date"] = messages[i]["date"],
    ["recieved"] = messages[i]["recieved"]
  })
end

end)

end)
