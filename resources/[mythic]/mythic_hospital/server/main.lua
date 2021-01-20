ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local beds = {
    { x = 356.73, y = -585.71, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
    { x = 360.51, y = -586.66, z = 43.11, h = -20.0, taken = false, model = -1091386327 },
    { x = 353.12, y = -584.66, z = 43.50, h = -20.0, taken = false, model = 1631638868 },
	{ x = 349.62, y = -583.53, z = 43.022, h = -20.0, taken = false, model = -1091386327 },
	{ x = 344.80, y = -581.12, z = 43.02, h = 80.0, taken = false, model = -1091386327 },
	{ x = 334.09, y = -578.43, z = 43.01, h = 80.0, taken = false, model = -1091386327 },
	{ x = 323.64, y = -575.16, z = 43.02, h = -20.0, taken = false, model = -1091386327 },
	{ x = 326.97, y = -576.229, z = 43.02, h = -20.0, taken = false, model = -1091386327 },
	{ x = 354.24, y = -592.74, z = 43.11, h = 160.0, taken = false, model = 2117668672 },
	{ x = 357.34, y = -594.45, z = 43.11, h = 160.0, taken = false, model = 2117668672 },
	{ x = 350.80, y = -591.72, z = 43.11, h = 160.0, taken = false, model = 2117668672 },
	{ x = 346.89, y = -591.01, z = 42.58, h = 160.0, taken = false, model = 2117668672 },
    --{ x = 346.76, y = -576.22, z = 28.72, h = 70.0, taken = false, model = -1091386327 }, pillbox_extenden
    --{ x = 348.8, y = -571.14, z = 28.72, h = 70.0, taken = false, model = -1091386327 }, pillbox_extenden
    --{ x = 351.91, y = -568.79, z = 28.72, h = 160.0, taken = false, model = 2117668672 }, pillbox_extenden
    --{ x = 355.29, y = -569.9, z = 28.72, h = 160.0, taken = false, model = 2117668672 }, pillbox_extenden
    --{ x = 361.12, y = -564.53, z = 28.3, h = -20.0, taken = false, model = 1631638868 }, pillbox_extenden
    --{ x = 357.6, y = -563.19, z = 28.72, h = -20.0, taken = false, model = 1631638868 }, pillbox_extenden
    --{ x = 354.31, y = -561.85, z = 28.72, h = -20.0, taken = false, model = 1631638868 }, pillbox_extenden
    --{ x = 327.43, y = -562.94, z = 28.76, h = 245.0, taken = false, model = 2117668672 }, pillbox_extenden
    --{ x = 336.6, y = -574.77, z = 28.78, h = -20.0, taken = false, model = -1182962909 }, pillbox_extenden
    --{ x = 330.19, y = -572.57, z = 28.78, h = -20.0, taken = false, model = -1182962909 }, pillbox_extenden
    --{ x = 323.5, y = -576.75, z = 28.78, h = 60.0, taken = false, model = -1182962909 }, pillbox_extenden
    --{ x = 322.25, y = -580.32, z = 28.78, h = 60.0, taken = false, model = -1182962909 }, -- -1182962909 pillbox_extenden
}

local bedsTaken = {}
local injuryBasePrice = 100

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Ingen sjukhussäng tillgänglig' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Den sängen är upptagen' })
            end
        end
    end

    if not foundbed then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Ingen sjukhussäng i närheten' })
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end
    local xPlayer = ESX.GetPlayerFromId(src)
    local societyAccount

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
        societyAccount = account
    end)
    --if(xPlayer.getMoney() >= 500) then
        xPlayer.removeMoney(1000)
        societyAccount.addMoney(1000)
    --end
    -- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
    TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
 AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

	-- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
	TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)