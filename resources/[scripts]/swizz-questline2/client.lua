local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  }
  
  ESX = nil
  washed = false
  inmission = false
  missionblip2 = false
  missionblip3 = false
  missionblip4 = false
  missionblip5 = false



  --- Threads
  Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(response)
            ESX = response
        end)

        Citizen.Wait(100)

        LoadPeds()
    end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) 
		ESX.TriggerServerCallback('cooldown2', function(cooldown2)
			if cooldown2 > 0 then
				TriggerServerEvent('cooldown2tick') 
				print("- 1 minut")
				print(cooldown2)
			end
		end)
	end
end) 

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-1178.09, -891.56, 13.76)

    SetBlipSprite (blip,  500)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 52)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Raphael')
    EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('esx:playerLoaded')
 AddEventHandler('esx:playerLoaded', function(xPlayer)
   PlayerData = xPlayer
 end)

  local PedPositions = {
    ["1"] = {
        ["hash"] = -927261102,
        ["x"] = -1178.09, 
        ["y"] = -891.56, 
        ["z"] = 13.76, 
        ["h"] = 305.74,
        ["pedId"] = 0,
        ["scenario"] = "WORLD_HUMAN_SEAT_WALL_TABLET"
    },
  }

  function LoadPeds()
    for loc, val in pairs(PedPositions) do

        ESX.Streaming.RequestModel(val["hash"])

        val["pedId"] = CreatePed(5, val["hash"], val["x"], val["y"], val["z"] - 1.0, val["h"], false)

        SetPedCombatAttributes(val["pedId"], 46, true)                     
        SetPedFleeAttributes(val["pedId"], 0, 0)                      
        SetBlockingOfNonTemporaryEvents(val["pedId"], true)

        SetEntityInvincible(val["pedId"], true)

        SetEntityAsMissionEntity(val["pedId"], true, true)

        FreezeEntityPosition(val["pedId"], true)

        TaskStartScenarioInPlace(val["pedId"], val["scenario"], 0, true, true)
    end
end

  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      local wait = 500
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -1178.09, -891.56, 13.76, true) < 5.0 and not inmission then
        wait = 5
        ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att prata med med ~g~Raphael")
        if IsControlJustPressed(0, 38) then
            wait = 25000
            ESX.TriggerServerCallback('quest1', function(state)
            ESX.TriggerServerCallback('cooldown2', function(cooldown2)
            if state == 0 and cooldown2 == 0 then
              exports['mythic_notify']:SendAlert('inform', 'Tjena, välkommen till min restaurang!', 10000)
              menu1()
            elseif state == 1 and cooldown2 == 0 then
              menu2()
            elseif state == 2 and cooldown2 == 0 then
              menu3()
            elseif state == 3 and cooldown2 == 0 then
              menu4()
            elseif state == 4 and cooldown2 == 0 then
              mission = math.random(1,3)
              if mission == 1 then
                menu2()
                print("Mission 1")
              elseif mission == 2 then
                menu3()
                print("MISSION 2")
              elseif mission == 3 then
                print("MISSION 3")
                menu4()
              end
            elseif cooldown2 > 0 then
              if cooldown2/60 >= 1  then
                exports['mythic_notify']:SendAlert('inform', 'Jag har inte tid nu, kom tillbaks om ca ' .. math.ceil(cooldown2/60) .. ' timmar.', 10000)
                else
                exports['mythic_notify']:SendAlert('inform', 'Jag har inte tid nu, kom tillbaks om ' .. cooldown2 ..' minuter.', 10000)
              end
            end   
                
           
          end)  
          end) 
        end    
      end  
      Citizen.Wait(wait)
    end   
  end)  
  


  -- Functions
