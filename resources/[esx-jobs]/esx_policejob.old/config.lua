Config                            = {}

Config.DrawDistance               = 5.0
Config.MarkerType                 = 27
Config.MarkerSize                 = { x = 1.0, y = 1.0, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.EnableJobLogs              = false -- only turn this on if you are using esx_joblogs

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'sv'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Pos     = { x = 425.130, y = -979.558, z = 30.711 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.6,
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

			{ x = 461.03, y = -979.78, z = 29.75 }


		},
	
		Vehicles = {
			{
				Spawner    = { x = 441.94, y = -983.61, z = 24.9 },
				SpawnPoints = {
					{ x = 432.48, y = -975.86, z = 25.69, heading = 180.0, radius = 6.0 }
				}
			},

			{
				Spawner    = { x = 450.42, y = -3017.47, z = 48.00 },
				SpawnPoints = {
					{ x = 475.98, y = -1021.65, z = 28.06, heading = 276.11, radius = 6.0 },
					{ x = 484.10, y = -1023.19, z = 27.57, heading = 302.54, radius = 6.0 }
				}
			},
		},

		Helicopters = {
			{
				Spawner    = { x = 455.97, y = -986.819, z = 43.291 },
				SpawnPoint = { x = 455.04, y = -986.14, z = 43.691 },
				Heading    = 0.0
			}
		},

		VehicleDeleters = {
			{ x = 432.48, y = -975.86, z = 24.9},
			--{ x = 469.12, y = -1024.52, z = 27.20 }
		},

		BossActions = {
			{ x = 445.65, y = -972.38, z = 34.98 }
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
			{ x = -442.90, y = 6012.68, z = 30.72 },
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
			{ x = 1840.14, y = 3690.47, z = 33.27 }
		},

		Armories = {
			{ x = 1851.87, y = 3697.02, z = 33.27 }

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
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 0 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},
	officer2 = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 0 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},
	officer3 = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 0 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},
	officer4 = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 0 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	officer = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 500000 },
		--{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		--{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		--{ weapon = 'WEAPON_MARKSMANRIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 10000 },
		{ weapon = 'WEAPON_STUNGUN', price = 10000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10000 }
	},

	sergeant = {
		--{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		--{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 5000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 0 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	intendent = {
		--{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		--{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 5000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 0 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	lieutenant = {
		--{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		--{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		--{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 5000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 0 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 0 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	chef = {
		--{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 3000 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 500000 },
		--{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 5000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 10000 },
		{ weapon = 'WEAPON_STUNGUN', price = 10000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10000 }
	},

	boss = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 500000 },
		--{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		--{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		--{ weapon = 'WEAPON_MARKSMANRIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 10000 },
		{ weapon = 'WEAPON_STUNGUN', price = 10000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10000 }
	}
}

Config.AuthorizedVehicles = {
    Shared = {
        { model = 'police2', label = 'Alltrack'},
        { model = 'police4', label = 'V90CC Civil'},
        { model = 'police', label = 'XC70'},
        { model = 'policet', label = 'T5 Befäl'},
        { model = 'sheriff', label = 'V90CC Målad'},
    },

    recruit = {

    },

    officer = {
        { model = 'riot', label = 'Insatsbil'},
        --{ model = 'policeb', label = 'Polis MC'},
        --{ model = 'sheriff', label = 'XC90'},
        --{ model = 'police2', label = 'Volvo V90 CC Civ'},
        --{ model = 'police4', label = 'Audi A4 civ'},
        --{ model = 'police7', label = 'BMW civ'},
		--{ model = 'fbi', label = 'Volvo V90 Civ'},
		--{ model = 'police3', label = 'Volvo V90 CC'},
        --{ model = 'police5', label = 'Volvo v70'},
        --{ model = 'police', label = 'Passat TDI Buss'},
        --{ model = 'police9', label = 'Passat'},
    },

    sergeant = {
        { model = 'riot', label = 'Insatsbil'},
        --{ model = 'policeb', label = 'Polis MC'},
        --{ model = 'sheriff', label = 'XC90'},
        --{ model = 'police2', label = 'Volvo V90 CC Civ'},
        --{ model = 'police4', label = 'Audi A4 civ'},
        --{ model = 'police7', label = 'BMW civ'},
		--{ model = 'fbi', label = 'Volvo V90 Civ'},
		--{ model = 'police3', label = 'Volvo V90 CC'},
        --{ model = 'police5', label = 'Volvo v70'},
        --{ model = 'police', label = 'Passat TDI Buss'},
        --{ model = 'police9', label = 'Passat'},
    },

    intendent = {

	},

	officer4 = {
		--{ model = 'policeb', label = 'Polis MC'},
		--{ model = 'police2', label = 'Volvo V90 CC Civ'},
		--{ model = 'police4', label = 'Audi A4 civ'},
		--{ model = 'police3', label = 'Volvo V90 CC'},
        --{ model = 'police5', label = 'Volvo v70'},
        --{ model = 'police', label = 'Passat TDI Buss'},
        --{ model = 'police9', label = 'Passat'},
	},

	officer2 = {
		--{ model = 'policeb', label = 'Polis MC'},
		--{ model = 'police2', label = 'Volvo V90 CC Civ'},
		--{ model = 'police4', label = 'Audi A4 civ'},
		--{ model = 'police7', label = 'BMW civ'},
		--{ model = 'police3', label = 'Volvo V90 CC'},
        --{ model = 'police5', label = 'Volvo v70'},
        --{ model = 'police', label = 'Passat TDI Buss'},
        --{ model = 'police9', label = 'Passat'},
	},
	
	officer3 = {
		--{ model = 'policeb', label = 'Polis MC'},
		--{ model = 'police2', label = 'Volvo V90 CC Civ'},
		--{ model = 'police4', label = 'Audi A4 civ'},
		--{ model = 'police7', label = 'BMW civ'},
		--{ model = 'police3', label = 'Volvo V90 CC'},
        --{ model = 'police5', label = 'Volvo v70'},
        --{ model = 'police', label = 'Passat TDI Buss'},
        --{ model = 'police9', label = 'Passat'},
    },

    lieutenant = {
        { model = 'riot', label = 'Insatsbil'},
        --{ model = 'policeb', label = 'Polis MC'},
        --{ model = 'sheriff', label = 'XC90'},
		--{ model = 'police2', label = 'Volvo V90 CC Civ'},
		--{ model = 'police6', label = 'Volvo civ'},
		--{ model = 'police4', label = 'Audi A4 civ'},
		--{ model = 'police3', label = 'Volvo V90 CC'},
        --{ model = 'police5', label = 'Volvo v70'},
        --{ model = 'police', label = 'Passat TDI Buss'},
        --{ model = 'police9', label = 'Passat'},
    },

    chef = {
        { model = 'riot', label = 'Insatsbil'},
        --{ model = 'policeb', label = 'Polis MC'},
        --{ model = 'sheriff', label = 'XC90'},
        --{ model = 'police2', label = 'Volvo V90 CC Civ'},
        --{ model = 'police4', label = 'Audi A4 civ'},
        --{ model = 'police7', label = 'BMW civ'},
		--{ model = 'fbi', label = 'Volvo V90 Civ'},
		--{ model = 'police3', label = 'Volvo V90 CC'},
        --{ model = 'police5', label = 'Volvo v70'},
        --{ model = 'police', label = 'Passat TDI Buss'},
        --{ model = 'police9', label = 'Passat'},
    },

    boss = {
        { model = 'riot', label = 'Insatsbil'},
        --{ model = 'policeb', label = 'Polis MC'},
        --{ model = 'sheriff', label = 'XC90'},
        --{ model = 'police2', label = 'Volvo V90 CC Civ'},
        --{ model = 'police4', label = 'Audi A4 civ'},
        --{ model = 'police7', label = 'BMW civ'},
		--{ model = 'fbi', label = 'Volvo V90 Civ'},
		--{ model = 'police3', label = 'Volvo V90 CC'},
        --{ model = 'police5', label = 'Volvo v70'},
        --{ model = 'police', label = 'Passat TDI Buss'},
        --{ model = 'police9', label = 'Passat'},

    },
}

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 166,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 38,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 163,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 40,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	recruit_wear2 = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 183,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 185,   ['torso_2'] = 0,
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
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 166,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 38,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 163,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 40,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	officer_wear2 = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 183,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 185,   ['torso_2'] = 1,
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
				['tshirt_1'] = 42,  ['tshirt_2'] = 0,
				['torso_1'] = 166,   ['torso_2'] = 2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 38,
				['pants_1'] = 31,   ['pants_2'] = 4,
				['shoes_1'] = 24,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 1,    ['chain_2'] = 0,
				['mask_1'] = 121,     ['mask_2'] = 0
			},
			female = {
				['tshirt_1'] = 32,  ['tshirt_2'] = 0,
				['torso_1'] = 163,   ['torso_2'] = 2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 40,
				['pants_1'] = 30,   ['pants_2'] = 4,
				['shoes_1'] = 24,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 1,    ['chain_2'] = 0,
				['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	sergeant_wear2 = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 183,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 185,   ['torso_2'] = 2,
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
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 166,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 38,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 163,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 40,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	intendent_wear2 = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 183,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 185,   ['torso_2'] = 4,
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
				['tshirt_1'] = 42,  ['tshirt_2'] = 0,
				['torso_1'] = 166,   ['torso_2'] = 4,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 38,
				['pants_1'] = 31,   ['pants_2'] = 4,
				['shoes_1'] = 24,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 1,    ['chain_2'] = 0,
				['mask_1'] = 121,     ['mask_2'] = 0
			},
			female = {
				['tshirt_1'] = 32,  ['tshirt_2'] = 0,
				['torso_1'] = 163,   ['torso_2'] = 4,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 40,
				['pants_1'] = 30,   ['pants_2'] = 4,
				['shoes_1'] = 24,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 1,    ['chain_2'] = 0,
				['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	lieutenant_wear2 = { -- currently the same as intendent_wear
	male = {
		['tshirt_1'] = 42,  ['tshirt_2'] = 0,
		['torso_1'] = 183,   ['torso_2'] = 4,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 30,
		['pants_1'] = 31,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 1,    ['chain_2'] = 0,
		['mask_1'] = 121,     ['mask_2'] = 0
	},
	female = {
		['tshirt_1'] = 32,  ['tshirt_2'] = 0,
		['torso_1'] = 185,   ['torso_2'] = 4,
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
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 166,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 38,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 163,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 40,
			['pants_1'] = 30,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	chef_wear2 = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 183,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 31,   ['pants_2'] = 4,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
			['torso_1'] = 185,   ['torso_2'] = 5,
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
		['tshirt_1'] = 42,  ['tshirt_2'] = 0,
		['torso_1'] = 166,   ['torso_2'] = 5,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 38,
		['pants_1'] = 31,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 1,    ['chain_2'] = 0,
		['mask_1'] = 121,     ['mask_2'] = 0
	},
	female = {
		['tshirt_1'] = 32,  ['tshirt_2'] = 0,
		['torso_1'] = 163,   ['torso_2'] = 5,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 40,
		['pants_1'] = 30,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 1,    ['chain_2'] = 0,
		['mask_1'] = 121,     ['mask_2'] = 0
		}
	},
	boss_wear2 = { -- currently the same as chef_wear
	male = {
		['tshirt_1'] = 42,  ['tshirt_2'] = 0,
		['torso_1'] = 183,   ['torso_2'] = 5,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 30,
		['pants_1'] = 31,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 1,    ['chain_2'] = 0,
		['mask_1'] = 121,     ['mask_2'] = 0
	},
	female = {
		['tshirt_1'] = 32,  ['tshirt_2'] = 0,
		['torso_1'] = 185,   ['torso_2'] = 5,
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
			['bproof_1'] = 30,  ['bags_2'] = 0, ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 34,  ['bproof_2'] = 0, ['bproof_2'] = 0,
		}
	},
	gilet_wear = {
		male = {
			['bproof_1'] = 15,  ['bags_2'] = 0, ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 19,  ['tshirt_2'] = 0, ['bproof_2'] = 0
		}
	},
	trainee_wear = {
		male = {
			['bproof_1'] = 10,  ['bags_2'] = 0, ['bproof_2'] = 2
		},
		female = {
			['bproof_1'] = 19,  ['tshirt_2'] = 0, ['bproof_2'] = 2
		}
	}

}