
-- Racing configuration, edit this to add or change races
races = {
    {
        title = "Nürburg-Ring",                                                             -- Race title
        isEnabled = true,                                                          -- Enable the race
        showWaypoints = false,                                                      -- Set GPS waypoints, waypoint will always be set to next checkpoint + 1
        checkpointRadius = 10.0,                                                    -- Radius of checkpoint
        checkpointTransparency = 1.0,                                               -- Checkpoint transparancy
        mapBlipId = 315,                                                            -- Map blip ID
        mapBlipColor = 5,                                                           -- Map blip color
        start = { x = 3706.45, y = -6521.47, z = 2190.89, heading = 139.0, type = 5 },     -- Starting race coordinates (/saveRaceStart)
        checkpoints = {                                                             -- Checkpoints and finish line
            { x = 3228.53, y = -6902.0, z = 2177.71, heading = 337.8, type = 5 },         -- Race checkpoints, type 5 is a normal checkpoint (/saveRaceCp)
            { x = 3144.91, y = -6752.9, z = 2178.89, heading = 104.28, type = 5 },
            { x = 3141.75, y = -6969.53, z = 2177.84, heading = 170.96, type = 5 },
            { x = 3069.63, y = -7342.92, z = 2170.93, heading = 222.82, type = 5 },
            { x = 3150.81, y = -7478.94, z = 2160.04, heading = 117.58, type = 5 },
            { x = 2746.02, y = -7807.98, z = 2136.03, heading = 42.32, type = 5 },
            { x = 2962.37, y = -7470.19, z = 2157.93, heading = 12.23, type = 5 },
            { x = 3010.2, y = -6944.8, z = 2177.78, heading = 68.83, type = 5 },
            { x = 2891.3, y = -6854.45, z = 2173.73, heading = 354.07, type = 5 },
            { x = 3147.38, y = -6527.73, z = 2159.4, heading = 298.86, type = 5 },
            { x = 3641.25, y = -6340.02, z = 2183.59, heading = 305.00, type = 5 },
            { x = 3706.45, y = -6521.47, z = 2190.89, heading = 139.0, type = 9 },
            -- Race checkpoints, type 9 is a finish line (/saveRaceEnd)         
        }
    }
}
