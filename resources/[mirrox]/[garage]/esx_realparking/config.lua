--[[ ===================================================== ]]--
--[[         FiveM Real Parking Script by Akkariin         ]]--
--[[ ===================================================== ]]--

Config = {}

Config.UsingOldESX = true      -- If you are using ESX 1.2.0 or higher please leave this to false

Config.Locale = 'sv'

Config.ParkingLocations = {
	parking1 = {
		x      = -327.73,                               -- Central location X, Y, Z of the parking
		y      = -934.12,                               -- Y
		z      = 31.08,                                 -- Z
		size   = 50.0,                                  -- The parking range radius (Horizontal)
		height = 10.0,                                  -- The parking range radius (Vertical)
		name   = "Allmän Parkering",                      -- The name of the parking (blips)
		fee    = 30,                                  -- How much parking fee per day (Real life time), set 0 to disable
		enter  = {x = -279.25, y = -890.39, z = 30.08}, -- The entrance of the parking
		maxcar = 30,
	},
	parking2 = {
		x      = 283.27680,                               -- Central location X, Y, Z of the parking
		y      = -333.03030,                               -- Y
		z      = 43.91034,                                 -- Z
		size   = 17.8,                                  -- The parking range radius (Horizontal)
		height = 10.0,                                  -- The parking range radius (Vertical)
		name   = "Allmän Parkering",                      -- The name of the parking (blips)
		fee    = 24,                                  -- How much parking fee per day (Real life time), set 0 to disable
		enter  = {x = 273.62, y = -344.02, z = 44.93}, -- The entrance of the parking
		maxcar = 24,
	},
	parking3 = {
		x      = 1956.82,                               -- Central location X, Y, Z of the parking
		y      = 3769.66,                               -- Y
		z      = 31.83,                                 -- Z
		size   = 9.0,                                  -- The parking range radius (Horizontal)
		height = 10.0,                                  -- The parking range radius (Vertical)
		name   = "Allmän Parkering",                      -- The name of the parking (blips)
		fee    = 10,                                  -- How much parking fee per day (Real life time), set 0 to disable
		enter  = {x = 1941.81, y = 3765.03, z = 32.21}, -- The entrance of the parking
		maxcar = 8,
	},
	parking4 = {
		x      = -141.68,                               -- Central location X, Y, Z of the parking
		y      = 6354.09,                               -- Y
		z      = 31.49,                                 -- Z
		size   = 10.0,                                  -- The parking range radius (Horizontal)
		height = 10.0,                                  -- The parking range radius (Vertical)
		name   = "Allmän Parkering",                      -- The name of the parking (blips)
		fee    = 10,                                  -- How much parking fee per day (Real life time), set 0 to disable
		enter  = {x = -151.23690, y = 6349.04600, z = 30.55}, -- The entrance of the parking
		maxcar = 10,
	},
	parking5 = {
		x      = -3043.49,                               -- Central location X, Y, Z of the parking
		y      = 124.81,                               -- Y
		z      = 11.61,                                 -- Z
		size   = 20.0,                                  -- The parking range radius (Horizontal)
		height = 10.0,                                  -- The parking range radius (Vertical)
		name   = "Allmän Parkering",                      -- The name of the parking (blips)
		fee    = 24,                                  -- How much parking fee per day (Real life time), set 0 to disable
		enter  = {x = -3014.3, y = 108.08, z = 11.8}, -- The entrance of the parking
		maxcar = 30,
	},
	parking6 = {
		x      = -2029.33,                               -- Central location X, Y, Z of the parking
		y      = -468.63,                               -- Y
		z      = 11.39,                                 -- Z
		size   = 15.0,                                  -- The parking range radius (Horizontal)
		height = 10.0,                                  -- The parking range radius (Vertical)
		name   = "Allmän Parkering",                      -- The name of the parking (blips)
		fee    = 24,                                  -- How much parking fee per day (Real life time), set 0 to disable
		enter  = {x = -2029.37, y = -463.97, z = 11.45}, -- The entrance of the parking
		maxcar = 30,
	},
	parking7 = {
		x      = -584.38,                               -- Central location X, Y, Z of the parking
		y      = -1117.41,                               -- Y
		z      = 22.19,                                 -- Z
		size   = 20.0,                                  -- The parking range radius (Horizontal)
		height = 10.0,                                  -- The parking range radius (Vertical)
		name   = "Allmän Parkering",                      -- The name of the parking (blips)
		fee    = 24,                                  -- How much parking fee per day (Real life time), set 0 to disable
		enter  = {x = -556.31, y = -1106.62, z = 21.07}, -- The entrance of the parking
		maxcar = 15,
	},
	parking8 = {
		x      = -513.44,                               -- Central location X, Y, Z of the parking
		y      = 52.54,                               -- Y
		z      = 52.58,                                 -- Z
		size   = 25.0,                                  -- The parking range radius (Horizontal)
		height = 10.0,                                  -- The parking range radius (Vertical)
		name   = "Allmän Parkering",                      -- The name of the parking (blips)
		fee    = 30,                                  -- How much parking fee per day (Real life time), set 0 to disable
		enter  = {x = -540.15, y = 64.13, z = 52.59}, -- The entrance of the parking
		maxcar = 25,
	},
	parking9 = {
		x      = 324.24,                               -- Central location X, Y, Z of the parking
		y      = -2031.58,                               -- Y
		z      = 20.85,                                 -- Z
		size   = 10.0,                                  -- The parking range radius (Horizontal)
		height = 10.0,                                  -- The parking range radius (Vertical)
		name   = "Allmän Parkering",                      -- The name of the parking (blips)
		fee    = 30,                                  -- How much parking fee per day (Real life time), set 0 to disable
		enter  = {x = 298.91, y = -2015.42, z = 20.06}, -- The entrance of the parking
		maxcar = 20,
	},
}
