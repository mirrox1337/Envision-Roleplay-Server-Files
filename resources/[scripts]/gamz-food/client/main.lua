ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
        end)
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId(), true)
        for k in pairs(Config.Zones) do
            if GetDistanceBetweenCoords(Config.Zones[k].x, Config.Zones[k].y, Config.Zones[k].z, coords) < 0.3 then
                Marker("~w~[~r~E~w~] Köp Mat", 25, Config.Zones[k].x, Config.Zones[k].y, Config.Zones[k].z - 1.10)
                if IsControlJustReleased(0, Keys['E']) then
                    FoodMeny()
                end
            elseif GetDistanceBetweenCoords(Config.Zones[k].x, Config.Zones[k].y, Config.Zones[k].z, coords) < 5  then
                Marker("~w~Köp Mat", 25, Config.Zones[k].x, Config.Zones[k].y, Config.Zones[k].z - 1.10)
            end
        end
    end
end)

function FoodMeny()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'foodstand',
        {
            title    = 'Mat kiosk',
            align    = 'center',
            elements = {
                {label = 'Varmkorv <span style="color:green"> ' .. Config.EatPrice ..' SEK</span> ',                  prop = 'prop_cs_hotdog_01',    type = 'food'},
                {label = 'Hamburgare <span style="color:green"> ' .. Config.EatPrice ..' SEK</span>',                   prop = 'prop_cs_burger_01',    type = 'food'},
                {label = 'Smörgås <span style="color:green"> ' .. Config.EatPrice ..' SEK</span>',                 prop = 'prop_sandwich_01',     type = 'food'},
                {label = 'Vatten 50cl <span style="color:green"> ' .. Config.DrinkPrice ..' SEK</span>',   prop = 'prop_ld_flow_bottle',  type = 'drink'},
                {label = 'Coca Cola 33cl <span style="color:green"> ' .. Config.DrinkPrice ..' SEK</span>',          prop = 'prop_ecola_can',       type = 'drink'},
                {label = 'Kaffe <span style="color:green"> ' .. Config.DrinkPrice ..' SEK</span>',          prop = 'p_ing_coffeecup_01',       type = 'drink'},


            }
        }, function(data, menu)
            local selected = data.current.type
            if selected == 'food' then
                ESX.TriggerServerCallback("gamz-food:checkMoney", function(money)
                    if money >= Config.EatPrice then
                        ESX.UI.Menu.CloseAll()
                        TriggerServerEvent("gamz-food:removeMoney", Config.EatPrice)
                        eat(data.current.prop)
                    else
                        ESX.ShowNotification("Du har inte tillräckligt med pengar.")
                    end
                end)
            elseif selected == 'drink' then
                ESX.TriggerServerCallback("gamz-food:checkMoney", function(money)
                    if money >= Config.DrinkPrice then
                        ESX.UI.Menu.CloseAll()
                        TriggerServerEvent("gamz-food:removeMoney", Config.DrinkPrice)
                        drink(data.current.prop) 
                    else
                        ESX.ShowNotification("Du har inte tillräckligt med pengar.")
                    end
                end)
            end
        end, function(data, menu)
            menu.close() 
    end)
end

function eat(prop)
    local playerPed = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    prop = CreateObject(GetHashKey(prop), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
    RequestAnimDict('mp_player_inteat@burger')
    while not HasAnimDictLoaded('mp_player_inteat@burger') do
        Wait(0)
    end
    TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
    for i=1, 50 do
        Wait(300)
        TriggerEvent('esx_status:add', 'hunger', 10000)
    end
    IsAnimated = false
    ClearPedSecondaryTask(playerPed)
    DeleteObject(prop)
end

function drink(prop)
    local playerPed = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    prop = CreateObject(GetHashKey(prop), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.15, 0.025, 0.010, 270.0, 175.0, 0.0, true, true, false, true, 1, true)
    RequestAnimDict('mp_player_intdrink')
    while not HasAnimDictLoaded('mp_player_intdrink') do
        Wait(0)
    end
    TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
    for i=1, 50 do
        Wait(300)
        TriggerEvent('esx_status:add', 'thirst', 10000)
    end
    IsAnimated = false
    ClearPedSecondaryTask(playerPed)
    DeleteObject(prop)
end