function menu1()
  exports['mythic_notify']:SendAlert('inform', 'Jag skulle behöva lite ny fisk till burgarna, skulle du kunna lösa 40 torskar?', 10000)
   ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'bike_menu',
        {
            title    = 'Daglig syssla',
            align    = 'center',
            elements = {
              {label = 'Här har du!', value = 'yes'},
                {label = 'Jag kommer tillbaks senare!', value = 'no'},

            }
        },
        function(data, menu)
            if data.current.value == 'yes' then
                
                TriggerServerEvent('fishes')
                menu.close()
            elseif data.current.value == 'no' then
              

              ClearPedTasks(PlayerPedId())
                menu.close()
                
          end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasks(PlayerPedId())
        end
    )
end

function menu2()

  exports['mythic_notify']:SendAlert('inform', 'Tack för hjälpen senast. Våra bilar börjar bli smutsiga, vill du tvätta en av de?', 10000)
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'bike_menu',
        {
            title    = 'Daglig syssla',
            align    = 'center',
            elements = {
            	{label = 'Ja, visst', value = 'yes'},
                {label = 'Nej, inte just nu', value = 'no'},

            }
        },
        function(data, menu)
            if data.current.value == 'yes' then
                
                carwash()
                menu.close()
                
            elseif data.current.value == 'no' then
            	

            	ClearPedTasks(PlayerPedId())
                menu.close()
                
        	end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasks(PlayerPedId())
        end
    )
end

function menu3()

  exports['mythic_notify']:SendAlert('inform', 'Tack för hjälpen senast. Jag behöver lämna ett paket, vill du göra det åt mig?', 10000)
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'bike_menu',
        {
            title    = 'Daglig syssla',
            align    = 'center',
            elements = {
              {label = 'Ja, visst', value = 'yes'},
                {label = 'Nej, inte just nu', value = 'no'},

            }
        },
        function(data, menu)
            if data.current.value == 'yes' then
                
                deliver()
                menu.close()
                
            elseif data.current.value == 'no' then
              

              ClearPedTasks(PlayerPedId())
                menu.close()
                
          end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasks(PlayerPedId())
        end
    )
end

function menu4()

  exports['mythic_notify']:SendAlert('inform', 'Tack för hjälpen senast. Jag skulle behöva sätta upp lite reklam, vill du göra det åt mig?', 10000)
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'bike_menu',
        {
            title    = 'Daglig syssla',
            align    = 'center',
            elements = {
              {label = 'Ja, visst', value = 'yes'},
                {label = 'Nej, inte just nu', value = 'no'},

            }
        },
        function(data, menu)
            if data.current.value == 'yes' then
                
                postermission()
                menu.close()
                
            elseif data.current.value == 'no' then
              

              ClearPedTasks(PlayerPedId())
                menu.close()
                
          end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasks(PlayerPedId())
        end
    )
end

function menu5()

  exports['mythic_notify']:SendAlert('inform', 'Tack för hjälpen senast. Jag skulle behöva hugga ner ett träd på trädgården där hemma, vill du göra det åt mig?', 10000)
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'bike_menu',
        {
            title    = 'Daglig syssla',
            align    = 'center',
            elements = {
              {label = 'Ja, visst', value = 'yes'},
                {label = 'Nej, inte just nu', value = 'no'},

            }
        },
        function(data, menu)
            if data.current.value == 'yes' then
                
                Tree()
                menu.close()
                
            elseif data.current.value == 'no' then
              

              ClearPedTasks(PlayerPedId())
                menu.close()
                
          end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasks(PlayerPedId())
        end
    )
end

