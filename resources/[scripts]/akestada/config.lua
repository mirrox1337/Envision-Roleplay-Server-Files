Config = {
    ["ped"] = {
        ["name"] = "Åke",
        ["pos"] = vector3(-895.5, -778.19, 15.91),
        ["heading"] = 125.69,
        ["hash"] = "s_m_m_gardener_01",
        ["markerpos"] = vector3(-896.04, -778.58, 15.91)
    },

    ["cleaningPlaces"] = {
        ["leafBlowerPlaces"] = {
            vector3(-910.14, -716.94, 19.91), 
            vector3(-931.54, -732.25, 19.92),
            vector3(-950.41, -785.36, 15.92)
        },
    
        ["polishingPlaces"] = {
            vector3(-933.63, -784.15, 15.92),
            vector3(-891.58, -782.66, 15.91),
            vector3(-946.87, -713.58, 19.92)
        }
    },

    ["reward"] = math.random(250, 300)
}

Strings = {
    ["press_e"] = "~INPUT_CONTEXT~ Snacka med ",
    ["answer"] = "Vill du hjälpa " .. Config["ped"]["name"] .. "?\n~INPUT_FRONTEND_RDOWN~ Ja\n~INPUT_FRONTEND_RRIGHT~ Nej",
    ["press_e_leafblower"] = "~INPUT_CONTEXT~ Blås löv",
    ["press_e_polishing"] = "~INPUT_CONTEXT~ Putsa",
    ["Avbryt"] = "~INPUT_VEH_DUCK~ Avbryt"
}