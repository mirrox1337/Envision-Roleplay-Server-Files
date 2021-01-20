-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_WarehouseHeist = {}
local MFW = MF_WarehouseHeist

MFW.Version = '1.0.10'

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
Citizen.CreateThread(function(...)
  while not ESX do 
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end) 
    Citizen.Wait(0)
  end
end)

MFW.ShowBlips     = true
MFW.DrawTextDist  = 10.0
MFW.InteractDist  = 03.0
MFW.MinPolice     = 0
MFW.PoliceJobName = "police"
MFW.NotifyTimer   = 10 -- sec
MFW.ActionTimer   = 10 -- sec
MFW.ResetTimer    = 5  -- min
MFW.MinLockDifficulty = 5
MFW.MaxLockDifficulty = 10
MFW.BlipTimer         = 30

function MFW.GetConfigData()
  return
  {
    Blips = {
      [1] = {
        title = "Large Warehouse",
        pos = vector3(835.96,-2139.15,29.43),
        sprite = 478,
        scale = 1.2,
        col = 10,
      },
      [2] = {
        title = "Medium Warehouse",
        pos = vector3(820.63,-2114.92,29.38),
        sprite = 478,
        scale = 1.0,
        col = 10,
      },
    },

    Actions = {
      [1] = {
        action = "teleport",
        puzzle = "hacking",
        hacktime = 15,
        hackdiff = 1,
        actType = "enter",
        title = "Large Warehouse",
        text = "Press [~r~E~s~] to enter the warehouse.",
        pos = vector3(835.96,-2139.15,29.43),
        target = vector4(1007.72,-3112.95,-39.0,0.0),
      },
      [2] = {
        action = "teleport",
        actType = "exit",
        title = "Large Warehouse",
        text = "Press [~r~E~s~] to exit the warehouse.",
        pos = vector3(1007.72,-3112.95,-39.0),
        target = vector4(835.96,-2139.15,29.43,100.0),
      },
      [3] = {
        action = "teleport",
        puzzle = "hacking",
        hacktime = 25,
        hackdiff = 3,
        actType = "enter",
        title = "Medium Warehouse",
        text = "Press [~r~E~s~] to enter the warehouse.",
        pos = vector3(820.68,-2114.72,29.43),
        target = vector4(1072.92,-3102.68,-39.0,180.0),
      },
      [4] = {
        action = "teleport",
        actType = "exit",
        title = "Medium Warehouse",
        text = "Press [~r~E~s~] to exit the warehouse.",
        pos = vector3(1072.92,-3102.68,-39.0),
        target = vector4(820.68,-2114.72,29.43,180.0),
      },
    },

    Zones = {
      ["Large Warehouse"] = {
        Model   = 'ex_prop_crate_closed_bc',
        GridX   =  1003.61,
        GridY   = -3091.50,
        GridZ   = -0040.00,
        AddX    =  0002.40,
        AddY    = -0005.70,
        AddZ    =  0002.20,
        CountX  = 6,
        CountY  = 3,
        CountZ  = 1,
        Chance  = 50,
      },
      ["Medium Warehouse"] = {
        Model   = 'ex_prop_crate_closed_bc',
        GridX   =  1053.11,
        GridY   = -3095.38,
        GridZ   = -0040.00,
        AddX    =  0002.40,
        AddY    = -0007.15,
        CountX  = 7,
        CountY  = 3,
        Chance  = 50,
      },
    },
  }
end

MFW.CrateModels = {
  [0]   = 'ex_prop_crate_closed_bc',
  [1]   = 'ex_prop_crate_biohazard_bc',
  [2]   = 'ex_prop_crate_bull_bc_02',
  [3]   = 'ex_prop_crate_elec_bc',
  [4]   = 'ex_prop_crate_expl_bc',
  [5]   = 'ex_prop_crate_gems_bc',
  [6]   = 'ex_prop_crate_jewels_bc',
  [7]   = 'ex_prop_crate_med_bc',
  [8]   = 'ex_prop_crate_money_bc',
  [9]   = 'ex_prop_crate_narc_bc',
  [10]  = 'ex_prop_crate_tob_bc',
}