function carwash()
  Objective = "WASH"
  inmission = true
  ESX.Game.SpawnVehicle("burrito", {x = -1168.59, y = -895.05, z = 13.96}, 31.25, function(car)
    SetNewWaypoint(22.97, -1392.24)
    Citizen.CreateThread(function()
      while true do
        Citizen.Wait(0)
      	if Objective == "WASH" then
        
        DrawMarker(21, 22.97, -1392.24, 29.70, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 100, false, true, 2, false, false, false, false)
        	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 22.97, -1392.24, 29.70, true) < 5 and washed == false then
            wait = 5
      		  ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att tvätta bilen. Betala ~g~500~w~kr")
          	if IsControlJustPressed(0, 38) and IsPedInVehicle(PlayerPedId(), car) then
           	 washed = true
            	TriggerServerEvent('removemoney', 500)
            	exports['mythic_notify']:SendAlert('inform', 'Åk nu tillbaka och lämna fordonet, bra jobbat!', 10000)
            	Objective = "GETBACK"
            end
          end
        end
        if Objective == "GETBACK" then
          if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -1168.59, -895.05, 13.96, true) < 20 and washed == true then
              wait = 5
            print("Nu är jag här")
            ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att slutföra uppdraget.")
            if IsControlJustPressed(0, 38) and IsPedInVehicle(PlayerPedId(), car) then
              DeleteVehicle(car)
              exports['mythic_notify']:SendAlert('inform', 'Tack för hjälpen återigen! Kom tillbaks imorgon om du vill ha nya uppgifter!', 10000)
              TriggerServerEvent('updatequest1', 2)
              TriggerServerEvent('addcooldown2', 420)
              TriggerServerEvent('dailyquest:reward2')
              inmission = false
              break
            end
          end
        end
      end
   	end)
  end)
end

function deliver()
  Objective = "GET"
inmission = true

  SetNewWaypoint(-975.40, -267.53)
   Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if Objective == "GET" then
              drawTxt(0.85, 1.45, 1.0,1.0,0.4, "~b~Hämta sakerna vid Raphels lokal", 255, 255, 255, 255)
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -975.40, -267.53, 38.31, true) < 20.0 then
                DrawMarker(25, -975.40, -267.53, 38.31, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1, 1, 1, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                draw3DText(-975.40, -267.53, 38.00, 'Tryck [~b~E] för att ~b~plocka sakerna.', 4, 0.10, 0.10, 255, 255, 255, 255)
                if IsControlJustReleased(0, 38) then
                        Objective = "DELIVER"
                    end    
                end        

            elseif Objective == "DELIVER" then
                SetNewWaypoint(1392.33, 3604.24)
                drawTxt(0.85, 1.45, 1.0,1.0,0.4, "Åk till din destination och ~b~lämna över sakerna.", 255, 255, 255, 255)
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 1392.33, 3604.24, 34.98, true) < 20.0 then
                        DrawMarker(25, 1392.33, 3604.24, 33.98, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1, 1, 1, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                        draw3DText(1392.33, 3604.24, 33.78, 'Tryck [~b~E] för att ~b~lämna sakerna.', 4, 0.06, 0.06, 255, 255, 255, 255)
                        if IsControlJustReleased(0, 38) then
                            Objective = "REWARD"
                        end
                    end        


            elseif Objective == "REWARD" then
                drawTxt(0.85, 1.45, 1.0,1.0,0.4, "Åk tillbaka till Burger Shot.", 255, 255, 255, 255)
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -1168.59, -895.05, 13.96, true) < 15.0 then
                    ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att slutföra uppdraget.")
                    if IsControlJustReleased(0, 38) then
                        exports['mythic_notify']:SendAlert('inform', 'Tack för hjälpen återigen! Kom tillbaks imorgon om du vill ha nya uppgifter!', 10000)
                        Objective = ""
                        TriggerServerEvent('updatequest1', 3)
                        TriggerServerEvent('addcooldown2', 420)
                        TriggerServerEvent('dailyquest:reward2')
                        inmission = false
                    end
                end            
            end
        end    
    end)
end

