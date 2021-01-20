Config = {
    Price = 1000,
    ReviveTime = 30, -- seconds until you are revived
    Hospitals = {
        {
            Bed = {coords = vector3(255.84, -1352.3, 25.52), heading = 317.0, occupied = false},
            Peds = {
                pedHash = -730659924,
                reception = {coords = vector3(312.36, -592.85, 42.30), heading = 340.0},
                doctor = {coords = vector3(255.2, -1351.74, 23.55), heading = 232.59},
            },
        },
    },
}

Strings = {
    ['get_help'] = [[Tryck %s för att få hjälp,kostar ~g~$%s]],
    ['not_enough'] = [[Du har inte nog med pengar]],
    ['getting_help'] = [[Du blir omvårdad, %s sekunder kvar!]],
    ['occupied'] = [[Sängen är upptagen! Kom tillbaka senare]]
}