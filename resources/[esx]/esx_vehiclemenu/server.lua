ESX               = nil
local cars      = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_vehiclelock:requestPlayerCars', function(source, cb, plate)

  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll(
    'SELECT * FROM owned_vehicles WHERE owner = @identifier', 
    {
      ['@identifier'] = xPlayer.identifier,
    },
    function(result)

      local found = false

      for i=1, #result, 1 do

        local vehicleProps = json.decode(result[i].vehicle)

        if vehicleProps.plate == plate then
          found = true
          break
        end

      end

      if found then
        cb(true)
      else
        cb(false)
      end

    end
  )
end)

-- E N G I N E --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/engine off" then
    CancelEvent()
    --------------
    TriggerClientEvent('engineoff', s)
  elseif message == "/engine on" then
    CancelEvent()
    --------------
    TriggerClientEvent('engineon', s)
  elseif message == "/engine" then
    CancelEvent()
    --------------
    TriggerClientEvent('engine', s)
  end
end)
-- T R U N K --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/trunk" then
    CancelEvent()
    --------------
    TriggerClientEvent('trunk', s)
  end
end)
-- R E A R  D O O R S --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/rdoors" then
    CancelEvent()
    --------------
    TriggerClientEvent('rdoors', s)
  end
end)
-- H O O D --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/hood" then
    CancelEvent()
    --------------
    TriggerClientEvent('hood', s)
  end
end)

-- S A V E --
AddEventHandler('chatMessage', function(s, n, m)
	local message = string.lower(m)
	if message == "/gps" then
		CancelEvent()
		--------------
		TriggerClientEvent('save', s)
	end
end)
-- R E M O T E --
AddEventHandler('chatMessage', function(s, n, m)
	local message = string.lower(m)
	if message == "/sveh" then
		CancelEvent()
		--------------
		TriggerClientEvent('controlsave', s)
	end
end)