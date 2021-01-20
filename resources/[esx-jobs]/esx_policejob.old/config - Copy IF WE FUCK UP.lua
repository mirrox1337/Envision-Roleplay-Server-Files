Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.EnableJobLogs              = true -- only turn this on if you are using esx_joblogs

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = false -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale = 'sv'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Pos     = { x = 425.130, y = -979.558, z = 30.711 },
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 29
		},

		--[[AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 500 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 2500 },
			{ name = 'WEAPON_ASSAULTRIFLE',     price = 9700 },
			{ name = 'WEAPON_PUMPSHOTGUN',      price = 5400 },
			{ name = 'WEAPON_STUNGUN',          price = 400 },
			{ name = 'WEAPON_FLASHLIGHT',       price = 250 },
			{ name = 'WEAPON_FLAREGUN',         price = 550 },
			{ name = 'WEAPON_VINTAGEPISTOL',    price = 1000 }
		},]]

		Cloakrooms = {
			{ x = 452.600, y = -993.306, z = 29.750 }
		},

		Armories = {
			{ x = 473.08, y = -990.01, z = 23.914 }
		},

		Vehicles = {
			{
				Spawner    = { x = 454.69, y = -1017.40, z = 27.43 },
				SpawnPoints = {
					{ x = 438.42, y = -1018.30, z = 27.75, heading = 90.0, radius = 6.0 },
					{ x = 441.08, y = -1024.23, z = 28.30, heading = 90.0, radius = 6.0 },
					{ x = 453.53, y = -1022.20, z = 28.02, heading = 90.0, radius = 6.0 },
					{ x = 450.97, y = -1016.55, z = 28.10, heading = 90.0, radius = 6.0 }
				}
			},

			{
				Spawner    = { x = 473.38, y = -1018.43, z = 27.00 },
				SpawnPoints = {
					{ x = 475.98, y = -1021.65, z = 28.06, heading = 276.11, radius = 6.0 },
					{ x = 484.10, y = -1023.19, z = 27.57, heading = 302.54, radius = 6.0 }
				}
			},
			--[[{
				Spawner    = { x = -1671.81, y = -2850.49, z = 12.94 },  --- FLYGFÄLTET för att testa fordon!
				SpawnPoints = {
					{ x = -1664.55, y = -2851.75, z = 12.94, heading = 238.3, radius = 6.0 },
					{ x = 484.10, y = -1023.19, z = 27.57, heading = 302.54, radius = 6.0 }
				}
			}]]
		},

		Helicopters = {
			{
				Spawner    = { x = 466.477, y = -982.819, z = 42.691 },
				SpawnPoint = { x = 450.04, y = -981.14, z = 42.691 },
				Heading    = 0.0
			}
		},

		VehicleDeleters = {
			{ x = 462.74, y = -1014.4, z = 27.065 },
			{ x = 462.40, y = -1019.7, z = 27.104 },
			{ x = 469.12, y = -1024.52, z = 27.20 }
		},

		BossActions = {
			{ x = 461.478, y = -1007.402, z = 34.931 }
		}
	},

	LSPD1 = {

		Blip = {
			Pos     = { x = -450.00, y = 6011.00, z = 31.72 },
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 29
		},

		--[[AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 500 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 2500 },
			{ name = 'WEAPON_ASSAULTRIFLE',     price = 9700 },
			{ name = 'WEAPON_PUMPSHOTGUN',      price = 5400 },
			{ name = 'WEAPON_STUNGUN',          price = 400 },
			{ name = 'WEAPON_FLASHLIGHT',       price = 250 },
			{ name = 'WEAPON_FLAREGUN',         price = 550 },
			{ name = 'WEAPON_VINTAGEPISTOL',    price = 1000 }
		},]]

		Cloakrooms = {
			{ x = -449.43, y = 6011.43, z = 30.72 }
		},

		Armories = {
			{ x = -447.45, y = 6008.94, z = 30.72 }
		},

		Vehicles = {
			{
			    Spawner     = { x = -480.00, y = 6017.00, z = 30.34 },
			    SpawnPoints = { 
					{ x = -473.00, y = 6022.00, z = 30.34, heading = 282.0, radius = 6.0},
				}
			}
		},

		Helicopters = {
			{
			    Spawner    = { x = -485.00, y = 6000.00, z = 30.32 },
			    SpawnPoint = { x = -475.00, y = 5987.00, z = 30.34 },
			    Heading    = 315.0
			},
		},

		VehicleDeleters = {
			{ x = -470.00, y = 6027.00, z = 30.34 }
		},

		BossActions = {
			{ x = -442.90, y = 6012.68, z = 30.72 }
		}
	},

	LSPD2 = {

		Blip = {
			Pos     = { x = 1852.00, y = 3690.00, z = 34.27 },
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 29
		},

		--[[AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 500 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 2500 },
			{ name = 'WEAPON_ASSAULTRIFLE',     price = 9700 },
			{ name = 'WEAPON_PUMPSHOTGUN',      price = 5400 },
			{ name = 'WEAPON_STUNGUN',          price = 400 },
			{ name = 'WEAPON_FLASHLIGHT',       price = 250 },
			{ name = 'WEAPON_FLAREGUN',         price = 550 },
			{ name = 'WEAPON_VINTAGEPISTOL',    price = 1000 },
		},]]

		Cloakrooms = {
			{ x = 1852.00, y = 3690.00, z = 33.27 }
		},

		Armories = {
			{ x = 1849.38, y = 3688.85, z = 33.27 }
		},

		Vehicles = {
			{
			    Spawner     = { x = 1867.00, y = 3697.00, z = 32.58 },
			    SpawnPoints = { 
					{ x = 1871.00, y = 3690.00, z = 32.64, heading = 206.0, radius = 6.0},
				}
			}
		},

		Helicopters = {
		},

		VehicleDeleters = {
			{ x = 1862.00, y = 3703.00, z = 32.49 }
		},
	  
		BossActions = {
			{ x = 1851.87, y = 3684.36, z = 33.27 }
		}
	}
}

