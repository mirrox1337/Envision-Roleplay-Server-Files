ESX = nil
local usingNote = false
local Notes = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
    if ESX.IsPlayerLoaded() then
        ESX.TriggerServerCallback('barbies_notes:fetchNotesOnGround', function(notes)
            if notes ~= nil then
                for i=1, #notes, 1 do
                    local  noteonground = DoesObjectOfTypeExistAtCoords(notes[i].x, notes[i].y, notes[i].z, 0.1, GetHashKey('p_amanda_note_01_s'))   
                    if noteonground ~= true then 
                        TriggerEvent('barbies_notes:SpawnNotes', notes[i].x, notes[i].y, notes[i].z)
                        table.insert(Notes, {id = {coords = {x = notes[i].x, y = notes[i].y, z = notes[i].z}, id = notes[i].id}})
                    end 
                end
            end
        end)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    Citizen.Wait(200)
    ESX.TriggerServerCallback('barbies_notes:fetchNotesOnGround', function(notes)
        if notes ~= nil then
            for i=1, #notes, 1 do
                local  noteonground = DoesObjectOfTypeExistAtCoords(notes[i].x, notes[i].y, notes[i].z, 0.1, GetHashKey('p_amanda_note_01_s'))  
                if noteonground ~= true then 
                    TriggerEvent('barbies_notes:SpawnNotes', notes[i].x, notes[i].y, notes[i].z)
                    table.insert(Notes, {id = {coords = {x = notes[i].x, y = notes[i].y, z = notes[i].z}, id = notes[i].id}})
                end    
            end
        end
    end)
end)

RegisterNetEvent('barbies_notes:noteMenu')
AddEventHandler('barbies_notes:noteMenu', function()
    ESX.TriggerServerCallback('barbies_notes:fetchNotes', function(notes)
		ESX.UI.Menu.CloseAll()
		local elements = {
            {label = 'Skapa ny anteckning', value = 'newNote'}
        }

		for i=1, #notes, 1 do
			table.insert(elements, {
				label  = (notes[i].label),
				noteID = notes[i].id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = 'Anteckningar',
			align    = 'right',
			elements = elements
		}, function(data, menu)
            menu.close()
            if data.current.value == 'newNote' then
                TriggerEvent('barbies_notes:createNote')
            else 
                ESX.TriggerServerCallback('barbies_notes:showNote', function(note)
                    Citizen.Wait(5)
                    notepadanim()
                    local noteinfo = table.unpack(note)
			    	SetNuiFocus(true, true)
                    SendNUIMessage({action = 'showNote', data = noteinfo})
                    usingNote = true
                end, data.current.noteID)
            end
		end, function(data, menu)
			menu.close()
		end)
	end)
end)

RegisterNetEvent('barbies_notes:SpawnNotes')
AddEventHandler('barbies_notes:SpawnNotes', function(x, y ,z)
    local coords3 = {
        x = x, 
        y = y, 
        z = z
    }
    ESX.Game.SpawnObject(1005988375, coords3, function(note)
        FreezeEntityPosition(note, true)
        SetEntityAsMissionEntity(object, true, false)
        SetEntityCollision(note, false, true)
    end)
end)

RegisterNetEvent('barbies_notes:reSync')
AddEventHandler('barbies_notes:reSync', function(id)
    Notes = {}
    ESX.TriggerServerCallback('barbies_notes:fetchNotesOnGround', function(notes)
        for i=1, #notes, 1 do
            table.insert(Notes, {id = {coords = {x = notes[i].x, y = notes[i].y, z = notes[i].z}, id = notes[i].id}})
        end
    end)  
end)

RegisterNetEvent('barbies_notes:createNote')
AddEventHandler('barbies_notes:createNote', function()
    Citizen.Wait(5)
    notepadanim()
    SetNuiFocus(true, true)    
    SendNUIMessage({action = 'createNote'})
    usingNote = true
end)

RegisterNetEvent('barbies_notes:removeSyncedNote')
AddEventHandler('barbies_notes:removeSyncedNote', function(x, y, z)
    local Note = GetClosestObjectOfType(x, y, z, 0.1, GetHashKey('p_amanda_note_01_s'))
    NetworkFadeOutEntity(Note, false, false)
    SetEntityAsMissionEntity(Note, false, false)
    ESX.Game.DeleteObject(Note)  
end)    

RegisterNetEvent('barbies_notes:createSyncedNote')
AddEventHandler('barbies_notes:createSyncedNote', function(x, y, z)
    local coords3 = {
        x = x, 
        y = y, 
        z = z
    }
    ESX.Game.SpawnObject(1005988375, coords3, function(note)
        FreezeEntityPosition(note, true)
        SetEntityCollision(note, false, true)
    end)
end)

