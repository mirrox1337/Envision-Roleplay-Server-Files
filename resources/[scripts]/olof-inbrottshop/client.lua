local Keys = {
 ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
 ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
 ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
 ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
 ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
 ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
 ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
 ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
 ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
   
ESX = nil
local PlayerData              = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--local blips = {
  --    {title="Försäljning", colour=45, id=459, x = 1391.95, y = 3604.53, z = 34.98}
--}
  
local gym = {
    {x = 1493.72, y = -2121.36, z = 75.95}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(gym) do
            DrawMarker(20, gym[k].x, gym[k].y, gym[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 255, 255, 0, 0, 0, 0)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(gym) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)

            if dist <= 0.5 then
				hintToDisplay('Tryck på ~INPUT_CONTEXT~ för att öppna ~b~affären~w~')
				
				if IsControlJustPressed(0, Keys['E']) then
					OpenPawnMenu()
				end			
            end
        end
    end
end)

function OpenPawnMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_menu',
        {
            title    = 'Försäljning',
            align = 'right',
            elements = {
				--{label = 'Affär', value = 'shop'},
				{label = 'Sälj', value = 'sell'},
            }
        },
        function(data, menu)
            if data.current.value == 'shop' then
				OpenPawnShopMenu()
            elseif data.current.value == 'sell' then
				OpenSellMenu()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenPawnShopMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_shop_menu',
        {
            title    = 'Handla',
            align = 'center',
            elements = {
				{label = 'Skottsäker väst 35000kr', value = 'bulletproof'},
                {label = 'Switchblade 5500kr', value = 'WEAPON_SWITCHBLADE'},
            }
        },
        function(data, menu)
            if data.current.value == 'fixkit' then
				TriggerServerEvent('esx_kocken:buyFixkit')
            elseif data.current.value == 'bulletproof' then
				TriggerServerEvent('esx_kocken:buyBulletproof')
            elseif data.current.value == 'drill' then
				TriggerServerEvent('esx_kocken:buyDrill')
            elseif data.current.value == 'blindfold' then
				TriggerServerEvent('esx_kocken:buyBlindfold')
            elseif data.current.value == 'fishingrod' then
                TriggerServerEvent('esx_kocken:buyFishingrod')
            elseif data.current.value == 'antibiotika' then
                TriggerServerEvent('esx_kocken:buyAntibiotika')  
            elseif data.current.value == 'WEAPON_SWITCHBLADE' then
				TriggerServerEvent('esx_kocken:buyWEAPON_SWITCHBLADE')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenSellMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_sell_menu',
        {
            title    = 'Vad vill du sälja?',
            align = 'right',
            elements = {
                {label = 'Silverring', value = 'ring'},
                {label = 'Rolex', value = 'rolex'},
                {label = 'Använd dildo', value = 'dildo'},
                {label = 'MP3 spelare', value = 'mp3'},
                {label = 'Nikon kamera', value = 'systemkamera'},
                {label = 'Kondom', value = 'kondom'},
                {label = 'Samsung laddare', value = 'laddare'},
                {label = 'Silversmycke', value = 'smycke'},
                {label = 'iPod touch', value = 'ipod'},
            }
        },
        function(data, menu)
            if data.current.value == 'ring' then
				TriggerServerEvent('esx_kocken:sellring')
            elseif data.current.value == 'smycke' then
				TriggerServerEvent('esx_kocken:sellsmycke')
            elseif data.current.value == 'dildo' then
				TriggerServerEvent('esx_kocken:selldildo')
            elseif data.current.value == 'rolex' then
				TriggerServerEvent('esx_kocken:sellklocka')
            elseif data.current.value == 'mp3' then
                TriggerServerEvent('esx_kocken:selltelefon')
            elseif data.current.value == 'systemkamera' then
                TriggerServerEvent('esx_kocken:sellshirt')
            elseif data.current.value == 'kondom' then
                TriggerServerEvent('esx_kocken:sellpants')
            elseif data.current.value == 'laddare' then
                TriggerServerEvent('esx_kocken:sellshoes')
            elseif data.current.value == 'ipod' then
                TriggerServerEvent('esx_kocken:sellblindfold')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end





