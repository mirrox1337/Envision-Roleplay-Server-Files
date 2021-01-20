Config = {}

Config.Locale = 'sv'
Config.OpenControl = 289
Config.TrunkOpenControl = 47
Config.DeleteDropsOnStart = true
Config.HotKeyCooldown = 500
Config.CheckLicense = true

Config.Shops = {
    ['Sjukhus Kiosken'] = {
        coords = {
            vector3(335.19, -585.38, 28.8),
        },
        items = {
            { name = "bread", price = 25, count = 1 },
            { name = "korv", price = 35, count = 1 },
            { name = "donut", price = 20, count = 1 },
            { name = "choklad", price = 12, count = 1 },
            { name = "cola", price = 20, count = 1 },
            { name = "water", price = 25, count = 1 },
        },
        blipSprite = 52,
        blipColour = 4,
        markerType = 29,
        markerColour = { r = 92, g = 184, b = 92 },
        enableBlip = false,
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att handla på ~g~Sjukhus Kiosken~s~',
        job = 'ambulance'
    },
    ['7-Eleven'] = {
        coords = {
            vector3(373.875, 325.896, 103.666),
            vector3(2557.458, 382.282, 108.722),
            vector3(-3038.939, 585.954, 8.008),
            vector3(-3241.927, 1001.462, 12.950),
            vector3(547.431, 2671.710, 42.256),
            vector3(1961.464, 3740.672, 32.443),
            vector3(2678.916, 3280.671, 55.341),
            vector3(1729.14, 6414.29, 35.137),
            vector3(25.84, -1347.5, 29.5),
        },
        items = {
            { name = "cocacola", price = 21, count = 1 },
            { name = "fanta", price = 21, count = 1 },
            { name = "sprite", price = 21, count = 1 },
            { name = "loka", price = 21, count = 1 },
            { name = "cheesebows", price = 25, count = 1 },
            { name = "chips", price = 25, count = 1 },
            { name = "marabou", price = 27, count = 1 },
            { name = "pizza", price = 35, count = 1 },
            { name = "burger", price = 50, count = 1 },
            { name = "pastacarbonara", price = 30, count = 1 },
            { name = "cigaretter", price = 55, count = 1 },
            { name = "snusdosa", price = 40, count = 1 },
            { name = "lighter", price = 30, count = 1 },
            { name = "scratchoff", price = 150, count = 1 },
            { name = "phone", price = 450, count = 1 },
            { name = "saffron", price = 16, count = 1 },
            { name = "lithium", price = 800, count = 1 },
            { name = "jumelles", price = 500, count = 1 },
            { name = "pan", price = 400, count = 1 },
            { name = "blackplasticbag", price = 10, count = 1 },
        },
        blipSprite = 52,
        blipColour = 15,
        markerType = 29,
        markerColour = { r = 92, g = 184, b = 92 },
        msg = '~INPUT_CONTEXT~ för att handla på ~g~7-Eleven~s~',
        enableBlip = true,
        job = 'all'
    },
    ['Systembolaget'] = {
        coords = {
            vector3(1135.808, -982.281, 46.420),
            vector3(-1223.10, -906.75, 12.345),
            vector3(-1487.553, -379.107, 40.225),
            vector3(-2968.243, 390.910, 15.073),
            vector3(1166.024, 2708.930, 38.170),
            vector3(1392.562, 3604.684, 35.0),
            vector3(-1393.409, -606.624, 30.330),
            vector3(-559.906, 287.093, 82.180),
        },
        items = {
            { name = "martini", price = 40, count = 1 },
            { name = "jager", price = 40, count = 1 },
            { name = "rhum", price = 55, count = 1 },
            { name = "tequila", price = 55, count = 1 },
            { name = "vodka", price = 50, count = 1 },
            { name = "whisky", price = 70, count = 1 },
        },
        blipSprite = 93,
        blipColour = 69,
        markerType = 29,
        markerColour = { r = 92, g = 184, b = 92 },
        msg = '~INPUT_CONTEXT~ för att handla på ~g~Systembolaget~s~',
        enableBlip = true,
        job = 'nightclub'
    },
    ['Macken'] = {
        coords = {
            vector3(-48.519, -1757.514, 29.521),
            vector3(1163.373, -323.801, 69.305),
            vector3(-707.501, -914.260, 19.315),
            vector3(-1820.523, 792.518, 138.218),
            vector3(1698.388, 4924.404, 42.163),
        },
        items = {
            { name = "cocacola", price = 21, count = 1 },
            { name = "fanta", price = 21, count = 1 },
            { name = "sprite", price = 21, count = 1 },
            { name = "loka", price = 21, count = 1 },
            { name = "cheesebows", price = 25, count = 1 },
            { name = "chips", price = 25, count = 1 },
            { name = "marabou", price = 27, count = 1 },
            { name = "pizza", price = 35, count = 1 },
            { name = "burger", price = 50, count = 1 },
            { name = "pastacarbonara", price = 30, count = 1 },
            { name = "cigaretter", price = 55, count = 1 },
            { name = "snusdosa", price = 40, count = 1 },
            { name = "lighter", price = 30, count = 1 },
            { name = "scratchoff", price = 150, count = 1 },
            { name = "phone", price = 450, count = 1 },
            --{ name = "saffron", price = 16, count = 1 },
            --{ name = "lithium", price = 800, count = 1 },
            --{ name = "jumelles", price = 500, count = 1 },
            --{ name = "pan", price = 400, count = 1 },
            --{ name = "blackplasticbag", price = 10, count = 1 },
        },
        blipSprite = 361,
        blipColour = 63,
        markerType = 29,
        markerColour = { r = 92, g = 184, b = 92 },
        msg = '~INPUT_CONTEXT~ för att handla på ~g~Macken~s~',
        enableBlip = true,
        job = 'all'
    },
}

