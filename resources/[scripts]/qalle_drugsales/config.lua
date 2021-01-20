Config = {}

Config.Debug = false
Config.AlignMenu = "right" -- this is where the menu is located [left, right, center, top-right, top-left etc.]

Config.Peds = {
    `a_m_o_beach_01`,
    `s_m_o_busker_01`,
    `a_m_y_cyclist_01`,
    `s_m_y_dealer_01`,
    `a_m_y_downtown_01`,
    `a_m_y_eastsa_02`,
    `a_m_y_beachvesp_01`,
    `u_m_y_burgerdrug_01`,
    `a_f_y_eastsa_03`,
    `csb_fos_rep`,
    `a_m_y_genstreet_01`,
    `a_m_y_genstreet_02`,
    `a_m_y_gay_01`,
    `a_m_y_gay_02`,
    `s_m_m_gardener_01`,
    `ig_lifeinvad_01`,
    `s_m_m_lifeinvad_01`,
    `u_m_y_paparazzi`,
    `a_m_m_polynesian_01`,
    `a_m_y_polynesian_01`,
    `a_f_o_salton_01`,
    `a_f_m_salton_01`,
    `s_f_y_shop_low`,
    `a_f_y_skater_01`,
    `a_f_y_tourist_02`,
    `a_m_m_tranvest_02`,
    `a_f_m_trampbeac_01`,
    `a_f_m_tramp_01`,
    `a_m_m_tramp_01`,
    `a_m_o_tramp_01`,
    `a_f_y_rurmeth_01`
}

Config.DrugLocations = {
    ["gathering"] = {
        {
            ["pos"] = vector3(1430.1312255859, -1032.2531738281, 53.484523773193),
            ["item"] = "bread",
            ["label"] = "Plocka %s.",
            ["police"] = 1
        },
        {
            ["pos"] = vector3(1427.4406738281, -1034.2756347656, 53.447364807129),
            ["item"] = "water",
            ["label"] = "Plocka %s.",
            ["police"] = 2
        }
    },
    ["mixing"] = {
        {
            ["pos"] = vector3(1423.5122070313, -1037.3262939453, 53.394145965576),
            ["item"] = "dildo",
            ["label"] = "Blanda droger till %s.",
            ["police"] = 2
        }
    },
    ["packeting"] = {
        {
            ["pos"] = vector3(1417.0594482422, -1041.3052978516, 53.318294525146),
            ["item"] = "marijuanaseed",
            ["label"] = "Packetera droger till %s.",
            ["police"] = 2
        }
    }
}

Config.PedSpawnCooldown = 90000

Config.RandomOffer = { 100, 300 }
Config.RandomAmount = { 1, 5 }

Config.SellItem = "joint"

Config.AreaRadius = 35.0
Config.SellAreas = {
    vector3(-176.27769470215, -1675.5572509766, 33.26106262207),
    vector3(89.232482910156, -206.29396057129, 54.486618041992),
    vector3(-540.13897705078, 251.08599853516, 83.05859375),
    vector3(-41.492069244385, -120.7862701416, 57.625373840332),
    vector3(237.94323730469, -868.22406005859, 30.29225730896),
    vector3(-318.84536743164, -1471.0235595703, 30.548303604126),
    vector3(-1176.5596923828, -1511.4770507813, 4.2908391952515),
    vector3(-1631.9702148438, -996.67901611328, 13.017386436462),
    vector3(3.1486234664917, -1605.2435302734, 29.275897979736),
    vector3(-74.089408874512, -1763.62109375, 29.453956604004),
    vector3(164.54751586914, -1729.0065917969, 29.291688919067),
    vector3(319.83044433594, -2024.9024658203, 20.707204818726),
    vector3(1141.3953857422, -644.08624267578, 56.761302947998),
    vector3(1321.4112548828, -1626.3513183594, 52.182415008545)
}