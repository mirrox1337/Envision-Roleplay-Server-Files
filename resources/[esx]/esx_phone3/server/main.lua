ESX = nil
local DisptachRequestId = 0
local onCalls = {}
local callIndex = 0
local PhoneNumbers = {
	["ambulance"] = {
		["type"] = "SOS Alarm",
		["sharePos"] = true,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
	["cardealer"] = {
		["type"] = "Kund",
		["sharePos"] = false,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
	["police"] = {
		["type"] = "SOS Alarm",
		["sharePos"] = true,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
	["bennys"] = {
		["type"] = "Kund",
		["sharePos"] = false,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
	["mecano"] = {
		["type"] = "Kund",
		["sharePos"] = true,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
	["taxi"] = {
		["type"] = "Kund",
		["sharePos"] = true,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
	["boatdealer"] = {
		["type"] = "Kund",
		["sharePos"] = true,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
	["lawyer"] = {
		["type"] = "Kund",
		["sharePos"] = true,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
	["Securitas"] = {
		["type"] = "SOS Alarm",
		["sharePos"] = true,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
	["forsakring"] = {
		["type"] = "Kund",
		["sharePos"] = true,
		["hasDispatch"] = true,
		["hideNumber"] = false,
		["hidePosIfAnon"] = true,
		["sources"] = {}
	},
}

TriggerEvent('esx:getSharedObject', function(obj)
  	ESX = obj
end)

function onCallsChanged()
	TriggerClientEvent("sendOnCalls", -1, onCalls)
end

function GenerateUniquePhoneNumber()
	local foundNumber, phoneNumber = false, nil

	while not foundNumber do
		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		phoneNumber = "07" .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9)

		local result = MySQL.Sync.fetchAll('SELECT COUNT(*) as count FROM users WHERE phone_number = @phoneNumber', { ['@phoneNumber'] = phoneNumber })

		if tonumber(result[1]["count"]) == 0 then
			foundNumber = true
		end
	end

	return phoneNumber
end

function EndCall(source, channel, target)
	onCalls[source] = nil
	TriggerClientEvent('esx_phone:endCall', source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if target then

		local targetPlayer = ESX.GetPlayerFromId(target)
		if targetPlayer then
			onCalls[target] = nil
			TriggerClientEvent('esx_phone:endCall', target)
		end
	end

	onCallsChanged()
end

RegisterServerEvent('esx_phone:tryOpenPhoneCalling')
AddEventHandler('esx_phone:tryOpenPhoneCalling', function(target, channel, number, emergency)
	local xPlayer = ESX.GetPlayerFromId(source)
	local targetPlayer = ESX.GetPlayerFromId(target)

	if xPlayer["getInventoryItem"]('phone')["count"] > 0 then
		TriggerClientEvent('esx_phone:openPhoneCalling', source, target, channel, number, emergency)
	else
		TriggerClientEvent('esx_phone:endCall', targetPlayer["source"], 'Kontakten är ej tillgänglig.')
	end

	onCallsChanged()
end)

RegisterServerEvent('esx_phone:startCall')
AddEventHandler('esx_phone:startCall', function(number, ownNumber)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local channel = src + 1000
	local foundPlayer = 0
	local emergency = false
	TriggerEvent('esx_phone:loadSavedMessages', source)
	if xPlayer["job"]["name"] == Config.NumberToJob[number] then
		TriggerClientEvent('esx_phone:endCall', xPlayer["source"], 'Ring inte till ditt egna företag är du snäll.')
		onCallsChanged()
		return
	end



	if Config.NumberToJob[number] then
		emergency = true

		local randomizedEmployee = calculatedEmployee(Config.NumberToJob[number])

		if randomizedEmployee == 0 then
			TriggerClientEvent('esx_phone:endCall', xPlayer["source"], 'Något gick snett, ring igen eller testa senare.')

			onCallsChanged()

			return
		else
			foundPlayer = randomizedEmployee
		end
	else
		for key, values in pairs(PhoneNumbers) do
			if number == key then
				foundPlayer = getFirstTableValue(values["sources"])
				break
			end
		end
	end

	if onCalls[foundPlayer] and foundPlayer ~= 0 then
		TriggerClientEvent('esx_phone:endCall', xPlayer["source"], 'Kontakten är redan ansluten i ett samtal.')
		removePreviousCall(getNumberFromId(xPlayer["identifier"]), number)
		MySQL.Async.execute('INSERT INTO user_calls (identifier, date, caller, number, prefix, answered) VALUES (@identifier, @date, @caller, @number, @prefix, @answered)', {['@number'] = checkNumber(number), ['@date'] = os.date("%c"), ['@caller'] = getNumberFromId(xPlayer["identifier"]), ['@identifier'] = xPlayer["identifier"], ['@prefix'] = "Upptagen", ['@answered'] = 0})
		onCallsChanged()

		return
	elseif not onCalls[foundPlayer] and foundPlayer == 0 then
		TriggerClientEvent('esx_phone:endCall', xPlayer["source"], 'Kontakten är ej ansluten.')
		removePreviousCall( getNumberFromId(xPlayer["identifier"]), number)
		MySQL.Async.execute('INSERT INTO user_calls (identifier, date, caller, number, prefix, answered) VALUES (@identifier, @date, @caller, @number, @prefix, @answered)', {['@number'] = checkNumber(number), ['@date'] = os.date("%c"), ['@caller'] = getNumberFromId(xPlayer["identifier"]), ['@identifier'] = xPlayer["identifier"], ['@prefix'] = "Inget svar", ['@answered'] = 0})
		onCallsChanged()
		return
	end

	onCalls[xPlayer["source"]] = { ["channel"] = channel, ["target"] = foundPlayer, ["number"] = ownNumber, ["targetNumber"] = number}
	onCalls[foundPlayer] = { ["channel"] = channel, ["target"] = xPlayer["source"], ["number"] = number, ["targetNumber"] =  ownNumber}

	onCallsChanged()

	if emergency then
		TriggerClientEvent('esx_phone:incomingCall', foundPlayer, xPlayer["source"], channel, ownNumber, true)
	else
		TriggerClientEvent('esx_phone:incomingCall', foundPlayer, xPlayer["source"], channel, ownNumber, false)
	end
end)

function getFirstTableValue(sources)
	for key, boolean in pairs(sources) do
		return key
	end
end

function calculatedEmployee(job)
	local xPlayers = ESX.GetPlayers()
	local employeeList = {}

	for i=1, #xPlayers do
		local employee = ESX.GetPlayerFromId(xPlayers[i])

		if employee["job"]["name"] == job then
			table.insert(employeeList, {["source"] = xPlayers[i]})
		end
	end

	if #employeeList == 0 then
		return 0
	else

		math.randomseed(GetGameTimer())
		local randomIndex = math.random(1, #employeeList)

		return employeeList[randomIndex]["source"]
	end
end

RegisterServerEvent('esx_phone:acceptCall')
AddEventHandler('esx_phone:acceptCall', function(target, channel)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local gPlayer = ESX.GetPlayerFromId(target)
	TriggerClientEvent('esx_phone:onAcceptCall', target, channel, source, true)
	removePreviousCall(getNumberFromId(gPlayer["identifier"]), getNumberFromId(xPlayer["identifier"]))
	MySQL.Async.execute('INSERT INTO user_calls (identifier, date, caller, number, prefix, answered) VALUES (@identifier, @date, @caller, @number, @prefix, @answered)', {['@number'] = getNumberFromId(xPlayer["identifier"]), ['@date'] = os.date("%c"), ['@caller'] = getNumberFromId(ESX.GetPlayerFromId(target)["identifier"]), ['@identifier'] = xPlayer["identifier"], ['@prefix'] = "Samtal", ['@answered'] = 1})

end)

RegisterServerEvent("esx_phone:removeCall")
AddEventHandler("esx_phone:removeCall", function(target)
	onCalls[source] = nil
	onCalls[target] = nil
	onCallsChanged()
	TriggerClientEvent("esx_phone:endCall", target, "Kontakten parkerade samtalet.")
end)

RegisterServerEvent('esx_phone:endCall')
AddEventHandler('esx_phone:endCall', function(channel, target, state)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		local gPlayer = ESX.GetPlayerFromId(target)
		if state == false then
			TriggerEvent('esx_phone:callBusy', source, target)
		else

		end
  	EndCall(source, channel, target)
end)

AddEventHandler('esx:playerDropped', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local onCall = onCalls[xPlayer["source"]]

	PhoneNumbers[hasPhoneNumber(source)] = nil

	if PhoneNumbers[xPlayer["job"]["name"]] then
		PhoneNumbers[xPlayer["job"]["name"]]["sources"][tostring(source)] = nil
	end

	if onCall then
		EndCall(source, onCall["channel"], onCall["target"])

		onCallsChanged()
	end
end)

AddEventHandler('esx:setJob', function(source, job, lastJob)
	if PhoneNumbers[lastJob["name"]] then
		PhoneNumbers[lastJob["name"]]["sources"][tostring(source)] = nil
	end

	if PhoneNumbers[job["name"]] then
		PhoneNumbers[job["name"]]["sources"][tostring(source)] = true
	end
end)

RegisterServerEvent('esx_phone:removePlayerContact')
AddEventHandler('esx_phone:removePlayerContact', function(phoneNumber)
	MySQL.Async.execute('DELETE FROM user_contacts WHERE identifier=@identifier AND number=@number', {['@identifier'] = GetPlayerIdentifiers(source)[1], ['@number'] = phoneNumber})
end)

RegisterServerEvent('esx_phone:send')
AddEventHandler('esx_phone:send', function(phoneNumber, message, anon, position, isAutomaticAlarm)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.execute('INSERT INTO user_messages (identifier, reciever, date, sender, message) VALUES (@identifier, @reciever, @date, @sender, @msg)', { ['@msg'] = message, ['@reciever'] = checkNumber(phoneNumber), ['@date'] = os.date("%c"), ['@sender'] = getNumberFromId(xPlayer["identifier"]), ['@identifier'] = xPlayer["identifier"], ['@number'] = phoneNumber})
	Citizen.Trace('MESSAGE => ' .. GetPlayerName(src) .. ' @' .. phoneNumber .. ' : ' .. message)

	if PhoneNumbers[phoneNumber] then

		for k,v in pairs(PhoneNumbers[phoneNumber]["sources"]) do

			local numType = PhoneNumbers[phoneNumber]["type"]
			local numHasDispatch = PhoneNumbers[phoneNumber]["hasDispatch"]
			local numHide = PhoneNumbers[phoneNumber]["hideNumber"]
			local numHidePosIfAnon = PhoneNumbers[phoneNumber]["hidePosIfAnon"]
			local numPosition = PhoneNumbers[phoneNumber]["sharePos"] and position or false
			local numSource = tonumber(k)

			if numHidePosIfAnon and anon and not isAutomaticAlarm then
				numPosition = false
			end

			if numHasDispatch then
				TriggerClientEvent('esx_phone:onMessage', numSource, hasPhoneNumber(src), message, numPosition, (numHide and true or anon), numType, true)
			else

				TriggerClientEvent('esx_phone:onMessage', numSource, hasPhoneNumber(src), message, numPosition, (numHide and true or anon), numType, false)
			end
		end
	end
end)


RegisterServerEvent('esx_phone:tweet')
AddEventHandler('esx_phone:tweet', function(msg, date)
	local src = source
	local xPlayers = ESX.GetPlayers()

	Citizen.Trace('TWEET => ' .. date .. ' ' .. msg)

	MySQL.Async.execute('INSERT INTO phone_tweets (message, date) VALUES (@msg, @date)', { ['@msg'] = msg, ['@date'] = date })

	for i=1, #xPlayers do
		if xPlayers[i] ~= src then
			TriggerClientEvent('esx_phone:tweet', xPlayers[i], msg)
		end
	end
end)

AddEventHandler('esx_phone:registerNumber', function(number, type, sharePos, hasDispatch, hideNumber, hidePosIfAnon)
	local hideNumber = hideNumber or false
	local hidePosIfAnon = hidePosIfAnon or false

	if not PhoneNumbers[number] then
		PhoneNumbers[number] = {
			["type"] = type,
			["sharePos"] = sharePos,
			["hasDispatch"] = (hasDispatch or false),
			["hideNumber"] = hideNumber,
			["hidePosIfAnon"] = hidePosIfAnon,
			["sources"] = {}
		}
	end
end)

RegisterServerEvent('esx_phone:addPlayerContact')
AddEventHandler('esx_phone:addPlayerContact', function(contactNumber, contactName)
	local src = source
	local foundNumber = false

	MySQL.Async.fetchAll('SELECT phone_number FROM users WHERE phone_number = @number LIMIT 1',
	{
		['@number'] = tostring(contactNumber)
	},
	function(result)

		if result[1] or Config.NumberToJob[contactNumber] then
			foundNumber = true
		end

		if foundNumber then

			if contactNumber == hasPhoneNumber(src) then
				TriggerClientEvent('esx:showNotification', src, "Du kan inte lägga till dig själv")
			else

				local hasAlreadyAdded = false
				local contacts = getContacts(src)

				for i=1, #contacts, 1 do
					if contacts[i]["number"] == contactNumber then
						hasAlreadyAdded = true
					end
				end

				if hasAlreadyAdded then
					TriggerClientEvent('esx:showNotification', src, "numret finns redan i din kontaktlisa")
				else

					MySQL.Async.execute('INSERT INTO user_contacts (identifier, name, number) VALUES (@identifier, @name, @number)',
					{
						['@identifier'] = GetPlayerIdentifiers(src)[1],
						['@name'] = contactName,
						['@number'] = contactNumber
					},
					function(rowsChanged)

						TriggerClientEvent('esx:showNotification', src, "Kontakt tillagd")
						TriggerClientEvent('esx_phone:refreshContacts', src, getContacts(src))
					end)
				end
			end
		else
			TriggerClientEvent('esx:showNotification', src, "Detta nummer är ogiltigt")
		end
	end)
end)

RegisterServerEvent('esx_phone:stopDispatch')
AddEventHandler('esx_phone:stopDispatch', function(dispatchRequestId)
  	TriggerClientEvent('esx_phone:stopDispatch', -1, dispatchRequestId)
end)

RegisterServerEvent("esx_phone:alertEmployees")
AddEventHandler("esx_phone:alertEmployees", function(job, message)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer["job"]["name"] == job then
			TriggerClientEvent("esx:showNotification", xPlayers[i], message)
		end
	end
end)

RegisterServerEvent('esx_phone:swish')
AddEventHandler('esx_phone:swish', function(amount, phoneNumber)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local identifier = nil

	if amount > 0 then
		if amount <= xPlayer.getAccount('bank')["money"] then
			if amount <= 10000 then
				if Config.NumberToLabel[phoneNumber] then
					TriggerClientEvent('esx:showNotification', src, "Du skickade in ett bidrag på " .. amount .. "kr till " .. Config.NumberToLabel[phoneNumber])

					TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. Config.NumberToJob[phoneNumber], function(account)
						account.addMoney(amount)
						xPlayer.removeAccountMoney('bank', amount)
					end)

					return
				elseif not doesCharacterExist(phoneNumber) then
					TriggerClientEvent('esx:showNotification', src, "Telefonnumret tillhör inte någon.")
					return
				else
					identifier = doesCharacterExist(phoneNumber)
				end

				if not ESX.GetPlayerFromIdentifier(identifier) then
					TriggerClientEvent('esx:showNotification', src, "Du har fört över " .. amount .. "kr till " .. phoneNumber)

					local rows = MySQL.Sync.fetchAll("SELECT bank FROM users WHERE identifier = @identifier LIMIT 1", {['@identifier'] = identifier})
					MySQL.Async.execute('UPDATE users SET bank = @bank WHERE identifier = @identifier', { ['@identifier'] = identifier, ['@bank'] = rows[1]["bank"] + amount })

					return
				end

				local targetPlayer = ESX.GetPlayerFromIdentifier(identifier)
				xPlayer.removeAccountMoney('bank', amount)
				targetPlayer.addAccountMoney('bank', amount)

				TriggerClientEvent('esx:showNotification', src, "Du har fört över " .. amount .. "kr till " .. phoneNumber)
				TriggerClientEvent('esx:showNotification', targetPlayer["source"], "Du mottog en swish på " .. amount .. "kr")
			else
				TriggerClientEvent('esx:showNotification', src, "Swish är spärrat på 10.000 per överföring")
			end
		else
			TriggerClientEvent('esx:showNotification', src, "Du har inte råd med detta")
		end
	else
		TriggerClientEvent('esx:showNotification', src, "Ogiltigt belopp")
	end
end)

RegisterServerEvent('esx_phone:firstLoad')
AddEventHandler('esx_phone:firstLoad', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local rows = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier LIMIT 1", {['@identifier'] = xPlayer["identifier"]})

	if not hasPhoneNumber(src) then

		local phoneNumber = GenerateUniquePhoneNumber()

		MySQL.Async.execute('UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier',
			{
				['@identifier'] = xPlayer["identifier"],
				['@phone_number'] = phoneNumber
			}
		)

		PhoneNumbers[phoneNumber] = {
			["type"] = 'player',
			["hashDispatch"] = false,
			["sharePos"] = false,
			["hideNumber"] = false,
			["hidePosIfAnon"] = false,
			["sources"] = {[src] = true}
		}

		TriggerClientEvent("esx_phone:loadData", src, phoneNumber, getContacts(src), rows[1]["firstname"] .. " " .. rows[1]["lastname"], getTweets())
	else
		PhoneNumbers[hasPhoneNumber(src)] = {
			["type"] = 'player',
			["hashDispatch"] = false,
			["sharePos"] = false,
			["hideNumber"] = false,
			["hidePosIfAnon"] = false,
			["sources"] = {[src] = true}
		}

		TriggerClientEvent("esx_phone:loadData", src, hasPhoneNumber(src), getContacts(src), rows[1]["firstname"] .. " " .. rows[1]["lastname"], getTweets())
	end

	if PhoneNumbers[xPlayer["job"]["name"]] then
		PhoneNumbers[xPlayer["job"]["name"]]["sources"][tostring(src)] = true
	end
end)

ESX.RegisterServerCallback('esx_phone:getIdentity', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT firstname FROM users WHERE identifier = @identifier LIMIT 1", {['@identifier'] = identifier})

	cb(result[1]['firstname'])
end)


function doesCharacterExist(phonenumber)
	local rows = MySQL.Sync.fetchAll("SELECT identifier FROM users WHERE phone_number = @phone_number LIMIT 1", {['@phone_number'] = phonenumber})

	if not rows[1] then
		return false
	end

	return rows[1]["identifier"]
end

function hasPhoneNumber(source)
	local _source       = source
	local xPlayer       = ESX.GetPlayerFromId(_source)
	local rows = MySQL.Sync.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifier LIMIT 1", {['@identifier'] = xPlayer["identifier"]})

	if not rows[1]["phone_number"] then
		return false
	end

	return 0 .. tonumber(rows[1]["phone_number"])
end

function getContacts(source)
	local rows = MySQL.Sync.fetchAll("SELECT * FROM user_contacts WHERE identifier = @identifier", {['@identifier'] = GetPlayerIdentifiers(source)[1]})
	local contacts = {
		{
			["number"] = "11414",
			["name"] = "Polisen"
		},
		{
			["number"] = "1177",
			["name"] = "Sjukvården"
		},
		{
			["number"] = "46400",
			["name"] = "Mekonomen"
		},
		{
			["number"] = "32020",
			["name"] = "Advokat"
		},
		{
			["number"] = "48900",
			["name"] = "Bennys"
		},
		{
			["number"] = "83200",
			["name"] = "Bilfirman"
		},
		{

			["number"] = "25091",
			["name"] = "Securitas"
		},
		{

			["number"] = "33200",
			["name"] = "Folksam"
		},
		{

			["number"] = "22200",
			["name"] = "Taxi"
		},
		{

			["number"] = "53200",
			["name"] = "Nattklubb"
		},



	}

	for i=1, #rows do
		table.insert(contacts, {
			["number"] = rows[i]["number"],
			["name"] = rows[i]["name"],
		})
	end

	return contacts
end

function getTweets()
	local tweets = MySQL.Sync.fetchAll("SELECT * FROM phone_tweets", {})
	local tweetTable = {}

	for i=1, #tweets do
		table.insert(tweetTable, {
			["date"] = tweets[i]["date"],
			["message"] = tweets[i]["message"]
		})
	end

	return tweetTable
end

RegisterServerEvent('esx_phone:bankTransfer')
AddEventHandler('esx_phone:bankTransfer', function(target, amount)
	local _source       = source
	local xPlayer       = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if amount > 0 and amount <= xPlayer.getAccount('bank').money then
		xPlayer      .removeAccountMoney('bank', amount)
		targetXPlayer.addAccountMoney   ('bank', amount)

		TriggerClientEvent('esx:showNotification', _source, 'Vous avez viré ~g~$' .. amount .. '~s~ à ' .. targetXPlayer.name)
	else
		TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
	end
end)

--Falafelkungen Snippets
ESX.RegisterServerCallback('esx_phone:retrieveCallHistory', function(source, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local result = {}
	local caller = 0
	local number = 0
	print("retrieveCallHistory")
	MySQL.Async.fetchAll('SELECT * FROM user_calls WHERE caller = @number or number = @number',
	{
		['@number'] = getNumberFromId(xPlayer["identifier"])
	},
	function(result)
		if result[1] ~= nil then
		number = result[1]["number"]
		caller = result[1]["caller"]
		for i, v in ipairs(result) do
		print("Reciever" .. result[i]["number"])
		print("Caller" .. result[i]["caller"])
		print("answered" .. result[i]["answered"])
		if result[i]["number"] == getNumberFromId(xPlayer["identifier"]) and result[i]["answered"] == "0" then
			result[i]["missedCall"] = true
			result[i]["caller"] = caller
			result[i]["number"] = number
				print("number 0")
		elseif result[i]["number"] == getNumberFromId(xPlayer["identifier"]) and result[i]["answered"] == "1" then
			result[i]["missedCall"] = false
			result[i]["caller"] = number
			result[i]["number"] = caller
			print("number 1")
		elseif result[i]["caller"] == getNumberFromId(xPlayer["identifier"]) and result[i]["answered"] == "1" then
			result[i]["missedCall"] = false
			result[i]["caller"] = caller
			result[i]["number"] = number
			print("caller 1")
		elseif result[i]["caller"] == getNumberFromId(xPlayer["identifier"]) and result[i]["answered"] == "0" then
			result[i]["missedCall"] = false
			result[i]["caller"] = caller
			result[i]["number"] = number
				print("caller 0")
		else
			print("lmao")
		end
	end
	cb(result)
	end
	end)


end)

function removePreviousCall(caller, number)
	MySQL.Async.execute('DELETE FROM user_calls WHERE caller=@caller AND number=@number', {['@caller'] = caller, ['@number'] = number})
	MySQL.Async.execute('DELETE FROM user_calls WHERE caller=@caller AND number=@number', {['@caller'] = number, ['@number'] = caller})
end


ESX.RegisterServerCallback('esx_phone:retrieveSavedMassages', function(source, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local result = {}
	MySQL.Async.fetchAll('SELECT * FROM user_messages WHERE reciever = @number or sender = @number',
	{
		['@number'] = getNumberFromId(xPlayer["identifier"])
	},
	function(result)
		for i, v in ipairs(result) do
		if(result[i]["reciever"] == getNumberFromId(xPlayer["identifier"])) then
			result[i]["recieved"] = false
			result[i]["number"] = result[i]["sender"]
	else
		result[i]["recieved"] = true
		result[i]["number"] = result[i]["reciever"]
	end
end
	cb(result)
	end)


end)

function checkNumber(number)
	pattern = "^0"
		if(string.sub(tostring(number),1,string.len("0")) == "0") then
			return number;
	else
			return "0" .. number
	end
end

ESX.RegisterServerCallback('esx_phone:isAlt', function(source, cb)
	local _source       = source
	local xPlayer       = ESX.GetPlayerFromId(_source)
	local identifier = formatIdentifier(xPlayer["identifier"])
	local resultFound = 0
	local prefixes = {"Char1", "Char2", "Char3", "license:", "Char4"}

	for i, v in ipairs(prefixes) do
	local id = v .. identifier
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier LIMIT 1", {['@identifier'] = id})

	if result[1] ~= nil then
		resultFound = resultFound + 1
	end
end

	if resultFound >= 2 then
		cb(true)
	else
		cb(false)
	end

end)

function formatIdentifier(id)
	patterns = {"license:", "Char1", "Char2", "Char3"}
	local identifier = id

		for i, v in ipairs(patterns) do
			identifier = string.gsub(identifier, v, "")
		end

return identifier


end

function getIdFromNumber(number)

	local result = MySQL.Sync.fetchAll("SELECT identifier FROM users WHERE phone_number = @identifier LIMIT 1", {['@identifier'] = number})
	return(result[1]["identifier"])

end

function getNumberFromId(id)
	local result = MySQL.Sync.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifier LIMIT 1", {['@identifier'] = id})
	return(result[1]["phone_number"])
end

RegisterServerEvent('esx_phone:callBusy')
AddEventHandler('esx_phone:callBusy', function(source, target)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
local gPlayer = ESX.GetPlayerFromId(target)
removePreviousCall(getNumberFromId(gPlayer["identifier"]), getNumberFromId(xPlayer["identifier"]))
MySQL.Async.execute('INSERT INTO user_calls (identifier, date, caller, number, prefix, answered) VALUES (@identifier, @date, @caller, @number, @prefix, @answered)', {['@number'] = getNumberFromId(xPlayer["identifier"]), ['@date'] = os.date("%c"), ['@caller'] = getNumberFromId(gPlayer["identifier"]), ['@identifier'] = xPlayer["identifier"], ['@prefix'] = "Upptagen", ['@answered'] = 0})
end)
