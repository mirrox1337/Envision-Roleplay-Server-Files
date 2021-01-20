Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 0, g = 0, b = 255 }
Config.MarkerSize                 = { x = 1.0, y = 1.0, z = 1.0 }
Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = false -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders
Config.Locale                     = 'sv'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 10 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 60 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(341.0, -1397.3, 32.5), heading = 48.5 }

Config.Blip = {
	Pos     = { x = 310.66, y = -587.39, z = 42.29 },
	Sprite  = 61,
	Display = 4,
	Scale   = 0.8,
	Colour  = 2
}

Config.HelicopterSpawner = {
	["SpawnPoint"] = { ["x"] = 351.40487670898, ["y"] = -587.63360595703, ["z"] = 74.165641784668, ["h"] = 247.3874206543 },
	--SpawnPoint = { x = 313.33, y = -1465.2, z = 45.5 },
	--Heading    = 0.0
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {  
	


	{
	
		label = 'Volvo Ambulans',
		model = 'ambulance',
	},
	{
	
		label = 'Volvo v90 akutbil',
		model = 'ambulance2',
	},
	
}




Config.Zones = {

	Upstairs = { -- Huvudentré
	
		Pos	= { ["x"] = 332.67, ["y"] = -569.65, ["z"] = 42.4, ["h"] = 341.60504150391 },
		Type = 25
	},

	Roof = { -- Taket
		Pos = { ["x"] = 338.86779785156, ["y"] = -584.07861328125, ["z"] = 73.255664672852, ["h"] = 249.83565979004 },
		Type = 25
	},

	-- Downstairs = { -- Operation
	-- 	Pos	= { ["x"] = 247.18, ["y"] = -1371.88, ["z"] = 23.70, ["h"] = 318.0906 },
	-- 	Type = 25
	-- },

	Office = { -- Kontoret
		Pos	= { ["x"] = 236.22, ["y"] = -1368.16, ["z"] = 38.60, ["h"] = 67.822975158691 },
		Type = 25
	},

	garage = { -- Garage
	    Pos	= { ["x"] = 319.74, ["y"] = -559.83, ["z"] = 27.84, ["h"] = 67.322975158691 },
	    Type = 25
    },

	--AmbulanceActions = { 
		--Pos	= {["x"] = 310.41, ["y"] = -594.22, ["z"] = 42.30, ["h"] = 164.76875305176},
		--Type = 27
	--},

	AmbulanceActions2 = { 
		Pos	= {["x"] = 301.81, ["y"] = -599.33, ["z"] = 42.30, ["h"] = 164.76875305176},
		Type = 27
	},

	VehicleSpawner = {
		Pos	= { x = 323.38, y = -556.43, z = 27.80, ["h"] = 343.56112670898},
		Type = 25
	},

	VehicleSpawnPoint = {
		Pos	= { x = 329.66, y = -556.83, z = 27.74, ["h"] = 150.56112670898},
		Type = -1
	},

	VehicleDeleter = {
		Pos	= { x = 340.06, y = -561.67, z = 27.74 },
		Type = 27
	},

	Pharmacy = {
		Pos	= { x = 311.57, y = -597.11, z = 42.30 },
		Type = 27
	},

	HospitalInteriorInside1 = {
		Pos	= { x = 310.66, y = -587.39, z = 42.29 },
		Type = -1
	},
}

