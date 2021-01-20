Config = {
    blip = vector3(-211.84, -1322.85, 30.89),

    ["locations"] = {

        ["cloakroom"] = {
            text = "~INPUT_CONTEXT~ Öppna omklädningsrummet",
            coords = vector3(-205.58, -1329.94, 34.89),
            r = 0, g = 150, b = 255,
            sizeX = 0.8, sizeY = 0.8, sizeZ = 0.8
        },

        ["storage"]= { 
            text = "~INPUT_CONTEXT~ Öppna förråd",
            coords = vector3(-227.96, -1333.31, 30.89),
            r = 0, g = 150, b = 255,
            sizeX = 0.8, sizeY = 0.8, sizeZ = 0.8
        },

        ["billing"]= {
            text = "~INPUT_CONTEXT~ Ge faktura till närmsta person",
            coords = vector3(-205.80, -1342.64, 30.89),
            r = 0, g = 150, b = 255,
            sizeX = 0.8, sizeY = 0.8, sizeZ = 0.8
        },

        ["bossmeny"]= {
            text = "~INPUT_CONTEXT~ Logga in på datorn",
            coords = vector3(-203.70, -1342.59, 30.89),
            r = 0, g = 150, b = 255,
            sizeX = 0.8, sizeY = 0.8, sizeZ = 0.8
        }
    },


    ["clothes"] = {
        [1] = {
            label = "Bennys",
            clothe = {
                male = {
                    ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                    ['torso_1'] = 241, ['torso_2'] = 2,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 0,
                    ['pants_1'] = 98, ['pants_2'] = 24,
                    ['shoes_1'] = 71, ['shoes_2'] = 24,
                    ['helmet_1'] = -1, ['helmet_2'] = 8,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                    ['ears_1'] = -1, ['ears_2'] = 0,
                    ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    ['mask_1'] = 0, ['mask'] = 0
                },
                female = {
                    ['tshirt_1'] = 6, ['tshirt_2'] = 0,
                    ['torso_1'] = 249, ['torso_2'] = 4,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 14,
                    ['pants_1'] = 100, ['pants_2'] = 24,
                    ['shoes_1'] = 73, ['shoes_2'] = 24,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                    ['ears_1'] = -1, ['ears_2'] = 0,
                    ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    ['mask_1'] = 0, ['mask'] = 0
                }
            }
        }
    },
    
    ["Inkopning"] = {
        ["Items"] = {
            { label = "Metalldel", item = "metalldel", price = 150 },
            { label = "Färgpatron", item = "fargpatron", price = 140 },
            { label = "Turbo", item = "turbo", price = 750 }
        }
    }
}

Strings = {
    ["blipName"] = "Bennys",
    ["notboss"] = "Du är inte chef över detta företag.",
    ["waitforyourturn"] = "Vänta tills din tur."
}
