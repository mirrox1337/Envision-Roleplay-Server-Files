Config = {} -- DON'T TOUCH

Config.DrawDistance       = 100.0 -- Change the distance before you can see the marker. Less is better performance.
Config.EnableBlips        = false -- Set to false to disable blips.
Config.MarkerType         = -1    -- Change to -1 to disable marker.
Config.MarkerColor        = { r = 255, g = 0, b = 0 } -- Change the marker color.

Config.Locale             = 'en' -- Change the language. Currently available (en or fr).
Config.CooldownMinutes    = 60 -- Minutes between chopping.

Config.CallCops           = true -- Set to true if you want cops to be alerted when chopping is in progress
Config.CallCopsPercent    = 1 -- (min1) if 1 then cops will be called every time=100%, 2=50%, 3=33%, 4=25%, 5=20%.
Config.CopsRequired       = 4

Config.NPCEnable          = true -- Set to false to disable NPC Ped at shop location.
Config.NPCHash			      = 68070371 --Hash of the npc ped. Change only if you know what you are doing.
Config.NPCShop	          = { x = -1032.96, y = 678.96, z = 155.75, h = 31.1 } -- Location of the shop For the npc.

Config.GiveBlack          = true -- Wanna use Blackmoney?

-- Change the time it takes to open door then to break them.
-- Time in Seconde. 1000 = 1 seconde
Config.DoorOpenFrontLeftTime      = 7000
Config.DoorBrokenFrontLeftTime    = 7000
Config.DoorOpenFrontRightTime     = 7000
Config.DoorBrokenFrontRightTime   = 7000
Config.DoorOpenRearLeftTime       = 7000
Config.DoorBrokenRearLeftTime     = 7000
Config.DoorOpenRearRightTime      = 7000
Config.DoorBrokenRearRightTime    = 7000
Config.DoorOpenHoodTime           = 7000
Config.DoorBrokenHoodTime         = 7000
Config.DoorOpenTrunkTime          = 7000
Config.DoorBrokenTrunkTime        = 7000
Config.DeletingVehicleTime        = 7000

Config.Zones = {
    Chopshop = {coords = vector3(133.69, -3216.78, 5.26), name = _U('map_blip'), color = 49, sprite = 225, radius = 100.0, Pos = { x = 133.69, y = -3216.78, z = 5.26 }, Size  = { x = 5.0, y = 5.0, z = 0.5 }, },
    Shop = {coords = vector3(-1032.96, 678.96, 155.75), name = _U('map_blip_shop'), color = 50, sprite = 120, radius = 25.0, Pos = { x = -1032.96, y = 678.96, z = 155.75 }, Size  = { x = 3.0, y = 3.0, z = 1.0 }, },
}

Config.Items = {
    "battery",
    "lowradio",
    "stockrim",
    "airbag",
    "highradio",
    "highrim"
}

Config.Itemsprice = {
    battery = 301,
    lowradio = 49,
    highradio = 300,
    stockrim = 650,
    highrim = 1600,
    airbag = 62
}

