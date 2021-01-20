Config = {

    ["locations"] = {

        ["cloakroom"] = {
            text = "~INPUT_CONTEXT~ Öppna omklädningsrummet",
            coords = vector3(895.49, -178.36, 74.7),
            r = 255, g = 250, b = 1,
            sizeX = 0.8, sizeY = 0.8, sizeZ = 0.8
        },

        ["storage"]= {
            text = "~INPUT_CONTEXT~ Öppna förråd",
            coords = vector3(894.51, -179.85, 74.7),
            r = 255, g = 250, b = 1,
            sizeX = 0.8, sizeY = 0.8, sizeZ = 0.8
        },

        ["boss"]= {
            text = "~INPUT_CONTEXT~ Öppna chefmenyn",
            coords = vector3(892.3, -181.77, 74.7),
            r = 255, g = 250, b = 1,
            sizeX = 0.8, sizeY = 0.8, sizeZ = 0.8
        },

        ["garage"] = {
            text = "~INPUT_CONTEXT~ Öppna garagemenyn",
            coords = vector3(909.62, -185.13, 74.12),
            spawn = vector3(904.95, -185.28, 73.49),
            heading = 59.62,
            cam = vector3(904.19, -180.59, 75.04),
            r = 255, g = 250, b = 1,
            sizeX = 0.8, sizeY = 0.8, sizeZ = 0.8
        },

        ["removeVehicle"] = {
            text = "~INPUT_CONTEXT~ Parkera fordon",
            coords = vector3(906.95, -186.28, 74.0),
            r = 255, g = 0, b = 0,
            sizeX = 2.5, sizeY = 2.5, sizeZ = 2.5,
            range = 2
        }
    },

    ["vehicles"] = {
        { ["model"] = "gle450", ["label"] = "Taxibil" },
        { ["model"] = "stretch", ["label"] = "Limo" }
    },

    ["clothes"] = {
        [1] = {
            label = "Taxichaufför",
            clothe = {
                male = {
                    ['tshirt_1'] = 7, ['tshirt_2'] = 2,
                    ['torso_1'] = 120, ['torso_2'] = 2,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 37,
                    ['pants_1'] = 60, ['pants_2'] = 2,
                    ['shoes_1'] = 21, ['shoes_2'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 1,
                    ['ears_1'] = -1, ['ears_2'] = 0,
                    ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    ['mask_1'] = 0, ['mask'] = 0
                },
                female = {
                    ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                    ['torso_1'] = 49, ['torso_2'] = 1,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 14,
                    ['pants_1'] = 27, ['pants_2'] = 0,
                    ['shoes_1'] = 7, ['shoes_2'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                    ['ears_1'] = -1, ['ears_2'] = 0,
                    ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    ['mask_1'] = 0, ['mask'] = 0
                }
            }
        }
    },

    pedLocations = {
        { coords = vector3(291.27, 179.12, 104.3) },
        { coords = vector3(-217.86, -504.85, 34.74) },
        { coords = vector3(358.14, -869.15, 29.29) }
    },

    peds = {
        { hash = "g_m_y_mexgoon_03" },
        { hash = "ig_michelle" },
        { hash = "u_m_y_paparazzi" },
    },

    leavePositions = {
        { coords = vector3(329.19, -203.17, 54.09) },
        { coords = vector3(-1087.44, -1501.11, 4.99) },
        { coords = vector3(-845.02, 460.21, 87.81) },
    }
}

Strings = {
    ["blipName"] = "Taxi",
    ["notboss"] = "Du är inte chef över detta företag.",
    ["waitforyourturn"] = "Vänta tills din tur."
}