RegisterNetEvent('barbies_notes:foundNote')
AddEventHandler('barbies_notes:foundNote', function(id)
    local pickupdict = "pickup_object"	
    local single_note_prop = 'prop_amanda_note_01'
    local player = PlayerPedId()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local x,y,z = table.unpack(GetEntityCoords(player))
    ESX.TriggerServerCallback('barbies_notes:showNote', function(note)
        local noteinfo = table.unpack(note)
        Citizen.Wait(5)
        notepadanim()
        SetNuiFocus(true, true)
        SendNUIMessage({action = 'showNote', data = noteinfo})
        usingNote = true
    end, id)
end)

--UI--
RegisterNUICallback('save', function(data)
    if data.noteid ~= 'nil' then 
        TriggerServerEvent('barbies_notes:saveNote', data.label, data.subject, data.noteid) 
    else
        TriggerServerEvent('barbies_notes:saveNote', data.label, data.subject)
    end
end)

RegisterNUICallback('throw', function(data)
    local coords = GetEntityCoords(PlayerPedId())
    local headingvector = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + headingvector * 1.0)
    local coords2 = {
        x = x,
        y = y,
        z = z - 1
    }

    z2 = z - 1
    Citizen.Wait(10)
    TriggerServerEvent('barbies_notes:createSyncedNote', x, y, z2)
    if data.noteid ~= 'nil' then
        TriggerServerEvent('barbies_notes:dropNote', data.rubrik, data.text, x, y, z2, data.noteid)  
    else
        TriggerServerEvent('barbies_notes:dropNote', data.rubrik, data.text, x, y, z2)
    end
    cleanplayer()
end)

RegisterNUICallback('rip', function(data)
    if data.noteid ~= 'nil' then 
        TriggerServerEvent('barbies_notes:deleteNote', data.noteid) 
    end
    ESX.ShowNotification("Du rev upp en anteckning")
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false)
    cleanplayer()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        cleanplayer()
        if usingNote then
			usingNote = false
			SetNuiFocus(false, false)
			SendNUIMessage({type = 'closeAll'})
		end
	end
end)

--functions
function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = 0.25
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(1, 1, 0, 0, 255)
        SetTextEdge(0, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(2)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function notepadanim()
    local player = PlayerPedId()
    local ad = "missheistdockssetup1clipboard@base"			
	local prop_name =   'prop_notepad_01'
	local secondaryprop_name =  'prop_pencil_01'
	RequestAnimDict(ad)
	while not HasAnimDictLoaded(ad) do
        Citizen.Wait(100)
    end
	local x,y,z = table.unpack(GetEntityCoords(player))
	prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
	secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true) -- notepad
	AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.12, 0.0, 0.001, -150.0, 0.0, 0.0, true, true, false, true, 1, true) -- pencil
	TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )    
end

function cleanplayer()
    ClearPedTasks(PlayerPedId())
    ClearPedSecondaryTask(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local pen = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 1.0, GetHashKey('prop_pencil_01'))
    local pad = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 1.0, GetHashKey('prop_notepad_01'))
    local noteSingle = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 1.0, GetHashKey('prop_amanda_note_01'))
    SetEntityAsMissionEntity(pen, false, false)
    SetEntityAsMissionEntity(pad, false, false)
    SetEntityAsMissionEntity(noteSingle, false, false)
    if pen ~= 0 and pen ~= nil then
        ESX.Game.DeleteObject(pen)
    end
    if pad ~= 0 and pad ~= nil then
        ESX.Game.DeleteObject(pad)
    end
    if noteSingle ~= 0 and noteSingle ~= nil then
        ESX.Game.DeleteObject(noteSingle)
    end
end

--loop
Citizen.CreateThread(function()
    while true do
        local wait = 500
        for i=1, #Notes, 1 do
            local playercoords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(playercoords, Notes[i].id.coords.x, Notes[i].id.coords.y, Notes[i].id.coords.z, true) <= 1.5 then
                wait = 10
                DrawMarker(25, Notes[i].id.coords.x, Notes[i].id.coords.y, Notes[i].id.coords.z, 0, 0, 0, 0, 0, 0.0, 0.4, 0.4, 0.01, 255, 255, 255, 0.5, 0, 0, 0,0)
                Draw3DText(Notes[i].id.coords.x, Notes[i].id.coords.y, Notes[i].id.coords.z + 0.45, '~g~[E]~w~ för att plocka upp ett skrynkligt papper')
                if IsControlJustReleased(0, 38) then
                    NoteId = Notes[i].id.id
                    FreezeEntityPosition(PlayerPedId(), true)
                    Citizen.Wait(5)
                    TriggerServerEvent('barbies_notes:removeSyncedNote', Notes[i].id.coords.x, Notes[i].id.coords.y, Notes[i].id.coords.z)
                    Citizen.Wait(5)
                    TriggerServerEvent('barbies_notes:foundNote', NoteId) 
                end
            end   
        end
        Citizen.Wait(wait)
    end
end)