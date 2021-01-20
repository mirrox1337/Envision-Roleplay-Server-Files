ESX = nil
local PlayerData              = {}
local shop = {x = 307.63,   y = -593.36, z = 42.20}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

hintToDisplay = function(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
        local sleepthread = 500
        Citizen.Wait(10)
        local coords = GetEntityCoords(PlayerPedId(), true)
        if GetDistanceBetweenCoords(coords, shop.x, shop.y, shop.z, true) <= 10.0 then
            DrawMarker(25, shop.x, shop.y, shop.z + 0.1, 0, 0, 0, 0, 0, 0.0, 1.0, 1.0, 0.01, 255, 255, 255, 0.5, 0, 0, 0,0)
            if GetDistanceBetweenCoords(coords, shop.x, shop.y, shop.z, true) <= 1.5 then
                sleepthread = 10
                hintToDisplay('Tryck på ~INPUT_CONTEXT~ för att handla')
                if IsControlJustPressed(0, 38) then
                    OpenShopMenu()
                end			
            end		
        end
    end
end)

OpenShopMenu = function()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_shop_menu',
        {
            title    = 'Sjukhusets affär',
            elements = {
				{label = 'Bandage,(blödning+HP) (400kr)', item = 'bandage', price = 400, value = 'bandage'},
                {label = 'Citodon,(brutna ben) (1000kr)', item = 'vicodin', price = 1000, value = 'vicodin'},
                --{label = 'Medkit (2000kr)', item = 'medikit', price = 2000, value = 'medikit'},
            }
        },
        function(data, menu)
			TriggerServerEvent('strandsatt_medicalshop:buyItem', data.current.item, data.current.price)
        end,
        function(data, menu)
            menu.close()
        end
    )
end