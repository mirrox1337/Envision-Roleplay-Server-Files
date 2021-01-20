local color = {r = 255, g = 0, b = 0, alpha = 255} -- Color of the text  44, 147, 150, 44, 147, 150
local font = 6 -- Font of the text
local time = 500 -- Duration of the display of the text : 500 ~= 13sec
local background = {
    enable = true,
    color = { r = 0, g = 0, b = 0, alpha = 168 },
}
local chatMessage = true
local dropShadow = true

local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    while not ESX.IsPlayerLoaded() do
		Citizen.Wait(0)
	end
	TriggerServerEvent('olsson_3d:firstLoad')
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterCommand('me', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterNetEvent('olsson:adminme')
AddEventHandler('olsson:adminme', function(id, meddelande)
    local source = id
    
    TriggerServerEvent('3dme:shareDisplay', meddelande)
end)

-------------------------------------------------------------------------------------------------------------

RegisterCommand('polisen', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    if PlayerData.job and PlayerData.job.name == 'police' then
    TriggerServerEvent('olsson:polisen', text)
    else
        ESX.ShowNotification('Du är inte anställd hos Polisen...')
    end
end)

RegisterNetEvent('polisenmeddelande')
AddEventHandler('polisenmeddelande', function(message)
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(0, 184, 240, 0.8); border-radius: 3px;"><i class="fas fa-user-circle"></i><span style="font-weight: 700">@Polisen</span><br> {0}</div>',
        args = { message }
    })
end)

-------------------------------------------------------------------------------------------------------------

RegisterCommand('sjukhuset', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    if PlayerData.job and PlayerData.job.name == 'ambulance' then
    TriggerServerEvent('olsson:sjukhus', text)
    else
        ESX.ShowNotification('Du är inte anställd hos Sjukhuset...')
    end
end)

RegisterNetEvent('sjukhusmeddelande')
AddEventHandler('sjukhusmeddelande', function(message)
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(0, 184, 240, 0.8); border-radius: 3px;"><i class="fas fa-user-circle"></i><span style="font-weight: 700">@Sjukhuset</span><br> {0}</div>',
        args = { message }
    })
end)


-------------------------------------------------------------------------------------------------------------

RegisterCommand('nattklubb', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    if PlayerData.job and PlayerData.job.name == 'nightclub' then
    TriggerServerEvent('olsson:nattklubb', text)
    else
        ESX.ShowNotification('Du är inte anställd hos nattklubben...')
    end
end)

RegisterNetEvent('nattklubbmeddelande')
AddEventHandler('nattklubbmeddelande', function(message)
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: purple; border-radius: 3px;"><i class="fas fa-user-circle"></i><span style="font-weight: 700">@Hades</span><br> {0}</div>',
        args = { message }
    })
end)

-------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------

RegisterCommand('securitas', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    if PlayerData.job and PlayerData.job.name == 'Securitas' then
    TriggerServerEvent('olsson:securitas', text)
    else
        ESX.ShowNotification('Du är inte anställd på securitas...')
    end
end)

RegisterNetEvent('securitasmeddelande')
AddEventHandler('securitasmeddelande', function(message)
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: blue; border-radius: 3px;"><i class="fas fa-user-circle"></i><span style="font-weight: 700">@Securitas</span><br> {0}</div>',
        args = { message }
    })
end)

-------------------------------------------------------------------------------------------------------------

RegisterCommand('bilcenter', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    if PlayerData.job and PlayerData.job.name == 'cardealer' then
    TriggerServerEvent('olsson:bilcenter', text)
    else
        ESX.ShowNotification('Du är inte anställd hos Bilcenter...')
    end
end)


RegisterNetEvent('bilcentermeddelande')
AddEventHandler('bilcentermeddelande', function(message)
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 50%; background-color: rgba(0, 184, 240, 0.8); border-radius: 3px;"><i class="fas fa-user-circle"></i>🚘 <span style="font-weight: 700">Bilcenter</span><br> {0}</div>',
        args = { message }
    })
end)

-------------------------------------------------------------------------------------------------------------

