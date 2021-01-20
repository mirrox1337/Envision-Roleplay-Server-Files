Config = {}

Config.WorkoutTimer = 50000 -- Seconds
Config.RestTimer = 65000 -- Seconds
Config.MaxWorkOuts = 20 -- Times Per Relog

Config.BlipCoords = vector3(-1203.9791259766, -1563.5516357422, 4.6118173599243)

Config.WorkOuts = {
    ["Situps"] = {
        ["Pos"] = vector3(-1204.8524169922, -1560.6760253906, 4.6137747764587),
        ["Animation"] = {
            ["dict"] = "amb@world_human_sit_ups@male@base", 
            ["anim"] = "base"
        }
    },

    ["Pushups"] = {
        ["Pos"] = vector3(-1200.6102294922, -1564.2153320313, 4.6168413162231),
        ["Animation"] = {
            ["dict"] = "amb@world_human_push_ups@male@base", 
            ["anim"] = "base"
        }
    },
    
    ["Chinups"] = {
        ["Pos"] = vector3(-1200.0920410156, -1571.0336914063, 4.6094970703125),
        ["Heading"] = 215.0,
        ["Scenario"] = "PROP_HUMAN_MUSCLE_CHIN_UPS"
    },

    ["Bänkpress"] = {
        ["Pos"] = vector3(-1198.1165771484, -1568.3089599609, 4.7599725723267 - 0.680),
        ["Heading"] = 305.0,
        ["Scenario"] = "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS"
    },

    ["Vikter"] = {
        ["Pos"] = vector3(-1209.1546630859, -1559.25, 4.6080508232117),
        ["Scenario"] = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"
    },

    ["Yoga"] = {
        ["Pos"] = vector3(-1205.1761474609, -1566.2497558594, 4.607928276062),
        ["Scenario"] = "WORLD_HUMAN_YOGA"
    },

    ["Jogga"] = {
        ["Pos"] = vector3(-1201.7346191406, -1568.6796875, 4.6094903945923),
        ["Scenario"] = "WORLD_HUMAN_JOG_STANDING"
    },

    ["Omklädningsrum"] = {
        ["Pos"] = vector3(-1195.2882080078, -1577.3707275391, 4.6057205200195),
        ["usable"] = true
    }
}