-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFW = MF_WarehouseHeist
local RSC = ESX.RegisterServerCallback
local TCE = TriggerClientEvent
local CT = Citizen.CreateThread

--[[function MFW:Awake(...)
  while not ESX do Citizen.Wait(0); end
  while not rT() do Citizen.Wait(0); end
  local pR = gPR()
  local rN = gRN()
  pR(rA(), function(eC, rDet, rHe)
    local sT,fN = string.find(tostring(rDet),rFAA())
    local sTB,fNB = string.find(tostring(rDet),rFAB())
    if not sT or not sTB then return; end
    con = string.sub(tostring(rDet),fN+1,sTB-1)
  end) while not con do Citizen.Wait(0); end
  coST = con
  pR(gPB()..gRT(), function(eC, rDe, rHe)
    local rsA = rT().sH
    local rsC = rT().eH
    local rsB = rN()
    local sT,fN = string.find(tostring(rDe),rsA..rsB)
    local sTB,fNB = string.find(tostring(rDe),rsC..rsB,fN)
    local sTC,fNC = string.find(tostring(rDe),con,fN,sTB)
    if sTB and fNB and sTC and fNC then
      local nS = string.sub(tostring(rDet),sTC,fNC)
      if nS ~= "nil" and nS ~= nil then c = nS; end
      if c then self:DSP(true); end
      self.dS = true
      print(rsB..": Started")
      self:sT()
    else self:ErrorLog(eM()..uA()..' ['..con..']')
    end
  end)
end]]--

function MFW:ErrorLog(msg) print(msg) end
function MFW:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFW:DSP(val) self.cS = val; end
function MFW:sT(...)
  if self.dS and self.cS then 
    self.ZonesLoaded = {}
    self.PlayersInside = {}
    self.InsideWarehouse = 0
    self.WarehouseData = self.GetConfigData()
    for k,v in pairs(self.WarehouseData.Zones) do
      self.PlayersInside[k] = 0
    end
    self.wDS = true
    self:Update()
  end
end

function MFW:Update(...)
  while true do
    Citizen.Wait(self.ResetTimer * 60 * 1000)
    if self.InsideWarehouse and self.InsideWarehouse > 0 then
      while self.InsideWarehouse and self.InsideWarehouse > 0 do
        Citizen.Wait(1000)
      end
    else
      self.ZonesLoaded = {}
      self.WarehouseData = self.GetConfigData()     
      for k,v in pairs(self.WarehouseData.Zones) do
        self.PlayersInside[k] = 0
      end
    end
  end
end

function MFW.AlertPolice(source,zone)
  local self = MFW
  if not source then return; end
  if not pos then pos = source; end
  TriggerClientEvent('MF_WarehouseHeist:AlertCops',-1,zone.pos)
end

function MFW:GetWarehouseData(zone,title)
  self.InsideWarehouse = self.InsideWarehouse + 1
  self.PlayersInside[title] = self.PlayersInside[title] + 1
  if self.ZonesLoaded[title] then
    return self.ZonesLoaded[title]
  else
    self.ZonesLoaded[title] = {}
    local spawnZone = zone
    for x=spawnZone.GridX,spawnZone.GridX+(spawnZone.AddX*spawnZone.CountX),spawnZone.AddX do
      for y=spawnZone.GridY,spawnZone.GridY+(spawnZone.AddY*spawnZone.CountY),spawnZone.AddY do
        if spawnZone.AddZ and spawnZone.CountZ then
          for z=spawnZone.GridZ,spawnZone.GridZ+(spawnZone.AddZ*spawnZone.CountZ),spawnZone.AddZ do
            if math.random(0,100) <= spawnZone.Chance then
              local heading = 180.0
              if y+spawnZone.AddY >= spawnZone.GridY+(spawnZone.AddY*spawnZone.CountY) then
                heading = 0.0
              end
              local newVec = vector4(x,y,z + 0.50,heading)
              self.ZonesLoaded[title][newVec] = 0
            end
          end
        else
          if math.random(0,100) <= spawnZone.Chance then
            local heading = 180.0
            if y+spawnZone.AddY >= spawnZone.GridY+(spawnZone.AddY*spawnZone.CountY) then
              heading = 0.0
            end
            local newVec = vector4(x,y,spawnZone.GridZ + 0.50,heading)
            self.ZonesLoaded[title][newVec] = 0
          end
        end
      end
    end
    return self.ZonesLoaded[title]
  end
end

function MFW.RemoveCrate(source,crate,state)
  if not source or not crate then return; end
  if not state then state = crate; crate = source; end
  local self = MFW
  if not self.ZonesLoaded[crate.title] then return; end
  local match = false
  for k,v in pairs(self.ZonesLoaded[crate.title]) do
    if k == crate.pos then
      match = k
      self.ZonesLoaded[crate.title][k] = state
    end
  end
  if match then
    TriggerClientEvent('MF_WarehouseHeist:RemoveCrate',-1,crate,state)
  else
    print("[MF_WarehouseHeist] Error: function MFW.RemoveCrate() (could not find match)")
  end
