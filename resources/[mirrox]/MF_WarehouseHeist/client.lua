-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFW = MF_WarehouseHeist
local TSC = ESX.TriggerServerCallback
local TSE = TriggerServerEvent
local CT = Citizen.CreateThread

MFW.ZonesLoaded = {}
MFW.SpawnedObjects = {}

function MFW:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    self.PlayerData = ESX.GetPlayerData()
    self.PoliceOnline = 0
    TSC('MF_WarehouseHeist:GetStartData', function(retVal,retTab) self.dS = true; self.cS = retVal; self:Start(retTab); end)
end

function MFW:Start(tab)
  self.WarehouseData = tab or {}
  if self.ShowBlips then self:DoBlips(); end
  if self.dS and self.cS then self:Update(); end
end

function MFW:DoBlips(...)
  for k,v in pairs(self.WarehouseData.Blips) do   
    local blip = AddBlipForCoord(v.pos.x,v.pos.y,v.pos.z)
    SetBlipSprite               (blip, v.sprite)
    SetBlipDisplay              (blip, 3)
    SetBlipScale                (blip, v.scale)
    SetBlipColour               (blip, v.col)
    SetBlipAsShortRange         (blip, false)
    SetBlipHighDetail           (blip, true)
    BeginTextCommandSetBlipName ("STRING")
    AddTextComponentString      (v.title)
    EndTextCommandSetBlipName   (blip)
  end
end 

function MFW:Update(...)
  local lastKey = GetGameTimer()
  while true do
    Citizen.Wait(0)
    local plyPed = GetPlayerPed(-1)
    local plyPos = GetEntityCoords(plyPed)
    local closest,closestDist = self:GetClosestAction(plyPos)
    if closestDist and closestDist < self.DrawTextDist and not self.DoingAction then
      Utils.DrawText3D(closest.pos.x,closest.pos.y,closest.pos.z+0.3,closest.text)
      if closestDist < self.InteractDist and IsControlJustReleased(0,38) and (GetGameTimer() - lastKey) > 150 then
        lastKey = GetGameTimer()
        if self.PoliceOnline >= self.MinPolice or closest.actType == "exit" then
          self:DoAction(closest)
          self.PolText = false
          self.PolCheck = false
        else
          ESX.ShowNotification("There aren't enough police online to perform this action.")
        end
      end

      if self.PlayerData.job and self.PlayerData.job.name == self.PoliceJobName then
        if closest.actType and closest.actType == 'enter' then
          Utils.DrawText3D(closest.pos.x,closest.pos.y,closest.pos.z+0.2,self.PolText or "Press [~r~G~s~] to check the gate.")
          if closestDist < self.InteractDist and IsControlJustReleased(0, 47) and (GetGameTimer() - lastKey) > 150 then
            lastKey = GetGameTimer()
            if not self.PolCheck then 
              self:LockGate(closest)
            else
              self:BroadcastMessage(closest)
            end
          end
        end
      end
    else
      self.PolText = false
      self.PolCheck = false
    end
  end
end

function MFW:LockGate(closest)
  ESX.TriggerServerCallback('MF_WarehouseHeist:TryEnter', function(isOpen)
    if isOpen then
      if isOpen <= 0 then
        ESX.ShowNotification("You locked the opened gate. Somebody must have been here.")
        TriggerServerEvent('MF_WarehouseHeist:LockGate',closest)
      else
        ESX.ShowNotification("The security system has been hacked. Somebody must be robbing the warehouse.")
        self.PolText = "Press [~r~G~s~] to broadcast police message inside."
        self.PolCheck = true
      end
    else
      ESX.ShowNotification("The gate is locked.")
    end
  end,closest)
end

function MFW:BroadcastMessage(closest)
  ESX.ShowNotification("Message broadcasted.")
  TriggerServerEvent('MF_WarehouseHeist:BroadcastMessage',closest.title)
  self.PolCheck = false
  self.PolText = false
end

function MFW:GetClosestAction(pos)
  local closest,closestDist
  for k,v in pairs(self.WarehouseData.Actions) do
    local dist = Utils.GetVecDist(pos,v.pos)
    if not closestDist or dist < closestDist then
      closest = v
      closestDist = dist
    end
  end
  if closestDist then 
    return closest,closestDist 
  else 
    return false,99999999
  end
end

