ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_joblisting:getJobsList', function(source, cb)
	MySQL.Async.fetchAll(
		'SELECT * FROM jobs WHERE whitelisted = false',
		{},
		function(result)
			local data = {}
			for i=1, #result, 1 do
				table.insert(data, {
					value   = result[i].name,
					label   = result[i].label
				})
			end
			cb(data)
		end
	)
end)

RegisterServerEvent('esx_joblisting:setJob')
AddEventHandler('esx_joblisting:setJob', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob(job, 0)
end)

--
RegisterServerEvent('esx_joblisting:postApplication')
AddEventHandler('esx_joblisting:postApplication', function(dataTemp)
	
	local data = dataTemp
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.fetchAll(
	'SELECT * FROM users WHERE identifier = @identifier', 
	{
      ['@identifier'] = xPlayer.identifier
    }, 
	function(rows)
				
		for i = 1, #rows, 1 do
			_name = rows[i].firstname .. ' ' .. rows[i].lastname
		end

		if data.type == "police" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.police)
		elseif data.type == "ambulance" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.ambulance)
		elseif data.type == "raddningstjansten" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.raddningstjansten)
		elseif data.type == "journalist" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.journalist)
		elseif data.type == "cardealer" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.cardealer)
		elseif data.type == "mechanic" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.mechanic)
		elseif data.type == "forsakring" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.forsakring)
		elseif data.type == "bennys" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.bennys)
		elseif data.type == "securitas" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.securitas)
		elseif data.type == "lawyer" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.lawyer)
		elseif data.type == "nightclub" then
			postApp(_name, data.phone, data.licenses, data.exp, Config.Webhook.nightclub)
		end
	end)

end)

function postApp(name, phone, licenses, exp, webhook)
	local embeds = {
	{
		["type"] = "rich",
		["title"] = "Ny ansökan:" ,
		["fields"] =  {
						{
						["name"]= "Namn:",
						["value"]= _name,
						},
						{
							["name"]= "Telefonnummer:",
							["value"]= phone,
						},
						{
							["name"]= "Körkort behörighet:",
							["value"]= licenses,
						},
						{
							["name"]= "Tidigare erfarenhet:",
							["value"]= exp,
						},
				},
		["color"] = 6807172,
		["footer"] =  {
					["text"]= os.date("%A %x"),
					},
	}}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ embeds = embeds}), { ['Content-Type'] = 'application/json' })
end		