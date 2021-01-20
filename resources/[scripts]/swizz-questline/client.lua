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
  hasStartedTimer = false
  local dailyquest = false
  local hackingdone = false
  local hackingfailed = false
  local gotkemikalier = false
  local failed = false
  local Objective = ""
  local rewardCam = nil
  
  Citizen.CreateThread(function()
      while ESX == nil do
          TriggerEvent("esx:getSharedObject", function(response)
              ESX = response
          end)
  
          Citizen.Wait(100)
  
          LoadPeds()
      end
  end)
  
  
  local PedPositions = {
      ["Franklin"] = {
          ["hash"] = -1692214353,
          ["x"] = -1909.01, 
          ["y"] = -581.22, 
          ["z"] = 18.6, 
          ["h"] = 46.2,
          ["pedId"] = 0,
          ["scenario"] = "WORLD_HUMAN_SEAT_WALL_TABLET"
      },
  
      ["Michael"] = {
          ["hash"] = 225514697,
          ["x"] = -804.86, 
          ["y"] = 173.17, 
          ["z"] = 72.27, 
          ["h"] = 297.15,
          ["pedId"] = 0,
          ["scenario"] = "PROP_HUMAN_SEAT_DECKCHAIR_DRINK"
      },
  
          ["Trevor"] = {
          ["hash"] = -1686040670,
          ["x"] = 1976.67, 
          ["y"] = 3819.39, 
          ["z"] = 33.45, 
          ["h"] = 123.18,
          ["pedId"] = 0,
          ["scenario"] = "PROP_HUMAN_BUM_SHOPPING_CART"
      },
  
          ["Wade"] = {
          ["hash"] = -1835459726,
          ["x"] = -1157.33, 
          ["y"] = -1518.74, 
          ["z"] = 10.63, 
          ["h"] = 278.91,
          ["pedId"] = 0,
          ["scenario"] = "WORLD_HUMAN_SMOKING_POT"
      },
  
          ["Lester"] = {
          ["hash"] = -1248528957,
          ["x"] = 706.42, 
          ["y"] = -963.09, 
          ["z"] = 30.41, 
          ["h"] = 210.03,
          ["pedId"] = 0,
          ["scenario"] = "WORLD_HUMAN_CLIPBOARD"
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
  
  local DoingAnyQuest = false
  
  
  Citizen.CreateThread(function()

      while true do
         Citizen.Wait(200)
          local sleep = 500
          if not DoingAnyQuest then
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -1909.01, -581.22, 18.9, true) < 5.0 then
                  DrawMarker(32, -1909.01, -581.18, 19.8, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                  ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att prata med med~r~ Franklin")
                  sleep = 5
                  if IsControlJustPressed(0, 38) then
                      DoScreenFadeOut(500)
                      Citizen.Wait(1500)
                      TaskStartScenarioAtPosition(PlayerPedId(), "PROP_HUMAN_SEAT_BENCH", -1910.56, -581.66, 18.6, 325.49, 0, true, true)
                      DoScreenFadeIn(500)
                      Citizen.Wait(4000)
                      ESX.TriggerServerCallback('quest', function(questfranklin)
                          print(questfranklin)
                          if questfranklin == 0 then 
                              print("Start driving")
                              StartDriving()
                          elseif questfranklin == 1 then
                              ESX.ShowAdvancedNotification("Franklin", "~r~Be faithful", "Go to Michaels house, he got some work for you, I told him you are coming to help him.", "CHAR_FRANKLIN", 9)
                              ClearPedTasks(PlayerPedId())
                              print("Funkar inte..")   
                          elseif questfranklin == 3 then     
                              ESX.ShowAdvancedNotification("Franklin", "~r~Be faithful", "Hey man, you're already back? Eyo, Trevor called me for help, I got things to do. Can you help him?", "CHAR_FRANKLIN", 9)
                              Citizen.Wait(500)
                              ESX.ShowAdvancedNotification("Franklin", "~r~Be faithful", "He's living in a caravan in Sandy Shores. I guess you'll find him.", "CHAR_FRANKLIN", 9)
                              Citizen.Wait(15000)
                              TriggerServerEvent("InteractSound_SV:PlayOnSource", "missioncomplete", 1.0)
                              ESX.Scaleform.ShowFreemodeMessage("Be faithful", "~g~Din tillit till Franklin & Michael ökade..", 10)
                              TriggerServerEvent('updatequest', 3)
                              ClearPedTasks(PlayerPedId())
                          elseif questfranklin == 50 then
                              ESX.ShowAdvancedNotification("Franklin", "~r~Enemy", "Get the hell outta here, before I kick your balls!", "CHAR_FRANKLIN", 9)
                               ClearPedTasks(PlayerPedId()) 
                          else    
                              ESX.ShowAdvancedNotification("Franklin", "~y~Known", "Sorry, I'm busy right now.", "CHAR_FRANKLIN", 9) 
                               ClearPedTasks(PlayerPedId())
                          end
                      end)
                      Citizen.Wait(15000)  
                  end
              end
          end
          Citizen.Wait(sleep)
      end
  end)
  
  Citizen.CreateThread(function()


      while true do
         Citizen.Wait(200)
          local sleep = 500
          if not DoingAnyQuest then
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -804.73, 173.03, 72.34, true) < 5.0 then
                  DrawMarker(32, -805.03, 173.09, 73.45, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                  ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att prata med med~r~ Michael")
                  sleep = 5
                  if IsControlJustPressed(0, 38) then
                      ESX.TriggerServerCallback('quest', function(questfranklin)
                          print(questfranklin)
                          if questfranklin == 1 then
                              DoScreenFadeOut(500)
                              Citizen.Wait(1500)
                              TaskStartScenarioAtPosition(PlayerPedId(), "PROP_HUMAN_SEAT_BENCH", -804.80, 174.98, 72.20, 237.75, 0, true, true)
                              DoScreenFadeIn(500)
                              Citizen.Wait(500)
                              ESX.ShowAdvancedNotification("Michael", "~r~Be faithful", "You're going to rob the man who was cheating with Amanda.", "CHAR_MICHAEL", 9)
                              Citizen.Wait(500)
                              ESX.ShowAdvancedNotification("Michael", "~r~Be faithful", "He usually hangs around at the tennis courts. Go search for him.", "CHAR_MICHAEL", 9)
                              Citizen.Wait(3500)
                              ESX.ShowAdvancedNotification("Michael", "~r~Be faithful", "I don't know wich one, but look at every tennis court in the city.", "CHAR_MICHAEL", 9)
                              RobTennisCoach()
                              ClearPedTasks(PlayerPedId())
                          elseif questfranklin < 1 then
                              ESX.ShowAdvancedNotification("Michael", "~r~Unknown", "Who the hell are you? Get out of my house!", "CHAR_MICHAEL", 5)  
                          else
                              ESX.ShowAdvancedNotification("Michael", "~y~Known", "Sorry, I'm busy right now.", "CHAR_MICHAEL", 5)  
                          end
                      end)  
                      Citizen.Wait(15000)       
                  end        
              end
          end
          Citizen.Wait(sleep)
      end
  end)
  
  Citizen.CreateThread(function()
      Citizen.Wait(200)
      while true do
          local sleep = 500
          if not DoingAnyQuest then
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 1976.67, 3819.39, 33.45, true) < 3.0 then
                  DrawMarker(32, 1976.23, 3819.08, 34.25, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                  ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att prata med med~r~ Trevor")
                  sleep = 5
                  if IsControlJustPressed(0, 38) then
                      ESX.TriggerServerCallback('quest', function(questfranklin)
                          print(questfranklin)
                          if questfranklin == 3 then
                              DoScreenFadeOut(500)
                              Citizen.Wait(1500)
                              TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_DRINKING", 1975.17, 3818.46, 33.44, 299.77, 0, true, true)
                              DoScreenFadeIn(500)
                              Citizen.Wait(500)
                              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "Hahahahah, did Franklin send you? You look silly, but well. Welcome to my woonderful trailer.", "CHAR_TREVOR", 9)
                              Citizen.Wait(500)
                              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "Shut up, I'm just joking. I got a mission for you.", "CHAR_TREVOR", 9)
                              Citizen.Wait(3500)
                              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "Get out, take my red truck in the garage and I'll send you the information.", "CHAR_TREVOR", 9)
                              StealHexer()
                          elseif questfranklin < 2 then
                              ESX.ShowAdvancedNotification("Trevor", "~r~Unknown", "WHO THE HELL ARE YOU? GET OUT NOW BEFORE I FUCK YOU UP!", "CHAR_TREVOR", 9)  
                          else
                              ESX.ShowAdvancedNotification("Trevor", "~y~Known", "Leave me alone. NOW!", "CHAR_TREVOR", 9) 
                          end
                      end)
                      Citizen.Wait(15000)       
                  end        
              end
          end
          Citizen.Wait(sleep)
      end
  end)
  
  Citizen.CreateThread(function()
      Citizen.Wait(200)
      while true do
          local sleep = 500
          if not DoingAnyQuest then
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -1157.33, -1518.74, 10.63, true) < 3.0 then
                  DrawMarker(32, -1157.33, -1518.74, 11.63, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                  ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att prata med med~r~ Wade")
                  sleep = 5
                  if IsControlJustPressed(0, 38) then
                      ESX.TriggerServerCallback('quest', function(questfranklin)
                          print(questfranklin)
                          if questfranklin == 4 then
                              DoScreenFadeOut(500)
                              Citizen.Wait(1500)
                              DoScreenFadeIn(500)
                              Citizen.Wait(500)
                              ESX.ShowAdvancedNotification("Wade", "~r~White trash MCs", "I knew that you would come! Welcome to my, uh Floyds apartment!", "CHAR_WADE", 9)
                              Citizen.Wait(5000)
                              ESX.ShowAdvancedNotification("Wade", "~r~White trash MCs", "Weeell, Trevor need some explosives and we're going to fix it for him!", "CHAR_WADE", 9)
                              Citizen.Wait(5000)
                              ESX.ShowAdvancedNotification("Wade", "~r~White trash MCs", "The only way to get some is the Merrywether securitygroups location, in the dock!", "CHAR_WADE", 9)
                              GetExplosives()
                          elseif questfranklin < 3 then
                              ESX.ShowAdvancedNotification("Wade", "~r~Unknown", "Who are you? Back of now! Before I call Trevor!", "CHAR_WADE", 9) 
                          else
                              ESX.ShowAdvancedNotification("Wade", "~y~Known", "Yo man, sorry I'm tired. Comeback later.", "CHAR_WADE", 9) 
                          end
                      end)  
                      Citizen.Wait(15000)       
                  end        
              end
          end
          Citizen.Wait(sleep)
      end
  end)
  
  Citizen.CreateThread(function()
      Citizen.Wait(200)
      while true do
          local sleep = 500
          if not DoingAnyQuest then
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 706.42, -963.09, 31.41, true) < 3.0 and Objective == "" then
                  DrawMarker(32, 706.42, -963.09, 31.41, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                  ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att prata med med~r~ Lester")
                  sleep = 5
                  if IsControlJustPressed(0, 38) then
                      ESX.TriggerServerCallback('quest', function(questfranklin)
                          print(questfranklin)
                           ESX.TriggerServerCallback('cooldown', function(cooldown)
                              print(cooldown)
                          if questfranklin == 6 then
                              DoScreenFadeOut(500)
                              Citizen.Wait(1500)
                              TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_AA_SMOKE", 707.36, -964.22, 30.41, 43.77, 0, true, true)
                              DoScreenFadeIn(1000)
                              ESX.ShowAdvancedNotification("Lester", "~r~A new opening", "Hi, I'm Lester. Nice to see you. I would love to help you.", "CHAR_LESTER", 9) 
                              Citizen.Wait(3000)
                              ESX.ShowAdvancedNotification("Lester", "~r~A new opening", "I can help you with almost everything, trust me. I got contacts all over the city..", "CHAR_LESTER", 9) 
                              Citizen.Wait(5000)
                              print("Öppna Lester meny..")
                              LesterMenu()
                          elseif questfranklin > 6 then
                              ESX.ShowAdvancedNotification("Lester", "~g~Well-known", "Welcome back! What can I help you with? Choose an alternative.", "CHAR_LESTER", 9) 
                              LesterMenu()
                          else
                              ESX.ShowAdvancedNotification("Lester", "~r~Unknown", "Excuuusee me? Who are you? Get out of my room, now.", "CHAR_LESTER", 9) 
  
                          end
                      end)
                      end)
                      Citizen.Wait(15000)       
                  end        
              end
          end
          Citizen.Wait(sleep)
      end
  end)
  
  Citizen.CreateThread(function()
      Citizen.Wait(200)
      while true do
          local sleep = 500
          if not DoingAnyQuest then
              if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -812.07, 189.25, 72.48, true) < 3.0 then
                  DrawMarker(25, -812.07, 189.25, 71.48, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.9, 0.9, 0.9, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                  ESX.ShowHelpNotification("Tryck ~INPUT_CONTEXT~ för att interagera.")
                  sleep = 5
                  if IsControlJustPressed(0, 38) then
                      ESX.TriggerServerCallback('quest', function(questfranklin)
                          print(questfranklin)
                          ESX.TriggerServerCallback('cooldown', function(cooldown)
                              print(cooldown)
                          if questfranklin == 5 and cooldown == 0 then
                              print("Starta garage")
                              DoScreenFadeOut(500)
                              Citizen.Wait(1500)
                              DoScreenFadeIn(500)
                              cutscenegarage()
                          elseif questfranklin == 5 then
                              if cooldown/60 >= 1  then
                              ESX.ShowNotification('Trevor sätter ihop allting. Kom tillbaka om ungefär ~g~'.. math.ceil(cooldown/60) ..'~w~ timmar och kolla om han är klar.')
                              else
                              ESX.ShowNotification('Trevor sätter ihop allting. Kom tillbaka om ungefär  ~g~' .. cooldown .. '~w~ minuter och kolla om han är klar.')
                              end
                          else 
                              ESX.ShowNotification('Det finns inget att göra här..')   
                          end
                      end)    
                      end)  
                      Citizen.Wait(15000)       
                  end        
              end
          end
          Citizen.Wait(sleep)
      end
  end)
              
  
   Citizen.CreateThread(function()
      while true do
          Citizen.Wait(60000) 
          ESX.TriggerServerCallback('cooldown', function(cooldown)
              if cooldown > 0 then
                  TriggerServerEvent('cooldowntick') 
                  print("- 1 minut")
                  print(cooldown)
              end
          end)
      end
  end)                  
  
  function StartDriving()
      local ped = GetPlayerPed(-1)
      ESX.ShowAdvancedNotification("Franklin", "~r~A Fresh Start", "Yo man! Can you help me with a delivery? I'll give you a piece of the cake.", "CHAR_FRANKLIN", 9)
      SpawnFreddie()
      ClearPedTasks(PlayerPedId())
      DoingAnyQuest = true
      ESX.ShowAdvancedNotification("Franklin", "~r~A Fresh Start", "My car is downstairs, get in and I'll send you the details.", "CHAR_FRANKLIN", 9)
      ESX.Game.SpawnVehicle("emperor", {x = -1919.71, y = -583.25, z = 10.78}, 234.08, function(car)
          NetworkFadeInEntity(car, 1)
          while true do
              Citizen.Wait(5)
              if IsPedInVehicle(PlayerPedId(), car) then
                  ESX.ShowAdvancedNotification("Franklin", "~r~A Fresh Start", "Here's the street, bring my stuff.", "CHAR_FRANKLIN", 9)
                  SetNewWaypoint(898.89, -3134.58)
                  while true do
                      Citizen.Wait(5)
                      if GetDistanceBetweenCoords(898.89, -3134.58, 5.0, GetEntityCoords(PlayerPedId()), true) < 5.0 then
                          ESX.ShowAdvancedNotification("Freddie", "~r~A Fresh Start", "Här har du nycklarna till lastbilen, kör tillbaks till franklin", "CHAR_GAYMILITARY", 9)
                        if GetEntityModel(GetVehiclePedIsIn(ped, -1)) == GetHashKey("mule3") then
                          Citizen.Wait(1000)
                          OpenAlternatives()
                          break
                       end
                      end
                  end
              end
          end
      end)
  end
  
  function SpawnFreddie()
      ESX.Game.SpawnVehicle("mule3", {x = 896.44, y = -3132.92, z = 5.0}, 180.0, function(car)
  
          ESX.Streaming.RequestModel(GetHashKey("ig_hao"))
  
          local  Freddie = CreatePed(5, GetHashKey("ig_hao"), 898.89, -3134.58, 5.0, 267.35, false)
  
          SetPedCombatAttributes(Freddie, 46, true)                     
          SetPedFleeAttributes(Freddie, 0, 0)                      
          SetBlockingOfNonTemporaryEvents(Freddie, true)
  
          SetEntityInvincible(Freddie, true)
  
          SetEntityAsMissionEntity(Freddie, true, true)
  
          FreezeEntityPosition(Freddie, true)
      end)
  end
  
  function StealHexer()
      ClearPedTasks(PlayerPedId())
      ESX.Game.SpawnVehicle("bodhi2", {x = 1976.39, y = 3826.42, z = 32.36}, 118.62, function(car)
          ESX.Game.SpawnVehicle("hexer", {x = 985.26, y = -107.58, z = 74.35}, 142.22, function(hexer)
          NetworkFadeInEntity(car, 1)
              while true do
              Citizen.Wait(5)
                  if IsPedInVehicle(PlayerPedId(), car) then
                      ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "There we gooo! Drive to the Lost MC club. Go and get the hexer. Then leave!", "CHAR_TREVOR", 9)
                      Citizen.Wait(1000)
                      ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "If you're not quick and smart enough they'll notice you, and they will blast your head off! Hurry!", "CHAR_TREVOR", 9)
                      SetNewWaypoint(985.98, -108.01)
                      while true do
                      Citizen.Wait(5)
                          if IsPedInVehicle(PlayerPedId(), hexer) then
                              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "Wohoo! Get away from those bastards, fast!", "CHAR_TREVOR", 9)
                              Citizen.Wait(5000)
                              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "I got an idea, you will love it! I'll call Wade first and then I'll let you know!", "CHAR_TREVOR", 9)
                              Citizen.Wait(5000)
                              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "Drive the Hexer to Michaels house, I'm sure he wont get tooo mad. See ya!", "CHAR_TREVOR", 9)
                              SetNewWaypoint(-820.09, 184.12)
                              while true do
                                  Citizen.Wait(5)
                                  DrawMarker(0, -822.35, 183.08, 71.91 + 1.4, 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 0, 232, 255, 155, 0, 0, 0, 1, 0, 0, 0)
                                  if GetDistanceBetweenCoords(-822.35, 183.08, 71.91, GetEntityCoords(PlayerPedId()), true) < 5.0 then
                                      TaskLeaveVehicle(PlayerPedId(), hexer, 0)
                                      Citizen.Wait(3000)
                                      ClearPedTasks(PlayerPedId())
                                      TriggerServerEvent('updatequest', 4)
                                      Citizen.Wait(5000)
                                      ESX.ShowAdvancedNotification("Wade", "~r~White trash MCs", "Hey, I heard you helped Trevor out. He's idea is crazy! Come and meet me. I've sent you the GPS location.", "CHAR_WADE", 9)
                                      SetNewWaypoint(-1149.39, -1522.68)
                                      Citizen.Wait(15000)
                                      DeleteVehicle(hexer)
                                      Citizen.Wait(5)
                                      DeleteVehicle(car)
                                      break
                                  end    
                              end    
                          end
                      end    
                  end
              end
          end)    
      end)    
  end    
  
  function OpenAlternatives()
      ESX.UI.Menu.CloseAll()
  
      ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'bike_menu',
          {
              title    = 'Handlinsalternativ',
              align    = 'center',
              elements = {
                  {label = 'Lämna sakerna till Franklin', value = 'yes'},
                  {label = 'Ta sakerna för dig själv', value = 'no'},
  
              }
          },
          function(data, menu)
              if data.current.value == 'yes' then
                  menu.close()
                  DeliveryFranklin()
                  
                  
              elseif data.current.value == 'no' then
                   menu.close()
                  Takemoney()
                  ClearPedTasks(PlayerPedId())
                 
               
              end
          end,
          function(data, menu)
              menu.close()
              ClearPedTasks(PlayerPedId())
          end
      )
  end
  
  function LesterMenu()
       ESX.TriggerServerCallback('cooldown', function(cooldown)
                              print(cooldown)
      ESX.UI.Menu.CloseAll()
  
      ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'bike_menu',
          {
              title    = 'Lester',
              elements = {
                  {label = 'Fortsätt story', value = 'story'},
                  {label = 'Daily quest', value = 'daily'},
  
              }
          },
          function(data, menu)
              if data.current.value == 'story' then
                  ClearPedTasks(PlayerPedId())
                  ESX.ShowAdvancedNotification("Lester", "~g~Well-known", "I don't have something to do yet... Come back in a few days..", "CHAR_LESTER", 9) 
  
                  menu.close()
              elseif data.current.value == 'daily' and cooldown == 0 then
                  menu.close()
                  print("Starta dailyquest")
                  Citizen.Wait(5)
                  ESX.ShowAdvancedNotification("Lester", "~g~Well-known", "You're here to help me? Ooh, interesting.", "CHAR_LESTER", 9) 
                  Citizen.Wait(2000)
                  ESX.ShowAdvancedNotification("Lester", "~g~Well-known", "I got an idea, I need to know some information about Humane labs.", "CHAR_LESTER", 9) 
                  Citizen.Wait(5000)
                  ESX.ShowAdvancedNotification("Lester", "~g~Well-known", "I've heard they got something to hide. Get in to the lab, find a open laptop and hack it.", "CHAR_LESTER", 9) 
                  ESX.ShowAdvancedNotification("Lester", "~g~Well-known", "You'll have to search a bit, but I'm sure you'll find it. They are clumsy and wont expect you.", "CHAR_LESTER", 9) 
                  Citizen.Wait(5000)
                  ESX.ShowAdvancedNotification("Lester", "~g~Well-known", "If you fail, get the fuck outta there, before its over. Good luck.", "CHAR_LESTER", 9) 
                  Citizen.Wait(1000)
                  dailyquest()
                  TriggerServerEvent('addcooldown', 1440)
  
              else    
                  menu.close()
                  if cooldown/60 >= 1 then
                  ESX.ShowNotification('Det krävs ungefär '.. math.ceil(cooldown/60) ..' timmar aktivitet från dig innan du kan göra det igen.')
                  else
                  ESX.ShowNotification('Det krävs ungefär '.. cooldown ..' minuter aktivitet från dig innan du kan göra det igen.')
                  end
            
              end
          end,
          function(data, menu)
              menu.close()
              ClearPedTasks(PlayerPedId())
          end
      )
      end)
  end
  
  function DeliveryFranklin()
      local ped = GetPlayerPed(-1)
      SetNewWaypoint(-1919.00, -583.12)
  
      ClearPedTasks(PlayerPedId())
       while true do
          Citizen.Wait(100)
          if GetDistanceBetweenCoords(-1909.01, -581.22, 18.6, GetEntityCoords(PlayerPedId()), true) < 5.0 then
              ESX.ShowAdvancedNotification("Franklin", "~r~A Fresh Start", "Thank you man, I knew that I could trust you.", "CHAR_FRANKLIN", 9)
              TriggerServerEvent("InteractSound_SV:PlayOnSource", "missioncomplete", 1.0)
              ESX.Scaleform.ShowFreemodeMessage("A Fresh Start", "~g~Din tillit av Franklin ökade..", 10)
              TriggerServerEvent('updatequest', 1)
              DoingAnyQuest = false
              return
                        
          end
      end
  end
  
  function Takemoney()
      local ped = GetPlayerPed(-1)
      SetNewWaypoint(967.34, -1873.69)
      ClearPedTasks(PlayerPedId())
      DoingAnyQuest = true
  
       while true do
          Citizen.Wait(100)
          if GetDistanceBetweenCoords(967.34, -1873.69, 31.14, GetEntityCoords(PlayerPedId()), true) < 25.0 then
              ESX.ShowAdvancedNotification("Franklin", "~r~A Fresh Start", "Your piece of shit. You're as untrustworthy as Lamar.", "CHAR_FRANKLIN", 9)
              ESX.Scaleform.ShowFreemodeMessage("A Fresh Start", "~r~Du svek Franklin och han vill aldrig mer prata med dig..", 10)
              TriggerServerEvent('updatequest', 50)
              return
          end
       end
  end
  
  function RobTennisCoach()
      local MissionOngoing = true
      local Objective = "GOTO_TORG"
      local TorgCoords = {["x"] = -1176.14, ["y"] = -1639.18, ["z"] = 4.37}
      local NPC = nil
  
      Citizen.CreateThread(function()
  
  
          while MissionOngoing do
              Citizen.Wait(0)
  
              local ped = GetPlayerPed(-1)
              local coords = GetEntityCoords(ped)
  
          if Objective == "GOTO_TORG" then
                      drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Leta efter ~b~Kyle~w~ och ~r~råna~w~ honom..", 255, 255, 255, 255)
  
              
                          local model = -1573167273
  
                          RequestModel(model)
  
                          while not HasModelLoaded(model) do
                              Citizen.Wait(10)
                          end
  
                          NPC = CreatePed(5, model, -1176.14, -1639.18, 4.37, 24.0667, false, false)
                          TaskWanderStandard(NPC, 10.0, 10)
                          Objective = "KILL_NPC"
  
                          SetModelAsNoLongerNeeded(model)
                    
              elseif Objective == "KILL_NPC" then
  
                  drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Leta efter ~b~Kyle~w~ och ~r~råna~w~ honom..", 255, 255, 255, 255)
  
                  if NPC ~= nil and DoesEntityExist(NPC) then
                      DrawMarker(0, GetEntityCoords(NPC)["x"], GetEntityCoords(NPC)["y"], GetEntityCoords(NPC)["z"] + 1.4, 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 0, 232, 255, 155, 0, 0, 0, 1, 0, 0, 0)
  
                      if GetEntityHealth(NPC) <= 1.0 then
                          Objective = "STEAL_PHONE"
                      end
                  end
              elseif Objective == "STEAL_PHONE" then
                  drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Råna ~b~Kyle~w~.", 255, 255, 255, 255)
  
                  if GetDistanceBetweenCoords(coords["x"], coords["y"], coords["z"], GetEntityCoords(NPC)["x"], GetEntityCoords(NPC)["y"], GetEntityCoords(NPC)["z"], true) <= 1.5 then
                      draw3DText(GetEntityCoords(NPC)["x"], GetEntityCoords(NPC)["y"], GetEntityCoords(NPC)["z"] - 0.4, '~w~Tryck [~g~E~w~] för att plundra.', 4, 0.15, 0.15, 255, 255, 255, 255)
  
                      if IsControlJustPressed(0, 38) then
                  
                  RequestAnimDict('anim@gangops@facility@servers@bodysearch@')
  
                         TaskPlayAnim(GetPlayerPed(-1), 'anim@gangops@facility@servers@bodysearch@' ,'player_search' ,8.0, -8.0, -1, 0, 0, false, false, false )
                          Citizen.Wait(10000)
                                      ClearPedTasksImmediately(GetPlayerPed(-1))
                                      Objective = "GET_BACK"
  
                                      drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Åk tillbaka till Michael..", 255, 255, 255, 255)
  
  
                       end
              end
              elseif Objective == "GET_BACK" then
  
                  if GetDistanceBetweenCoords(-804.86, 173.17, 72.27, GetEntityCoords(PlayerPedId()), true) < 5.0 then
                      ESX.ShowAdvancedNotification("Michael", "~r~Be faithful", "That's a loyal dude. Thanks.", "CHAR_MICHAEL", 9)
                      Citizen.Wait(1000)
                      ESX.ShowAdvancedNotification("Michael", "~r~Be faithful", "Go back to Franklin, I'm sure he got something for you to help him out.", "CHAR_MICHAEL", 9)
                      TriggerServerEvent('updatequest', 3)
                  end
              end
          end
      end)
  end
  
  function GetExplosives()
      ESX.Game.SpawnVehicle("mule3", {x = 486.99, y = -3160.96, z = 6.07}, 3.98, function(car)
  
       ClearPedTasks(GetPlayerPed())
       ESX.ShowAdvancedNotification("Wade", "~r~White trash MCs", "I'll let you figure this out. Just steal the truck and then go. Dont stay, go! Understand?", "CHAR_WADE", 9)
       Citizen.Wait(1000)
       DestinationBlip = AddBlipForCoord(478.44, -3044.48, 6.09)
  
       SetBlipSprite(DestinationBlip, 478)
       SetBlipColour(DestinationBlip, 49)
       SetBlipAsShortRange(DestinationBlip, true)
       SetBlipRoute(DestinationBlip,  true)
       Citizen.Wait(10000)
       ESX.ShowAdvancedNotification("Wade", "~r~White trash MCs", "Just did some research. They will have huge weapons inside, get a safe car and change to the truck fast when you're there!", "CHAR_WADE", 9)
       Citizen.Wait(5000)
       ESX.ShowAdvancedNotification("Wade", "~r~White trash MCs", "I marked the location on the map.", "CHAR_WADE", 9)
          while true do
              Citizen.Wait(5)
              if IsPedInVehicle(PlayerPedId(), car) then
                  RemoveBlip(DestinationBlip)
                  while true do
                      Citizen.Wait(5)
                      DrawMarker(32, -1161.0, -1514.70, 4.48, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                      drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Fly platsen och levevera sprängmedlet till Wade", 255, 255, 255, 255)
                      if GetDistanceBetweenCoords(-1161.0, -1514.70, 4.48, GetEntityCoords(PlayerPedId()), true) < 2.0 then
                          TaskLeaveVehicle(PlayerPedId(), car, 0)
                          Citizen.Wait(5)
                          ClearPedTasks(PlayerPedId())
                          TriggerServerEvent('updatequest', 5)
                          ESX.ShowAdvancedNotification("Wade", "~r~White trash MCs", "Trevor is going to love this! Go meet Trevor outside Michaels garage!", "CHAR_WADE", 9)
                          TriggerServerEvent('addcooldown', 360)
                          break
                      end    
                  end        
              end   
          end
      end)
  end    
  
  function cutscenegarage()
    local holdingUp = false
    local timer = 200
    cutscene = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cutscene, -808.12, 188.64, 72.78)
    SetCamRot(cutscene, -10.0, 0.0, 110.39)
    SetCamActive(cutscene, true)
    RenderScriptCams(true, false, 0, 1, 0)
      
  
      ESX.Game.SpawnVehicle("hexer", {x = -812.50, y = 186.79, z = 72.47}, 287.51, function(hexer)
              trevor = CreatePed(3, -1686040670, -814.65, 184.24, 72.47, 314.71, false, false)
              TaskStartScenarioInPlace(trevor, "WORLD_HUMAN_AA_SMOKE", 0, true)
              SetEntityCoords(GetPlayerPed(-1), -816.16, 187.44, 72.48)
              SetEntityHeading(GetPlayerPed(-1), 256.12)
              TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_AA_SMOKE", 0, true)
              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "Wohooo! Finally, everything is reaady for laaaaunch!", "CHAR_TREVOR", 9)
              Citizen.Wait(5000)
              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "I've been working the whole night, this motorcycle is the best thing I've ever made!", "CHAR_TREVOR", 9)
              Citizen.Wait(5000)
              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "This are going to fuck up those white trash mc fuckers! Get this bike back where u took it.", "CHAR_TREVOR", 9)
              Citizen.Wait(5000)
              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "Hurry up! I might have set the timer for the C4 a bit low. What are you waiting for?! ", "CHAR_TREVOR", 9)
              Citizen.Wait(3000)
              DoScreenFadeOut(500)
              RenderScriptCams(false, false, 0, 1, 0)
              Citizen.Wait(1500)
              DoScreenFadeIn(500)
              ClearPedTasks(PlayerPedId())
              DoScreenFadeOut(500)
              DeleteVehicle(hexer)
              Citizen.Wait(1000)
              DoScreenFadeIn(1000) 
              explode()
      end)    
  end    
  
  local holdingUp = false
  
  function explode()
  local timer = 90
  holdingUp = true
  DrawMarker(32, 982.01, -109.92, 75.24, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
      ESX.Game.SpawnVehicle("hexer", {x = -812.50, y = 186.79, z = 72.47}, 287.51, function(hexer)
  
          Citizen.CreateThread(function()
              while timer > 0 and holdingUp do
                  Citizen.Wait(1000)
  
                  if timer > 0 then
                      timer = timer - 1
                  end
              end
          end)
  
          Citizen.CreateThread(function()
              while holdingUp do
                  Citizen.Wait(0)
                  drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, ('Timer: ' .. timer .. ' sekunder innan explosion.'), 255, 255, 255, 255)
                  if timer == 0 then
                      NetworkExplodeVehicle(hexer, true, true, 0)
                      print("Booom")
                      while holdingUp do
                          Citizen.Wait(5)
                          if GetDistanceBetweenCoords(GetEntityCoords(hexer, true), 982.56, -111.08, 74.24, true) < 5.0 and timer == 0 then
                              TriggerServerEvent('updatequest', 6)
                              ESX.ShowAdvancedNotification("Trevor", "~r~White trash MCs", "Wohooo! That was a close call!", "CHAR_TREVOR", 9)
                              Citizen.Wait(25000)
                              TriggerServerEvent("InteractSound_SV:PlayOnSource", "missioncomplete", 1.0)
                              ESX.Scaleform.ShowFreemodeMessage("~g~White trash MCs", "Din tillit av Trevor och Wade ökade...", 10)
                              Citizen.Wait(25000)
                              ESX.ShowAdvancedNotification("Lester", "~r~White trash MCs", "Hello, my name is Lester. Come meet me in my hideout.", "CHAR_LESTER", 9)
                              SetNewWaypoint(706.42, -963.09)
                              return
                          elseif timer == 0 then 	
                              print("Failed..")
                              ESX.Scaleform.ShowFreemodeMessage("~r~You failed.", "You failed the white trash MCs mission..", 10)
                              return
                          end	
                      end	
                  end	
              end
          end)
      end)	
  end
  
  
  
  function spawnLaptop()
      print("Spawnar laptopp")
      local safePos = Dailyquest.Laptoppos
      Objective = "HACK"
      if object == nil or object == 0 then
          ESX.Game.SpawnObject('prop_laptop_lester', safePos, function(safe)
              SetEntityHeading(safe, 260.16)
              FreezeEntityPosition(safe, true)
          end)
      end
  end
  
  function dailyquest()
  
      dailyquest = true
      spawnLaptop()
      SetNewWaypoint(3559.86, 3678.84)
      ClearPedTasks(PlayerPedId())
      Citizen.CreateThread(function()
          while dailyquest do
              Citizen.Wait(0)
              if Objective == "HACK" then
                  drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Åk till ~r~Humane Labs~w~ och få åtkomst till de hemliga filerna..", 255, 255, 255, 255)
                  if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 3563.03, 3678.0, 28.12, true) < 10.0 then
                      draw3DText(3563.06, 3678.14, 26.12, '~w~Tryck [~r~E~w~] för att ~r~hacka~w~.', 4, 0.06, 0.06, 255, 255, 255, 255)
                      if IsControlJustReleased(0, 38) then
                          SetEntityCoords(GetPlayerPed(-1), 3563.61, 3677.74, 28.12)
                          SetEntityHeading(GetPlayerPed(-1), 261.18)
                          RequestAnimDict("anim@gangops@morgue@office@laptop@")
                          Citizen.Wait(1000)
  
                          TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@morgue@office@laptop@" ,"enter" ,8.0, -8.0, -1, 1, 0, false, false, false )
                          Citizen.Wait(3000)
                          TriggerEvent("mhacking:show")
                          TriggerEvent("mhacking:start",7,Hacktime,mycb)
                          Citizen.Wait(8000)
                          TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@morgue@office@laptop@" ,"idle_usb" ,8.0, -8.0, -1, 1, 0, false, false, false )
                      end
                  end 
              end     
              if Objective == "KEMIKALIER" then   
                  drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Plocka med dig ~r~kemikalier~w~ till Lester", 255, 255, 255, 255)
                  if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 3559.17, 3672.27, 28.12, true) < 10.0 then
                      draw3DText(3559.17, 3672.27, 26.12, '~w~Tryck [~r~E~w~] för att ~r~sno~w~.', 4, 0.06, 0.06, 255, 255, 255, 255)
                      if IsControlJustReleased(0, 38) then
                          SetEntityCoords(GetPlayerPed(-1), 3558.74, 3672.47, 28.12)
                          SetEntityHeading(GetPlayerPed(-1), 350.77)
                          RequestAnimDict("anim@heists@ornate_bank@grab_cash_heels")
                          TaskPlayAnim(GetPlayerPed(-1), "anim@heists@ornate_bank@grab_cash_heels" ,"grab" ,8.0, -8.0, -1, 1, 0, false, false, false )
                          Wait(2000)
                          TaskPlayAnim(GetPlayerPed(-1), "anim@heists@ornate_bank@grab_cash_heels" ,"exit" ,8.0, -8.0, -1, 1, 0, false, false, false )
                          Wait(2000)
                          ClearPedTasksImmediately(GetPlayerPed(-1))
                          Objective = "GOTOLESTER"
                      end    
                  end
              end 
              if Objective == "GOTOLESTER" then 
                  drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Gå tillbaka till Lester.", 255, 255, 255, 255)
                  if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 706.96, -964.21, 30.41, true) < 10.0 then
                    TriggerServerEvent('dailyquest:reward')
                      return
                  end    
              end        
              if failed then 
                  ESX.ShowNotification('Du ~r~misslyckades~w~ med dagens quest..') 
                  return
              end          
          end        
      end)
  end	
  
  function round2(num, numDecimalPlaces)
      return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
  end
  
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
  
  function mycb(success, timeremaining)
    RequestAnimDict("anim@gangops@morgue@office@laptop@")
  
    print('yoyo you did it!')
          local playerPed = GetPlayerPed(-1)
          if success then
              ClearPedTasksImmediately(playerPed)
              TriggerEvent('mhacking:hide')
        hasCrackedSafe = true
        Citizen.Wait(300)
        TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@morgue@office@laptop@" ,"exit" ,8.0, -8.0, -1, 0, 0, false, false, false )
        hackingdone = true
        Objective = "KEMIKALIER"
          else
              ClearPedTasksImmediately(playerPed)
        TriggerEvent('mhacking:hide')
        Citizen.Wait(300)
        TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@morgue@office@laptop@" ,"exit" ,8.0, -8.0, -1, 0, 0, false, false, false )
        failed = true
          end
      end
  
      function activateBox(boxIndex)
      if boxIndex >= 1 and boxIndex <= 3 then
          disableBoxMarkers()
          Config.Lester.MissionFI.RewardBoxes[boxIndex].Type = 25
      end
  end
  
  function disableBoxMarkers()
      Config.Lester.MissionFI.RewardBoxes[1].Type = -1
      Config.Lester.MissionFI.RewardBoxes[2].Type = -1
      Config.Lester.MissionFI.RewardBoxes[3].Type = -1
  end
  
  function createRewardCamera()
      rewardCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
      --AttachCamToEntity(LesterCam, LesterPed, -1.0, 5.0, 1.0, true)
      SetCamCoord(rewardCam, Config.Lester.RewardCamPos.x, Config.Lester.RewardCamPos.y, Config.Lester.RewardCamPos.z)
      SetCamRot(rewardCam, -30.0, 0.0, 95.22)
      SetCamActive(rewardCam, true)
      RenderScriptCams(true, false, 0, 1, 0)
  end
  
  function destroyRewardCamera()
      RenderScriptCams(false, false, 0, 1, 0)
      DestroyCam(rewardCam, false)
  end
  
  function reward()
      Citizen.CreateThread(function()
          while ESX == nil do
              Citizen.Wait(10)
          end
  
          createRewardCamera()
          FreezeEntityPosition(GetPlayerPed(-1), true)
  
          local currentSelectedBox = 1
          local hasChosenBox = false
          local boxes = {}
  
          for i=1, 3 do
              local box = Config.Lester.MissionFI.RewardBoxes[i]
  
              ESX.Game.SpawnObject('prop_cs_heist_bag_01', box.Pos, function(tempBox)
                  boxes[i] = tempBox
              end)
          end
  
          Config.Lester.MissionFI.RewardBoxes[1].Type = 25
  
          while not hasChosenBox do
              Citizen.Wait(0)
  
              drawTxt(0.82, 0.604, 1.0, 1.0, 0.4, ('Välj valfri låda och klicka på Enter.'), 255, 255, 255, 255)
  
              if IsControlJustReleased(0, Keys['RIGHT']) then
                  if currentSelectedBox > 1 then 
                      currentSelectedBox = currentSelectedBox - 1
                  else
                      currentSelectedBox = 3
                  end
  
                  activateBox(currentSelectedBox)
              end
  
              if IsControlJustReleased(0, Keys['LEFT']) then
                  if currentSelectedBox < 3 then 
                      currentSelectedBox = currentSelectedBox + 1
                  else
                      currentSelectedBox = 1
                  end
  
                  activateBox(currentSelectedBox)
              end
  
              if IsControlJustReleased(0, Keys['ENTER']) then
              ClearPedTasks(PlayerPedId())
  
  
                  TriggerServerEvent('dailyquest:reward')
  
                  Citizen.Wait(500)
                  Objective = ""
  
                  for i = #boxes, 1, -1 do
                      DeleteEntity(boxes[i])
                  end
  
                  hasChosenBox = true
                  disableBoxMarkers()
                  destroyRewardCamera()
                  FreezeEntityPosition(GetPlayerPed(-1), false)
                  currentMissionState = MISSION_IDLE
              end
  
              for i=1, #Config.Lester.MissionFI.RewardBoxes do
                  local box = Config.Lester.MissionFI.RewardBoxes[i]
  
                  if box.Type ~= -1 then
                      DrawMarker(box.Type, box.Pos.x, box.Pos.y, box.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, box.Size.x, box.Size.y, box.Size.z, box.Color.r, box.Color.g, box.Color.b, 100, false, true, 2, false, false, false, false)
                  end
              end
          end
      end)
  end
  