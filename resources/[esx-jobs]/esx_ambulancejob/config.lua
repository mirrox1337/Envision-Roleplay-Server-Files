Config                            = {}

Config.DrawDistance               = 15.0

Config.Marker                     = { type = 27, x = 1.0, y = 1.0, z = 1, r = 255, g = 0, b = 0, a = 225, rotate = true }

Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = false -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'sv'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 10 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 60 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(341.0, -1397.3, 32.5), heading = 48.5 }

Config.Hospitals = {

	PillboxHillMedicalCenter = {

		Blip = {
			coords = vector3(310.66, -587.39, 42.29),
			sprite = 61,
			scale  = 0.8,
			color  = 2
		},

		CloakRoom = {
			vector3(301.81, -599.33, 42.30)
		},

		AmbulanceActions = {
			vector3(334.54, -593.8, 42.30)
		},

		Pharmacies = {
			vector3(311.57, -597.11, 42.30)
		},

		Vehicles = {
			{
				Spawner = vector3(323.38, -556.43, 28.80),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 0, g = 255, b = 0, a = 50, rotate = true },
				SpawnPoints = {
					{ coords = vector3(317.08, -556.25, 27.8), heading = 270.0, radius = 1.5 },
					{ coords = vector3(317.08, -553.46, 27.8), heading = 270.0, radius = 1.5 },
					{ coords = vector3(317.08, -550.66, 27.8), heading = 270.0, radius = 1.5 },
					{ coords = vector3(317.08, -547.83, 27.8), heading = 270.0, radius = 1.5 },
					{ coords = vector3(317.08, -544.97, 27.8), heading = 270.0, radius = 1.5 },
					{ coords = vector3(320.97, -541.74, 27.8), heading = 180.0, radius = 1.5 },
					{ coords = vector3(323.77, -541.74, 27.8), heading = 180.0, radius = 1.5 },
					{ coords = vector3(326.66, -541.74, 27.8), heading = 180.0, radius = 1.5 },
					{ coords = vector3(329.41, -541.74, 27.8), heading = 180.0, radius = 1.5 },
					{ coords = vector3(332.27, -541.74, 27.8), heading = 180.0, radius = 1.5 },
					{ coords = vector3(335.1,  -541.74, 27.8), heading = 180.0, radius = 1.5 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(338.53, -586.84, 74.2),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.98, -588.05, 74.2), heading = 307.46, radius = 10.0 }
				}
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(331.95, -595.61, 43.28),
				To = { coords = vector3(319.74, -559.83, 27.84), heading = 67.322975158691 },
				Marker = { type = 20, x = 0.5, y = 0.5, z = -0.5, r = 255, g = 0, b = 0, a = 50, bob = true, follow = true, rotate = false },
				Prompt = ('Tryck ~INPUT_CONTEXT~ för att ta hissen ner till ~y~Garaget~s~.')
			},
			{
				From = vector3(319.74, -559.83, 28.84),
				To = { coords = vector3(331.95, -595.61, 42.28), heading = 75.67 },
				Marker = { type = 20, x = 0.5, y = 0.5, z = 0.5, r = 255, g = 0, b = 0, a = 50, bob = true, follow = true, rotate = false },
				Prompt = ('Tryck ~INPUT_CONTEXT~ för att ta hissen upp till ~y~Huvudentré~s~.')
			},

			{
				From = vector3(330.1, -601.03, 43.28),
				To = { coords = vector3(338.86779785156, -584.07861328125, 73.255664672852), heading = 249.83565979004 },
				Marker = { type = 20, x = 0.5, y = 0.5, z = 0.5, r = 255, g = 0, b = 0, a = 50, bob = true, follow = true, rotate = false },
				Prompt = ('Tryck ~INPUT_CONTEXT~ för att ta hissen upp till ~y~Taket~s~.')
			},
			{
				From = vector3(338.86779785156, -584.07861328125, 74.255664672852),
				To = { coords = vector3(330.1, -601.03, 42.28), heading = 75.67 },
				Marker = { type = 20, x = 0.5, y = 0.5, z = -0.5, r = 255, g = 0, b = 0, a = 50, bob = true, follow = true, rotate = false },
				Prompt = ('Tryck ~INPUT_CONTEXT~ för att ta hissen ner till ~y~Huvudentré~s~.')
			},

			{
				From = vector3(327.26, -603.37, 43.28),
				To = { coords = vector3(236.22, -1368.16, 38.60), heading = 67.822975158691 },
				Marker = { type = 20, x = 0.5, y = 0.5, z = 0.5, r = 255, g = 0, b = 0, a = 50, bob = true, follow = true, rotate = false },
				Prompt = ('Tryck ~INPUT_CONTEXT~ för att ta hissen upp till ~y~Kontoret~s~.')
			},
			{
				From = vector3(236.22, -1368.16, 39.60),
				To = { coords = vector3(327.26, -603.37, 42.28), heading = 342.76 },
				Marker = { type = 20, x = 0.5, y = 0.5, z = -0.5, r = 255, g = 0, b = 0, a = 50, bob = true, follow = true, rotate = false },
				Prompt = ('Tryck ~INPUT_CONTEXT~ för att ta hissen ner till ~y~Huvudentré~s~.')
			}
		},
	}
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Volvo Ambulans', price = 50000},
		{ model = 'policeold1', label = 'Volvo v90 akutbil', price = 50000}
	},

	doctor = {
		{ model = 'ambulance', label = 'Volvo Ambulans', price = 50000},
		{ model = 'policeold1', label = 'Volvo v90 akutbil', price = 50000}
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Volvo Ambulans', price = 50000},
		{ model = 'policeold1', label = 'Volvo v90 akutbil', price = 50000}
	},

	boss = {
		{ model = 'ambulance', label = 'Volvo Ambulans', price = 50000},
		{ model = 'policeold1', label = 'Volvo v90 akutbil', price = 50000}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{ model = 'maverick', label = 'Helikopter', price = 95000 }
	},

	chief_doctor = {
		{ model = 'maverick', label = 'Helikopter', price = 95000 }
	},

	boss = {
		{ model = 'maverick', label = 'Helikopter', price = 95000 }
	}

}