function MFW:DoAction(closest)
  if closest.action == "teleport" then
    if closest.actType == "enter" then
      ESX.TriggerServerCallback('MF_WarehouseHeist:TryEnter', function(isOpen)
        if isOpen then
          self:TeleportPlayer(closest.target.xyz, closest.target.w)
          self:LoadZone(closest.title)
          self:ScreenFade(true,1000,1000) 
        else
          local doWait = false
          if closest.puzzle then
            doWait = true
            self.DoingAction = closest
            if closest.puzzle == "hacking" then
              self.DoingHack = true
              TriggerEvent("mhacking:show")
              TriggerEvent("mhacking:start",closest.hackdiff,closest.hacktime,self.HackingCb)
            end
          end

          if doWait then
            while self.DoingAction do Citizen.Wait(0); end
            if self.ActionResult then
              self.ActionResult = false
              self:TeleportPlayer(closest.target.xyz, closest.target.w)
              self:LoadZone(closest.title)
              self:ScreenFade(true,1000,1000) 
              self.CurrentZone = closest
            else
              ESX.ShowNotification("You triggered the security alarm.")
              TriggerServerEvent('MF_WarehouseHeist:AlertPolice',closest)
            end
          else
            self:TeleportPlayer(closest.target.xyz, closest.target.w)  
            self:LoadZone(closest.title) 
            self:ScreenFade(true,1000,1000)   
          end
        end
      end, closest)
    else
      self:TeleportPlayer(closest.target.xyz, closest.target.w) 
      self:ScreenFade(true,1000,1000)  
      self.ZonesLoaded[closest.title] = false
      self:UnloadZone()
      self.CurrentZone = false
      TriggerServerEvent('MF_WarehouseHeist:PlayerLeft',closest.title) 
    end
  elseif closest.action == "loot" then
    local doWait = false
    if closest.puzzle then
      if closest.puzzle == "lockpicking" then
        ESX.TriggerServerCallback('MF_LockPicking:GetLockpickCount', function(count)
          if count and count > 0 then
            doWait = true
            self.DoingAction = closest
            self.ActionResult = false
            local lockPins = math.random(self.MinLockDifficulty,self.MaxLockDifficulty)
            local multiplier = lockPins * 10
            self.DoingLockpick = true
            TriggerEvent('MF_LockPicking:StartMinigame',lockDifficulty)
            if doWait then
              while self.DoingAction do Citizen.Wait(0); end
              if self.ActionResult and self.ActionResult == true or self.ActionResult == "true" then
                local state = math.random(1,#self.CrateModels)
                TriggerServerEvent('MF_WarehouseHeist:RemoveCrate',closest,state)
                local plyPed = GetPlayerPed(-1)
                TaskTurnPedToFaceEntity(plyPed, closest.pos, -1)
                Citizen.Wait(1000)
                exports['progressBars']:startUI(self.ActionTimer * 1000, "Looting")
                TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
                Wait(self.ActionTimer * 1000)
                TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, false)
                Wait(1000)
                ClearPedTasksImmediately(plyPed)
                TriggerServerEvent('MF_WarehouseHeist:RewardPlayer',state,multiplier)
              else
                ESX.ShowNotification("You triggered the security alarm.")
                TriggerServerEvent('MF_WarehouseHeist:AlertPolice',self.CurrentZone or closest.pos)
              end
            end
          else
            ESX.ShowNotification("You don't have enough lockpicks.")
          end
        end)
      end
    end    
  end
end

function MFW:FinishLockpick(result)
  if not self.DoingLockpick then return; end
  self.DoingLockpick = false
  self.ActionResult = result or false
  self.DoingAction = false
end

function MFW.HackingCb(success)
  local self = MFW
  if not self.DoingHack then return; end
  self.DoingHack = false
  TriggerEvent('mhacking:hide')
  self.DoingAction = false
  self.ActionResult = success or false
end

function MFW:TeleportPlayer(pos,heading)
  self:ScreenFade(false,1000,1000)
  local plyPed = GetPlayerPed(-1)
  SetEntityCoordsNoOffset(plyPed, pos.x,pos.y,pos.z, false,false,false)
  SetEntityHeading(plyPed,heading)
end 

function MFW:LoadZone(title)
  if self.ZonesLoaded[title] then return; end
  self.ZonesLoaded[title] = {}
  TSC('MF_WarehouseHeist:GetWarehouseData',function(data)
    self.ZonesLoaded[title] = data

    for k,v in pairs(self.CrateModels) do
      local hashKey = GetHashKey(v)
      while not HasModelLoaded(hashKey) do RequestModel(hashKey); Citizen.Wait(0); end
    end
    for k,v in pairs(data) do
      local hashKey = GetHashKey(self.CrateModels[v])
      local heading = 0.0
      if k.w then heading = k.w; end
      local newVector = vector4(k.x,k.y,k.z,heading)
      local newObj = CreateObject(hashKey,k.x,k.y,k.z-0.5,false,false,false)
      SetEntityHeading(newObj,heading)
      if v == 0 then
        table.insert(self.WarehouseData.Actions,{
          action = "loot",
          puzzle = "lockpicking",
          text = "Press [~r~E~s~] to try and lockpick the crate.",
          pos = newVector,
          title = title,
          obj = newObj,
        })
        table.insert(self.SpawnedObjects,newObj)
      end
    end

    for k,v in pairs(self.CrateModels) do
      local hashKey = GetHashKey(v)
      SetModelAsNoLongerNeeded(hashKey)
    end
  end,self.WarehouseData.Zones[title],title)
end

