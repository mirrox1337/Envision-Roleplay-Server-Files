Config                            = {}

Config.DrawDistance               = 5.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'sv'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 78
		},

		Cloakrooms = {
			vector3(452.600, -993.306, 30.69)
		},

		Armories = {
			vector3(443.36, -972.72, 35.92)
		},

		Vehicles = {
			{
				Spawner = vector3(441.97, -983.73, 25.8),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(425.84, -982.41, 25.43), heading = 269.25, radius = 2.0 },
					{ coords = vector3(425.84, -986.25, 25.42), heading = 269.25, radius = 2.0 },
					{ coords = vector3(425.84, -990.03, 25.42), heading = 269.25, radius = 2.0 },
					{ coords = vector3(425.84, -993.86, 25.42), heading = 269.25, radius = 2.0 }
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{ coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
					{ coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(459.4, -983.93, 43.69),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(445.31, -972.72, 35.92)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 1500 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 80 }
	},

	officer = {
		--{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 500 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	sergeant = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 70000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 500 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	intendent = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 70000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 500 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	lieutenant = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 70000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 500 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	chef = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 70000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 500 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	boss = {
		{ weapon = 'WEAPON_NIGHTSTICK', price = 1250},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 25000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 70000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 75000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 150000 },
		{ weapon = 'WEAPON_STUNGUN', price = 1000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 500 },
    { weapon = 'WEAPON_VINTAGEPISTOL', price = 500 }, 
		--{ weapon = 'WEAPON_FLAREGUN', price = 1000 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {
    { model = 'police2', label = 'Volkswagen', price = 50000},
    { model = 'police4', label = 'V90 Civil', price = 50000},
    { model = 'police', label = 'XC70', price = 50000},
    { model = 'policet', label = 'T5 Befäl', price = 50000},
    { model = 'sheriff', label = 'V90 Målad', price = 50000},
    { model = 'police3', label = 'Toureg', price = 50000},
	},

	recruit = {
    --{ model = 'police', label = 'Volkswagen Passat', price = 100 }
	},

	officer = {
		{ model = 'riot', label = 'Insatsbil', price = 50000},
  },
  
  officer2 = {
    { model = 'riot', label = 'Insatsbil', price = 50000},
		--{ model = 'police', label = 'Volkswagen Passat', price = 100 },
		--{ model = 'police2', label = 'Volvo V90 CC', price = 100 },
		--{ model = 'police3', label = 'Volvo XC90', price = 100 }
	},

	sergeant = {
    --{ model = 'riot', label = 'Insatsbil', price = 2500},
		--{ model = 'police', label = 'Volkswagen Passat', price = 100 },
		--{ model = 'police2', label = 'Volvo V90 CC', price = 100 },
		--{ model = 'police3', label = 'Volvo XC90', price = 100 },
		--{ model = 'policeb', label = 'BMW 1200R', price = 100 },
		--{ model = 'sheriff', label = 'Volkswagen T6', price = 100 },
		--{ model = 'police4', label = 'Audi A4 - Civil', price = 100 },
		--{ model = 'fbi', label = 'Volvo V90 CC - Civil', price = 100 },
		--{ model = 'policeold2', label = 'Volkswagen T6 - Civil', price = 100 }
  },
  
  sergeant2 = {
    --{ model = 'riot', label = 'Insatsbil', price = 2500},
		--{ model = 'police', label = 'Volkswagen Passat', price = 100 },
		--{ model = 'police2', label = 'Volvo V90 CC', price = 100 },
		--{ model = 'police3', label = 'Volvo XC90', price = 100 },
		--{ model = 'policeb', label = 'BMW 1200R', price = 100 },
		--{ model = 'sheriff', label = 'Volkswagen T6', price = 100 },
		--{ model = 'police4', label = 'Audi A4 - Civil', price = 100 },
		--{ model = 'fbi', label = 'Volvo V90 CC - Civil', price = 100 },
		--{ model = 'policeold2', label = 'Volkswagen T6 - Civil', price = 100 }
	},

	lieutenant = {
    { model = 'riot', label = 'Insatsbil', price = 50000},
		--{ model = 'police', label = 'Volkswagen Passat', price = 100 },
		--{ model = 'police2', label = 'Volvo V90 CC', price = 100 },
		--{ model = 'police3', label = 'Volvo XC90', price = 100 },
		--{ model = 'policeb', label = 'BMW 1200R', price = 100 },
		--{ model = 'sheriff', label = 'Volkswagen T6', price = 100 },
		--{ model = 'police4', label = 'Audi A4 - Civil', price = 100 },
		--{ model = 'fbi', label = 'Volvo V90 CC - Civil', price = 100 },
		--{ model = 'policeold2', label = 'Volkswagen T6 - Civil', price = 100 }
	},

	boss = {
    { model = 'riot', label = 'Insatsbil', price = 50000},
    --{ model = 'police', label = 'Volkswagen Passat', price = 100 },
    --{ model = 'police2', label = 'Volvo V90 CC', price = 100 },
    --{ model = 'police3', label = 'Volvo XC90', price = 100 },
    --{ model = 'policeb', label = 'BMW 1200R', price = 100 },
    --{ model = 'sheriff', label = 'Volkswagen T6', price = 100 },
    --{ model = 'police4', label = 'Audi A4 - Civil', price = 100 },
    --{ model = 'fbi', label = 'Volvo V90 CC - Civil', price = 100 },
    --{ model = 'policeold2', label = 'Volkswagen T6 - Civil', price = 100 }

	}
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},

	intendent = {},

	lieutenant = {
		{ model = 'polmav', label = 'Helikopter', livery = 0, price = 250 }
	},

	chef = {
		{ model = 'polmav', label = 'Helikopter', livery = 0, price = 250 }
	},

	boss = {
		{ model = 'polmav', label = 'Helikopter', livery = 0, price = 250 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  --0 Aspirant Långärmad
      cadet_wear = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 165, ['torso_2'] = 0,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 1,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 162, ['torso_2'] = 0,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 7,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --Aspirant Kortärmad
      cadet_wear_short = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 177, ['torso_2'] = 0,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 0,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 179, ['torso_2'] = 0,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 14,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 1, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      -- 1 Assistent Långärmad
      police_wear = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 165, ['torso_2'] = 1,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 1,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 162, ['torso_2'] = 1,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 7,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --Assistent Kortärmad
      police_wear_short = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 177, ['torso_2'] = 1,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 0,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 179, ['torso_2'] = 1,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 14,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 1, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --2 Assistent4 Långärmad
      police2_wear = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 165, ['torso_2'] = 2,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 1,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 162, ['torso_2'] = 2,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 7,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --Assistent4 Kortärmad
      police2_wear_short = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 177, ['torso_2'] = 2,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 0,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 179, ['torso_2'] = 2,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 14,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --3 Inspektör Långärmad
      sergeant_wear = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 165, ['torso_2'] = 3,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 1,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 162, ['torso_2'] = 3,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 7,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --Inspektör Kortärmad
      sergeant_wear_short = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 177, ['torso_2'] = 3,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 0,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 179, ['torso_2'] = 3,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 14,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --4 Inspektör Långärmad (Befäl) 
      sergeant2_wear = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 165, ['torso_2'] = 4,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 1,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 162, ['torso_2'] = 4,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 7,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --Inspektör kortärmad (Befäl) 
      sergeant2_wear_short = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 177, ['torso_2'] = 4,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 0,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 179, ['torso_2'] = 4,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 14,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['shoes_1'] = 36, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --5 Kommisarie Långärmad 
      lieutenant_wear = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 165, ['torso_2'] = 5,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 1,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 162, ['torso_2'] = 5,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 7,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      --Kommisarie kortärmad 
      lieutenant_wear_short = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 177, ['torso_2'] = 5,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 0,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 0, ['tshirt_2'] = 0,
          ['torso_1'] = 144, ['torso_2'] = 5,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 31,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 61, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      -- 6 Polischef Långärmad
      commandant_wear = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 165, ['torso_2'] = 6,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 1,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 162, ['torso_2'] = 6,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 7,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      -- Polischef (Kortärmad)
      commandant_wear_short = {
        male = {
          ['tshirt_1'] = 129, ['tshirt_2'] = 0,
          ['torso_1'] = 177, ['torso_2'] = 6,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 0,
          ['pants_1'] = 96, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 159, ['tshirt_2'] = 0,
          ['torso_1'] = 179, ['torso_2'] = 6,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 14,
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['pants_1'] = 36, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        }
      },
      mc_wear = {
        male = {
          ['tshirt_1'] = 15, ['tshirt_2'] = 0,
          ['torso_1'] = 221, ['torso_2'] = 0,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 1,
          ['pants_1'] = 96, ['pants_2'] = 1,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['glasses_1'] = 0, ['glasses_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
        },
        female = {
          ['tshirt_1'] = 6, ['tshirt_2'] = 0,
          ['torso_1'] = 231, ['torso_2'] = 0,
          ['decals_1'] = 0, ['decals_2'] = 0,
          ['arms'] = 3,
          ['pants_1'] = 36, ['pants_2'] = 3,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['helmet_1'] = 66, ['helmet_2'] = 14,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['glasses_1'] = 0, ['glasses_2'] = 0,
          ['mask_1'] = 121, ['mask_2'] = 0,
        }
      },
      bulletsvart_wear = {
        male = {
          ['bags_1'] = 4, ['bags_2'] = 0
        },
        female = {
          ['bags_1'] = 2, ['bags_2'] = 0
        }
      },
      gilet_wear = {
        male = {
          ['tshirt_1'] = 0,  ['tshirt_2'] = 0
        },
        female = {
          ['tshirt_1'] = 0,  ['tshirt_2'] = 0
        }
      },
	  befel_vast = {
        male = {
          ['bproof_1'] = 15, ['bproof_2'] = 2
        },
        female = {
          ['bproof_1'] = 2, ['bproof_2'] = 0
        }
      },
	  insats_vast = {
        male = {
          ['bproof_1'] = 4, ['bproof_2'] = 0
        },
        female = {
          ['bproof_1'] = 13, ['bproof_2'] = 1
        }
      }
    }