RegisterCommand('bennys', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    if PlayerData.job and PlayerData.job.name == 'bennys' then
    TriggerServerEvent('olsson:bennys', text)
    else
        ESX.ShowNotification('Du är inte anställd hos Bennys...')
    end
end)


RegisterNetEvent('bennysmeddelande')
AddEventHandler('bennysmeddelande', function(message)
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 50%; background-color: rgba(41, 41, 41, 0.8); border-radius: 3px;"><i class="fas fa-user-circle"></i><span style="font-weight: 700">Bennys</span><br> {0}</div>',
        args = { message }
    })
end)

-------------------------------------------------------------------------------------------------------------

RegisterCommand('mekonomen', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    if PlayerData.job and PlayerData.job.name == 'mekaniker' then
    TriggerServerEvent('olsson:mekonomen', text)
    else
        ESX.ShowNotification('Du är inte anställd hos Mekonomen...')
    end
end)


RegisterNetEvent('mekonomenmeddelande')
AddEventHandler('mekonomenmeddelande', function(message)
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 50%; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><i class="fas fa-user-circle"></i><span style="font-weight: 700; color: yellow; position: aboslute; top: -150px;">Mekonomen</span><br> <span style="color:yellow">{0}</span></div>',
        args = { message }
    })
end)

-------------------------------------------------------------------------------------------------------------

RegisterCommand('taxi', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    if PlayerData.job and PlayerData.job.name == 'taxi' then
    TriggerServerEvent('olsson:taxi', text)
    else
        ESX.ShowNotification('Du är inte anställd hos Taxi...')
    end
end)


RegisterNetEvent('taximeddelande')
AddEventHandler('taximeddelande', function(message)
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 50%; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><i class="fas fa-user-circle"></i><span style="font-weight: 700; color: yellow;">Taxi</span><br> <span style="color:yellow">{0}</span></div>',
        args = { message }
    })
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    Display(GetPlayerFromServerId(source), text)
end)

function Display(mePlayer, text)
    local timer = 0
    while timer < time do
        Wait(0)
        timer = timer + 1
        local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
        DrawText3D(coords['x'], coords['y'], coords['z']+1, text)
    end
end

RegisterNetEvent('olsson:metext')
AddEventHandler('olsson:metext', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        local playerPed = GetPlayerPed(-1)
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin['mask_1'] == 0 or skin['mask_1'] == 11 or skin['mask_1'] == 73 or skin['mask_1'] == 11 or skin['mask_1'] == 107 or skin['mask_1'] == 11 or skin['mask_1'] == 120 or skin['mask_1'] == 121 then
                TriggerEvent('chat:addMessage', {
                    template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(255, 11, 10, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i>❕ <span style="font-weight: 700">{0}</span><br> {1}</div>',
                    args = { name, message }
                })
            else
                TriggerEvent('chat:addMessage', {
                    template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(255, 11, 10, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i>❕ <span style="font-weight: 700">Maskerad man</span><br> {1}</div>',
                    args = { name, message }
                })
            end
        end)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 15.4 then
        local playerPed = GetPlayerPed(-1)
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin['mask_1'] == 0 or skin['mask_1'] == 11 or skin['mask_1'] == 73 or skin['mask_1'] == 11 or skin['mask_1'] == 107 or skin['mask_1'] == 11 or skin['mask_1'] == 120 or skin['mask_1'] == 121 then
                TriggerEvent('chat:addMessage', {
                    template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(255, 11, 10, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i>❕ <span style="font-weight: 700">{0}</span><br> {1}</div>',
                    args = { name, message }
                })
            else
                TriggerEvent('chat:addMessage', {
                    template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(255, 11, 10, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i>❕ <span style="font-weight: 700">Maskerad man</span><br> {1}</div>',
                    args = { name, message }
                })
            end
        end)
    end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

    if onScreen then

        -- Formalize the text
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextScale(0.0*scale, 0.65*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextCentre(true)
        if dropShadow then
            SetTextDropshadow(10, 100, 100, 100, 255)
        end

        -- Calculate width and height
        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.75*scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        if background.enable then
            DrawRect(_x, _y+scale/45, width + 0.01, height + 0.00, background.color.r, background.color.g, background.color.b , background.color.alpha)
        end
    end
end