function MFW:UnloadZone(...)
  for k,v in pairs(self.WarehouseData.Actions) do
    if v.obj then
      SetEntityAsMissionEntity(v.obj,true,true)
      DeleteObject(v.obj)
      self.WarehouseData.Actions[k].obj = nil
    end
  end
end

function MFW:ScreenFade(fadeIn,wait,time)
  local bufferTime = 500
  if fadeIn then
    Citizen.Wait(bufferTime)
    DoScreenFadeIn(time or 1000)
    if wait then
      Citizen.Wait(wait)
    end
  else
    DoScreenFadeOut(time or 1000)
    if wait then
      Citizen.Wait(wait + bufferTime)
    else
      Citizen.Wait(bufferTime)
    end
  end
end

function MFW.AlertCops(source,pos)
  local self = MFW
  if not source then return; end
  if not pos then pos = source; end
  if self.PlayerData.job and self.PlayerData.job.name == self.PoliceJobName then
    ESX.ShowNotification("Somebody triggered a warehouse alarm. [~g~LEFTALT~s~]")
    CT(function(...)
      local startTime = GetGameTimer()
      local blip = AddBlipForCoord(pos.x,pos.y,pos.z)
      SetBlipSprite (blip, 161)
      SetBlipScale  (blip, 2.0)
      SetBlipColour (blip, 3)
      BeginTextCommandSetBlipName ("STRING")
      AddTextComponentString      ("Warehouse Alarm")
      EndTextCommandSetBlipName   (blip)

      while GetGameTimer() - startTime < self.NotifyTimer * 1000 do
        Citizen.Wait(0)
        if IsControlJustReleased(0,19) then
          SetNewWaypoint(pos.x,pos.y)
        end
      end
      while GetGameTimer() - startTime < (self.BlipTimer * 1000) - (self.NotifyTimer * 1000)  do
        Citizen.Wait(0)
      end

      RemoveBlip(blip)
    end)
  end
end

function MFW.SetJob(source,job)
  local self = MFW
  if not source then return; end
  if not job then job = source; end
  if self.PlayerData.job.name == self.PoliceJobName and job.name ~= self.PoliceJobName then
    TriggerServerEvent('MF_WarehouseHeist:RemovePolice')
  end

  self.PlayerData.job = job
  if self.PlayerData.job.name == self.PoliceJobName then
    TriggerServerEvent('MF_WarehouseHeist:PoliceCheck')
  end
end

function MFW.RemoveCrate(source,crate,state)
  local self = MFW
  if not source or not crate then return; end
  if not state then state = crate; crate = source; end
  local didDel = false
  for k,v in pairs(self.WarehouseData.Actions) do
    if v.pos == crate.pos and v.obj then
      self.WarehouseData.Actions[k] = nil

      local hash = GetHashKey(self.CrateModels[state])
      while not HasModelLoaded(hash) do RequestModel(hash); Citizen.Wait(0); end

      Citizen.Wait(self.ActionTimer * 1000 + 2000)
      SetEntityAsMissionEntity(v.obj,true,true)
      DeleteObject(v.obj)
      didDel = true
      Citizen.Wait(0)

      local newObj = CreateObject(hash, v.pos.x, v.pos.y, v.pos.z - 0.5, false,false,false)
      SetEntityHeading(newObj,v.pos.w)
      Citizen.Wait(0)

      table.insert(self.SpawnedObjects,newObj)
      SetModelAsNoLongerNeeded(hash)
    end
  end
end

function MFW.Broadcast(source,title)
  local self = MFW
  if not source then return; end
  if not title then title = source; end
  if self.CurrentZone and self.CurrentZone.title and self.CurrentZone.title == title then
    local play = math.random(1,100)
    if play >= 90 then 
      TriggerEvent('InteractSound_CL:PlayOnOne','warehousealert',1.0)
    else
      TriggerEvent('InteractSound_CL:PlayOnOne','warehousealert2',1.0) 
    end
  end
end

function MFW.GiveWeapon(source,weapon,amount)
  local self = MFW
  if not source or not weapon then return; end
  if not amount then amount = weapon; weapon = source; end
  GiveWeaponToPed(GetPlayerPed(-1),GetHashKey(weapon),math.max(1,math.floor(amount)),true,true)
end

function MFW.SyncCops(_,count)
  local self = MFW
  if not _ then return; end
  if not count then count = _; end
  self.PoliceOnline = count;
end

CT(function(...) MFW:Awake(...); end)
AddEventHandler('MF_LockPicking:MinigameComplete', function(res) MFW:FinishLockpick(res); end)
NewEvent(true,MFW.AlertCops,'MF_WarehouseHeist:AlertCops')
NewEvent(true,MFW.RemoveCrate,'MF_WarehouseHeist:RemoveCrate')
NewEvent(true,MFW.Broadcast,'MF_WarehouseHeist:Broadcast')
NewEvent(true,MFW.GiveWeapon,'MF_WarehouseHeist:GiveWeapon')
NewEvent(true,MFW.SetJob,'esx:setJob')
NewEvent(true,MFW.SyncCops,'MF_WarehouseHeist:SyncPolice')