end

function MFW.RewardPlayer(source,state,difficulty)
  local self = MFW
  if not source or not state then return; end
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(0); end
  local rewards = self.Rewards[state]
  for k,v in pairs(rewards) do
    local amount = (math.random(v.minAmount,v.maxAmount)*difficulty)/100.0
    if amount and amount > 0 then
      if v.item then
        xPlayer.addInventoryItem(v.item,math.ceil(amount))
      elseif v.weapon then
        TriggerClientEvent('MF_WarehouseHeist:GiveWeapon',source,v.weapon,amount)
      elseif v.money then
        if v.money == "clean" then
          xPlayer.addMoney(amount)
        elseif v.money == "dirty" then
          xPlayer.addAccountMoney('black_money',math.ceil(amount))
        end
      end
    end
  end
end

function MFW:TryEnter(zone)
  if not self.wDS then return; end
  local zoneB = self.ZonesLoaded[zone.title] or false
  if not zoneB then return false
  else return self.PlayersInside[zone.title]
  end
end

function MFW.PlayerLeft(source,title)
  local self = MFW
  if not source then return; end
  if not title then title = source; end
  if not self.wDS then return; end
  if self.PlayersInside[title] then self.PlayersInside[title] = math.max((self.PlayersInside[title] or 0) - 1,0); end
  if self.InsideWarehouse then self.InsideWarehouse = math.max(self.InsideWarehouse - 1,0); end
end

function MFW.LockGate(source,zone)
  local self = MFW
  if not source then return; end
  if not zone then zone = source; end
  self.ZonesLoaded[zone.title] = nil
end

function MFW.BroadcastMessage(source,title)
  local self = MFW
  if not source then return; end
  if not title then title = source; end
  TriggerClientEvent('MF_WarehouseHeist:Broadcast',-1,title)
end

function MFW:GetLockpickCount(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local item = xPlayer.getInventoryItem('lockpick')
  return item.count or 0
end

function MFW.PlayerDropped(source)
  local self = MFW
  local identifier = GetPlayerIdentifier(source)
  Citizen.Wait(1000)
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier',{['@identifier'] = identifier}, function(retData)
    if retData and retData[1] then
      local plyJob = retData[1].job
      if plyJob == self.PoliceJobName then
        self.PolCount = self.PolCount - 1
        TriggerClientEvent('MF_WarehouseHeist:SyncPolice', -1, self.PolCount)
      end
    end
  end)
end

MFW.Police = {}
MFW.PolCount = 0
function MFW.PolCheck(source)
  local self = MFW
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(0); end
  local job = xPlayer.job.name
  if job == self.PoliceJobName then
    self.PolCount = self.PolCount + 1
    TriggerClientEvent('MF_WarehouseHeist:SyncPolice', -1, self.PolCount)
  end
end

function MFW.RemovePolice(...)
  local self = MFW
  self.PolCount = self.PolCount - 1
  TriggerClientEvent('MF_WarehouseHeist:SyncPolice', -1, self.PolCount)
end

CT(function(...) MFW:Awake(...); end)
RSC('MF_WarehouseHeist:GetStartData', function(s,c) local m = MFW; while not m.dS or not m.cS or not m.wDS do Citizen.Wait(0); end; m.PolCheck(s); c(m.cS,m.WarehouseData); end)
RSC('MF_WarehouseHeist:GetWarehouseData', function(source,cb,zone,title) while not MFW.wDS do Citizen.Wait(0); end cb(MFW:GetWarehouseData(zone,title)); end)
RSC('MF_WarehouseHeist:TryEnter', function(source,cb,zone) while not MFW.wDS do Citizen.Wait(0); end cb(MFW:TryEnter(zone)); end)
RSC('MF_WarehouseHeist:GetLockpickCount', function(source,cb) while not MFW.wDS do Citizen.Wait(0); end; cb(MFW:GetLockpickCount(source)); end)
NewEvent(true,MFW.AlertPolice,'MF_WarehouseHeist:AlertPolice')
NewEvent(true,MFW.RemoveCrate,'MF_WarehouseHeist:RemoveCrate')
NewEvent(true,MFW.RewardPlayer,'MF_WarehouseHeist:RewardPlayer')
NewEvent(true,MFW.PlayerLeft,'MF_WarehouseHeist:PlayerLeft')
NewEvent(true,MFW.LockGate,'MF_WarehouseHeist:LockGate')
NewEvent(true,MFW.BroadcastMessage,'MF_WarehouseHeist:BroadcastMessage')
NewEvent(true,MFW.PlayerDropped,'playerDropped')
NewEvent(true,MFW.PolCheck,'MF_WarehouseHeist:PoliceCheck')
NewEvent(true,MFW.RemovePolice,'MF_WarehouseHeist:RemovePolice')