Config.AuthorizedWeapons = {
	recruit = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 80 },
		{ weapon = 'WEAPON_STUNGUN', price = 1000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 80 }
	},

	officer = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		--{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	sergeant = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		--{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	intendent = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		--{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	lieutenant = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		--{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	chef = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 10000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	boss = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 10000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {
		{ model = 'police', label = 'Volvo V60'},
		{ model = 'fbi', label = 'Volvo V90CC civil'},
		{ model = 'police3', label = 'Volvo V90CC'},
		{ model = 'police5', label = 'Volvo XC70'},
		{ model = 'police9', label = 'Vw Passat'}
	},

	recruit = {

	},

	officer = {
	
	},

	sergeant = {
		{ model = 'policet', label = 'VW Transporter'},
		{ model = 'policeb', label = 'Polis MC'}
	},

	intendent = {

	},

	lieutenant = {
	    { model = 'policet', label = 'VW Transporter'},
		{ model = 'riot', label = 'Insatsbil'},
		{ model = 'police4', label = 'Audi Civil'},
		{ model = 'policeb', label = 'Polis MC'},
		{ model = 'police9', label = 'Vw Passat'},
		{ model = 'sheriff', label = 'Range Rover'}
	},

	chef = {
	    { model = 'policet', label = 'VW Transporter'},
		{ model = 'riot', label = 'Insatsbil'},
		{ model = 'police4', label = 'Audi Civil'},
		{ model = 'police6', label = 'XC70 Civil'},
		{ model = 'policeb', label = 'Polis MC'},
		{ model = 'police9', label = 'Vw Passat'},
		{ model = 'sheriff', label = 'Range Rover'}
	},

	boss = {
		{ model = 'policet', label = 'VW Transporter'},
		{ model = 'riot', label = 'Insatsbil'},
		{ model = 'police4', label = 'Audi Civil'},
		{ model = 'police6', label = 'XC70 Civil'},
		{ model = 'policeb', label = 'Polis MC'},
		{ model = 'police9', label = 'Vw Passat'},
		{ model = 'sheriff', label = 'Range Rover'}

	}
}

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	recruit_wear2 = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	officer_wear2 = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	sergeant_wear2 = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	intendent_wear2 = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	lieutenant_wear2 = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	chef_wear2 = {
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	boss_wear2 = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 2,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bags_1'] = 4,  ['bags_2'] = 0
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['bags_1'] = 1,  ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}