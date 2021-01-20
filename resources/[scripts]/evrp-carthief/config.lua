Config = {
    DaysBetween = 2, -- dagar mellan varje bilstöld / spelare
    ServerCooldown = 600, -- minuter mellan varje bilstöld (serverbaserat, restart = reset)
    PedHash = -573920724, -- https://wiki.gtanet.work/index.php?title=Peds
    BlipTimer = 1000, -- hur många (sekunder) blipen ska visas för poliser
    PoliceRequired = 5,    
    Soundfile = 'name.ogg', 
    SoundfileLength = 5, -- längd i sekunder för ljudfilen

    Name = 'Hans',
    StartMission = {
        coords = vector3(1665.78, 4966.58, 41.34),
        heading = 45.88,
        CamCoord = vector3(1658.51, 4967.16, 44.81),
    },

    Vehicle = {
        name = 'rs7',
        label = 'Sportbil',
        spawnlocations = {
            {coords = vector3(9.55, -1767.16, 28.89), heading = 50.94},
        },
        arrivelocations = {
            {coords = vector3(174.55, 484.66, 141.69), heading = 173.15},
        },
    },

    Reward = {
        Money = {8000,13000 }, -- {min, max}
        Weapons = {
            --scriptet läger automatiskt till weapon_
            {Title = 'Baseballträ', Weapon = 'weapon_bat'},
        },
    },
}