Config = {}

Config.Items = {
    {Label = 'Silverring', Name = 'ring'},
    {Label = 'Rolex', Name = 'rolex'},
    {Label = 'Använd dildo', Name = 'dildo'},
    {Label = 'Samsung laddare', Name = 'laddare'},
    {Label = 'iPod touch', Name = 'ipod'},
    {Label = 'kondom', Name = 'kondom'},
    {Label = '5g marijuana', Name = 'weed_pooch', Amount = 5},
    {Label = 'MP3 spelare', Name = 'mp3'},
    {Label = 'Nikon kamera', Name = 'systemkamera'},
} 

Config.GhettoPeds = { -- https://wiki.gt-mp.net/index.php/Peds
    588969535,
    -198252413,
    -1492432238,
    599294057
}

Config.GhettoPeds = { -- https://wiki.gt-mp.net/index.php/Peds
    588969535,
    -198252413,
    -1492432238,
    599294057
}

Config.GhettoWeapons = { -- vapen som npcer kan få
    "WEAPON_BAT",
    "WEAPON_PISTOL" 
}

Config.WeaponChance = 45 -- % att npcen får ett vapen 
--- Ghettot
Config.Burglary = {
    [1] = {
        Door = {Object = "v_ilev_fa_frontdoor", Coords = vector3(-14.36, -1441.58, 30.22), Frozen = true, Heading = 180.0, Health = 1000},
        Type = 'ghetto',
        Cops = 4,
        Peds = {
            vector3(-3.33, -1476.56, 29.66),
            vector3(-5.42,  -1480.09, 29.52),
            vector3(-41.93, -1450.68, 31.14)
        },
        MultipleSearch = {
            {Items = 5, Position = vector3(-17.85, -1432.38, 30.22), Heading = 331.55, Text = 'Sök igenom låda', Name = 'Byrå'},
            {Items = 2, Position = vector3(-14.87, -1440.19, 30.22), Heading = 93.55, Text = 'Sök igenom lucka', Name = 'Skåp'},
            {Items = 5, Position = vector3(-12.29, -1434.98, 30.22), Heading = 87.47, Text = 'Sök igenom del', Name = 'Hylla'},
            {Items = 2, Position = vector3(-9.36, -1434.79, 30.22), Heading = 215.48, Text = 'Sök igenom del', Name = 'Byrå'},
            {Items = 1, Position = vector3(-18.4, -1440.59, 30.22), Heading = 100.32, Text = 'Sök igenom låda', Name = 'Nattduksbord'},
        },
    },
--- Vid gymmet
    [2] = {
        Door = {Object = 'v_ilev_trev_doorfront', Coords = vector3(-1150.14, -1521.71, 9.75), Frozen = true, Heading = 35.0, Health = 1000},
        Type = 'city',
        Cops = 4,
        MultipleSearch = {
            {Items = 3, Position = vector3(-1147.57, -1511.07, 9.75), Heading = 34.56, Text = 'Sök igenom låda', Name = 'Nattduksbord'},
            {Items = 3, Position = vector3(-1149.87, -1512.61, 9.75), Heading = 37.75, Text = 'Sök igenom låda', Name = 'Nattduksbord'},
            {Items = 7, Position = vector3(-1158.12, -1518.2, 9.75), Heading = 37.85, Text = 'Sök igenom del', Name = 'Hylla'},
            {Items = 10, Position = vector3(-1155.52, -1523.76, 9.75), Heading = 216.29, Text = 'Sök igenom del', Name = 'Hylla'},
        },
    },
--- Trevors sunkiga vagn 
    [3] = {
        Door = {Object = 'v_ilev_trevtraildr', Coords = vector3(1972.7689, 3815.3659, 33.6632), Frozen = true, Heading = 29.0, Health = 1000},
      Type = 'ghetto',
        Cops = 4,
        Peds = {
            vector3(1981.79, 3818.35, 32.38),
            vector3(1982.14,  3815.7, 32.38),
            vector3(1977.43, 3815.23, 33.43)
    },
    MultipleSearch = {
        {Items = 3, Position = vector3(1978.34, 3819.76, 33.54), Heading = 270.2, Text = 'Sök igenom låda', Name = 'Lådor'},
        {Items = 3, Position = vector3(1969.13, 3817.64, 33.52), Heading = 22.42, Text = 'Sök igenom låda', Name = 'Nattduksbord'},
        {Items = 5, Position = vector3(1969.14, 3814.82, 33.43), Heading = 125.09, Text = 'Sök igenom del', Name = 'Garderob'},
        {Items = 5, Position = vector3(1970.24, 3815.11, 33.43), Heading = 214.14, Text = 'Sök igenom del', Name = 'Byrå'},
    },
},
--- Janitor vid mekonomen
    [4] = {
        Door = {Object = 'v_ilev_janitor_frontdoor', Coords = vector3(-107.5373, -9.0180, 70.670), Frozen = true, Heading = 70.0, Health = 1000},
        Type = 'city',
        Cops = 4,
        MultipleSearch = {
            {Items = 5, Position = vector3(-113.61, -12.45, 70.52), Heading = 122.59, Text = 'Sök igenom låda', Name = 'Tv-byrå'},
            {Items = 5, Position = vector3(-112.13, -7.72, 70.52), Heading = 90.5, Text = 'Sök igenom låda', Name = 'Kökslåda'},
            {Items = 3, Position = vector3(-110.63, -14.76, 70.52), Heading = 141.68, Text = 'Sök igenom del', Name = 'Walk-in Closet'},
            {Items = 3, Position = vector3(-109.14, -10.16, 70.52), Heading = 247.54, Text = 'Sök igenom del', Name = 'Låda'},
        },
    },
-- Tequi LA LA
    [5] = {
        Door = {Object = 'v_ilev_roc_door2', Coords = vector3(-569.7971, 293.7700, 79.3264), Frozen = true, Heading = -95.0, Health = 1000},
        Type = 'city',
        Cops = 4,
        MultipleSearch = {
            {Items = 2, Position = vector3(-572.5, 286.43, 79.18), Heading = 176.24, Text = 'Sök igenom låda', Name = 'Bord'},
            {Items = 7, Position = vector3(-576.08, 291.36, 79.18), Heading = 92.99, Text = 'Sök igenom låda', Name = 'Lådor'},
            {Items = 2, Position = vector3(-576.06, 287.07, 79.18), Heading = 150.06, Text = 'Sök igenom del', Name = 'Bord'},
            {Items = 1, Position = vector3(-571.14, 290.67, 79.18), Heading = 255.72, Text = 'Sök igenom del', Name = 'Sopptunna'},
        },
    },
    [6] = {
        Door = {Object = 'v_ilev_mm_doorw', Coords = vector3(-809.28088, 177.85536, 76.890327), Frozen = true, Heading = 200.0, Health = 1000},
        Type = 'city',
        Cops = 4,
        MultipleSearch = {
            {Items = 5, Position = vector3(-811.37, 181.17, 76.74), Heading = 333.93, Text = 'Sök igenom låda', Name = 'Sminkbyrå'},
            {Items = 5, Position = vector3(-815.73, 180.97, 76.75), Heading = 21.6, Text = 'Sök igenom låda', Name = 'Nattduksbord'},
            {Items = 5, Position = vector3(-811.87, 175.06, 76.75), Heading = 294.89, Text = 'Sök igenom del', Name = 'Walk-in Closet'},
            {Items = 5, Position = vector3(-812.38, 177.9, 76.74), Heading = 203.39, Text = 'Sök igenom del', Name = 'Bord'},
        },
    },
}