function postermission()
 local animdict = "anim@amb@nightclub@poster@"
  Objective = "FIRST"
  Setmissionblip()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if Objective == "FIRST" then
             local Coordsx = 211.48
             local Coordsy = 171.54
             local Coordsz = 104.53

              drawTxt(0.85, 1.45, 1.0,1.0,0.4, "~b~Sätt ut poster.", 255, 255, 255, 255)
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 20.0 then
                DrawMarker(25, Coordsx, Coordsy, Coordsz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1, 1, 1, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                draw3DText(Coordsx, Coordsy, Coordsz, 'Tryck [~b~E] för att ~b~sätta ut.', 4, 0.10, 0.10, 255, 255, 255, 255)
                if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 3.0 then
                        RemoveBlip(DestinationBlip)
                        Objective = "SECOND"
                        SetEntityCoords(GetPlayerPed(-1), Coordsx, Coordsy, Coordsz)
                        SetEntityHeading(GetPlayerPed(-1), 156.54)
                        RequestAnimDict(animdict)
                        TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@nightclub@poster@' ,'poster_placement' ,8.0, -8.0, -1, 0, 0, false, false, false )
                end        
              end  
            elseif Objective == "SECOND" then 
               if missionblip2 == false then
                Setmissionblip()
                missionblip2 = true
                  end
             local Coordsx = 344.62
             local Coordsy = -963.26
             local Coordsz = 28.43

              drawTxt(0.85, 1.45, 1.0,1.0,0.4, "~b~Sätt ut nästa poster.", 255, 255, 255, 255)
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 20.0 then
                DrawMarker(25, Coordsx, Coordsy, Coordsz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1, 1, 1, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                draw3DText(Coordsx, Coordsy, Coordsz, 'Tryck [~b~E] för att ~b~sätta ut.', 4, 0.10, 0.10, 255, 255, 255, 255)
                if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 3.0 then
                  RemoveBlip(DestinationBlip)
                        Objective = "THIRD"
                        SetEntityCoords(GetPlayerPed(-1), Coordsx, Coordsy, Coordsz)
                        SetEntityHeading(GetPlayerPed(-1), 178.16)
                        RequestAnimDict(animdict)
                        TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@nightclub@poster@' ,'poster_placement' ,8.0, -8.0, -1, 0, 0, false, false, false )
                end
              end
              elseif Objective == "THIRD" then 
                if missionblip3 == false then
                Setmissionblip()
                missionblip3 = true
                  end
             local Coordsx = 127.51
             local Coordsy = -1300.71
             local Coordsz = 28.23

              drawTxt(0.85, 1.45, 1.0,1.0,0.4, "~b~Sätt ut nästa poster.", 255, 255, 255, 255)
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 20.0 then
                DrawMarker(25, Coordsx, Coordsy, Coordsz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1, 1, 1, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                draw3DText(Coordsx, Coordsy, Coordsz, 'Tryck [~b~E] för att ~b~sätta ut.', 4, 0.10, 0.10, 255, 255, 255, 255)
                if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 3.0 then
                  RemoveBlip(DestinationBlip)
                        Objective = "FOURTH"
                        SetEntityHeading(GetPlayerPed(-1), 24.74)
                        RequestAnimDict(animdict)
                        TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@nightclub@poster@' ,'poster_placement' ,8.0, -8.0, -1, 0, 0, false, false, false )
                end
              end
              elseif Objective == "FOURTH" then 
                 if missionblip4 == false then
                Setmissionblip()
                missionblip4 = true
                  end
             local Coordsx = -840.54
             local Coordsy = -271.19
             local Coordsz = 36.88

              drawTxt(0.85, 1.45, 1.0,1.0,0.4, "~b~Sätt ut nästa poster.", 255, 255, 255, 255)
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 20.0 then
                DrawMarker(25, Coordsx, Coordsy, Coordsz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1, 1, 1, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                draw3DText(Coordsx, Coordsy, Coordsz, 'Tryck [~b~E] för att ~b~sätta ut.', 4, 0.10, 0.10, 255, 255, 255, 255)
                if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 3.0 then
                  RemoveBlip(DestinationBlip)
                        Objective = "LAST"
                        SetEntityCoords(GetPlayerPed(-1), Coordsx, Coordsy, Coordsz)
                        SetEntityHeading(GetPlayerPed(-1), 324.44)
                        RequestAnimDict(animdict)
                        TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@nightclub@poster@' ,'poster_placement' ,8.0, -8.0, -1, 0, 0, false, false, false )
                end
              end
              elseif Objective == "LAST" then 
                 if missionblip5 == false then
                Setmissionblip()
                missionblip5 = true
                  end
             local Coordsx = -355.62
             local Coordsy = -127.74
             local Coordsz = 38.43

              drawTxt(0.85, 1.45, 1.0,1.0,0.4, "~b~Sätt ut nästa poster.", 255, 255, 255, 255)
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 20.0 then
                DrawMarker(25, Coordsx, Coordsy, Coordsz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1, 1, 1, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                draw3DText(Coordsx, Coordsy, Coordsz, 'Tryck [~b~E] för att ~b~sätta ut.', 4, 0.10, 0.10, 255, 255, 255, 255)
                if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), Coordsx, Coordsy, Coordsz, true) < 3.0 then
                  RemoveBlip(DestinationBlip)
                        Objective = "DONE"
                        SetEntityCoords(GetPlayerPed(-1), Coordsx, Coordsy, Coordsz)
                        SetEntityHeading(GetPlayerPed(-1), 252.28)
                        RequestAnimDict(animdict)
                        TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@nightclub@poster@' ,'poster_placement' ,8.0, -8.0, -1, 0, 0, false, false, false )
                end
              end
              elseif Objective == "DONE" then 
             local Coordsx = 344.62
             local Coordsy = -963.26
             local Coordsz = 28.43

              drawTxt(0.85, 1.45, 1.0,1.0,0.4, "~b~Åk tillbaks till Raphael.", 255, 255, 255, 255)
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -1168.59, -895.05, 13.96, true) < 20.0 then
                ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att avsluta.")
                if IsControlJustReleased(0, 38) then
                      exports['mythic_notify']:SendAlert('inform', 'Tack för hjälpen, bra jobbat!', 10000)
                      TriggerServerEvent('updatequest1', 4)
                        TriggerServerEvent('addcooldown2', 420)
                        TriggerServerEvent('dailyquest:reward2')
                  break
                end
              end
            end
        end
    end)     

end



function Setmissionblip()
  if Objective == "FIRST" then

  DestinationBlip = AddBlipForCoord(211.48, 171.54, 105.53)
  SetBlipRoute(DestinationBlip,  true)
  SetBlipSprite(DestinationBlip, 351)
  SetBlipColour(DestinationBlip, 49)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Poster")
  EndTextCommandSetBlipName(DestinationBlip)
  elseif Objective == "SECOND" then
     DestinationBlip = AddBlipForCoord(344.62, -963.26, 28)
  SetBlipRoute(DestinationBlip,  true)
  SetBlipSprite(DestinationBlip, 351)
  SetBlipColour(DestinationBlip, 49)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Poster")
  EndTextCommandSetBlipName(DestinationBlip)
  return
    elseif Objective == "THIRD" then
     DestinationBlip = AddBlipForCoord(127.51, -1300.71, 28.23)
  SetBlipRoute(DestinationBlip,  true)
  SetBlipSprite(DestinationBlip, 351)
  SetBlipColour(DestinationBlip, 49)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Poster")
  EndTextCommandSetBlipName(DestinationBlip)
   return
    elseif Objective == "FOURTH" then
     DestinationBlip = AddBlipForCoord(-840.54, -271.19, 37.88)
  SetBlipRoute(DestinationBlip,  true)
  SetBlipSprite(DestinationBlip, 351)
  SetBlipColour(DestinationBlip, 49)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Poster")
  EndTextCommandSetBlipName(DestinationBlip)
   return
    elseif Objective == "LAST" then
     DestinationBlip = AddBlipForCoord(-355.62, -127.74, 39.43)
  SetBlipRoute(DestinationBlip,  true)
  SetBlipSprite(DestinationBlip, 351)
  SetBlipColour(DestinationBlip, 49)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Poster")
  EndTextCommandSetBlipName(DestinationBlip)
   return
end
end

RegisterNetEvent('swizz:update')
AddEventHandler('swizz:update', function()
  print("YOOO")
    TriggerServerEvent('updatequest1', 1)
    TriggerServerEvent('addcooldown2', 420)
    TriggerServerEvent('dailyquest:reward2')
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
  end

    function draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*15
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

  
              

