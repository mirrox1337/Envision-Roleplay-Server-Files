ESX = nil
local RegisteredSocieties = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getBlackMoneyFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('black_money')
	return account.money

end

local function getBankFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('bank')
	return account.money

end
	
TriggerEvent('es:addCommand', 'showjob', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label

--TriggerClientEvent('esx:showNotification', _source, 'You are working as: ~g~' .. job .. ' ~s~-~g~ ' .. jobgrade)
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You are working as: ' .. job .. ' - ' .. jobgrade})  
end, {help = "Check what job you have"})

TriggerEvent('es:addCommand', 'showcash', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local wallet 		= getMoneyFromUser(_source)

--TriggerClientEvent('esx:showNotification', _source, 'You currently have ~g~$~g~' .. wallet .. ' ~s~in your wallet~g~ ')
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har SEK' .. wallet .. ' i din plånbok'})
end, {help = "Kolla plånboken"})

TriggerEvent('es:addCommand', 'showbank', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local bank 			= getBankFromUser(_source)

--TriggerClientEvent('esx:showNotification', _source, 'You currently have ~g~$~g~' .. bank .. ' ~s~in your bank~g~ ')
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har SEK' .. bank .. ' på banken'})
end, {help = "Check how much is in your bank"})

TriggerEvent('es:addCommand', 'showdirty', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local black_money 	= getBlackMoneyFromUser(_source)

--TriggerClientEvent('esx:showNotification', _source, 'You currently have ~g~$~g~' .. black_money .. ' ~s~dirty money in your wallet~g~ ')
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har SEK' .. black_money .. ' svarta pengar i fickan'})
end, {help = "Check how much dirty money you have"})

TriggerEvent('es:addCommand', 'showinfo', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label
    local wallet 		= getMoneyFromUser(_source)
    local bank 			= getBankFromUser(_source)
    local black_money 	= getBlackMoneyFromUser(_source)
    if xPlayer.job.grade_name == 'boss' then
		local society = GetSociety(xPlayer.job.name)

		if society ~= nil then
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				money = account.money
			end)
		else
			money = 0
		end

                TriggerClientEvent('esx:showNotification', _source, 'You are working as: ~g~' .. job .. ' ~s~-~g~ ' .. jobgrade)	         
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You are working as: ' .. job .. ' - ' .. jobgrade})
                Citizen.Wait(1500)
                TriggerClientEvent('esx:showNotification', _source, 'Du har ~g~SEK~g~' .. wallet .. ' ~s~i din plånbok~g~ ')
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You currently have $' .. wallet .. ' in your wallet'})
                Citizen.Wait(1500)
                TriggerClientEvent('esx:showNotification', _source, 'Du har ~g~SEK~g~' .. bank .. ' ~s~på banken~g~ ')
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You currently have $' .. bank .. ' in your bank'})
                Citizen.Wait(1500)
                TriggerClientEvent('esx:showNotification', _source, 'Du har ~g~SEK~g~' .. black_money .. ' ~s~Svarta pengar~g~ ')
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You currently have $' .. black_money .. ' dirty money in your wallet'})
                Citizen.Wait(1500)
                TriggerClientEvent('esx:showNotification', _source, 'Du har ~g~SEK~g~' .. money .. ' ~s~i ditt företag~g~ ')
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You currently have $' .. money .. ' in the society account'})
																	
	else

                TriggerClientEvent('esx:showNotification', _source, 'You are working as: ~g~' .. job .. ' ~s~-~g~ ' .. jobgrade)	         
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You are working as: ' .. job .. ' - ' .. jobgrade})
                Citizen.Wait(1500)
                TriggerClientEvent('esx:showNotification', _source, 'Du har ~g~SEK~g~' .. wallet .. ' ~s~i din plånbok~g~ ')
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You currently have $' .. wallet .. ' in your wallet'})
                Citizen.Wait(1500)
                TriggerClientEvent('esx:showNotification', _source, 'Du har ~g~SEK~g~' .. bank .. ' ~s~på banken~g~ ')
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You currently have $' .. bank .. ' in your bank'})
                Citizen.Wait(1500)
                TriggerClientEvent('esx:showNotification', _source, 'Du har ~g~SEK~g~' .. black_money .. ' ~s~svarta pengar~g~ ')
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You currently have $' .. black_money .. ' dirty money in your wallet'})
                Citizen.Wait(1500)
	        TriggerClientEvent('esx:showNotification', _source, '~r~Du har inte tillgång!')
                --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Access not granted!'})
																	
	end
end, {help = "Företagspengar"})

TriggerEvent('es:addCommand', 'showsociety', function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.job.grade_name == 'boss' then
		local society = GetSociety(xPlayer.job.name)

		if society ~= nil then
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				money = account.money
			end)
		else
			money = 0
		end
		
                --TriggerClientEvent('esx:showNotification', _source, 'You currently have ~g~$~g~' .. money .. ' ~s~in the society account~g~ ')
	        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har SEK' .. money .. ' i ditt företag'})
																	
	else

	        --TriggerClientEvent('esx:showNotification', _source, '~r~Access not granted!')
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har inte tillgång!'})
																			
	end
end, {help = "Check your society's balance"})

TriggerEvent('esx_society:getSocieties', function(societies) 
	RegisteredSocieties = societies
end)

function GetSociety(name)
  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      return RegisteredSocieties[i]
    end
  end
end