Config.Stash = {
    ['Polis Förråd'] = {
        coords = vector3(461.17, -982.5, 30.79),
        size = vector3(1.0, 0.1, 1.0),
        job = 'police',
        markerType = 21,
        markerColour = { r = 66, g = 139, b = 202 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~Förråd~s~'
    },
    ['Sjukvård Förråd'] = {
        coords = vector3(306.32, -601.39, 43.28),
        size = vector3(1.0, 0.1, 1.0),
        job = 'ambulance',
        markerType = 21,
        markerColour = { r = 255, g = 0, b = 0 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~Förråd~s~'
    },
    ['Mekonomen Förråd'] = {
        coords = vector3(-350.34, -124.34, 39.010),
        size = vector3(1.0, 0.1, 1.0),
        job = 'mekaniker',
        markerType = 21,
        markerColour = { r = 255, g = 237, b = 0 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~Förråd~s~'
    },
    ['Bennys Förråd'] = {
        coords = vector3(-224.21, -1320.18, 30.95),
        size = vector3(1.0, 0.1, 1.0),
        job = 'bennys',
        markerType = 21,
        markerColour = { r = 66, g = 139, b = 202 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~Förråd~s~'
    },
    ['Bilcenter'] = {
        coords = vector3(-30.92, -1110.84, 26.50),
        size = vector3(1.0, 0.1, 1.0),
        job = 'cardealer',
        markerType = 21,
        markerColour = { r = 66, g = 139, b = 202 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~Förråd~s~'
    },
	['Hades'] = {
        coords = vector3(-1616.01, -3015.40, -75.10),
        size = vector3(1.0, 0.1, 1.0),
        job = 'nightclub',
        markerType = 21,
        markerColour = { r = 66, g = 139, b = 202 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~Förråd~s~'
    },
	['Försäkringbolaget'] = {
        coords = vector3(-150.02, -634.42, 168.82),
        size = vector3(1.0, 0.1, 1.0),
        job = 'forsakring',
        markerType = 21,
        markerColour = { r = 66, g = 139, b = 202 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~Förråd~s~'
    },
    ['Securitas'] = {
        coords = vector3(-1052.69, -230.93, 39.20),
        size = vector3(1.0, 0.1, 1.0),
        job = 'Securitas',
        markerType = 21,
        markerColour = { r = 66, g = 139, b = 202 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~Förråd~s~'
    },
    ['Polis Beslag'] = {
        coords = vector3(473.8, -1005.02, 24.02),
        size = vector3(1.0, 0.1, 1.0),
        job = 'police',
        markerType = 21,
        markerColour = { r = 66, g = 139, b = 202 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~beslaget~s~'
    },
    ['Räddningstjänsten'] = {
        coords = vector3(199.14, -1649.91, 29.8),
        size = vector3(1.0, 0.1, 1.0),
        job = 'raddningstjansten',
        markerType = 21,
        markerColour = { r = 200, g = 0, b = 0 },
        rotate = true,
        msg = '~INPUT_CONTEXT~ för att öppna ~g~förrådet~s~'
    }
}

Config.Steal = {
    black_money = true,
    cash = true
}

Config.Seize = {
    black_money = true,
    cash = true
}

Config.VehicleLimit = {
    ['Zentorno'] = 10,
    ['Panto'] = 1,
    ['Zion'] = 5
}

--Courtesy DoctorTwitch
Config.VehicleSlot = {
    [0] = 10, --Compact
    [1] = 15, --Sedan
    [2] = 20, --SUV
    [3] = 15, --Coupes
    [4] = 5, --Muscle
    [5] = 5, --Sports Classics
    [6] = 5, --Sports
    [7] = 0, --Super
    [8] = 5, --Motorcycles
    [9] = 10, --Off-road
    [10] = 20, --Industrial
    [11] = 20, --Utility
    [12] = 30, --Vans
    [13] = 0, --Cycles
    [14] = 0, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 20, --Service
    [18] = 20, --Emergency
    [19] = 90, --Military
    [20] = 0, --Commercial
    [21] = 0 --Trains
}

Config.Throwables = {
    WEAPON_MOLOTOV = 615608432,
    WEAPON_GRENADE = -1813897027,
    WEAPON_STICKYBOMB = 741814745,
    WEAPON_PROXMINE = -1420407917,
    WEAPON_SMOKEGRENADE = -37975472,
    WEAPON_PIPEBOMB = -1169823560,
    WEAPON_SNOWBALL = 126349499
}

Config.FuelCan = 883325847