Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 27
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 255, g = 0, b = 0 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'sv'

Config.Raddningstjansten = {

	Raddningstjansten = {

		Blip = {
			Pos     = { x = 213.3, y = -1645.35, z = 29.8 },
			Sprite  = 436,
			Display = 4,
			Scale   = 1.0,
			Colour  = 1,
		},

		Cloakrooms = {
			{ x = 207.08, y = -1662.22, z = 28.81 },
		},

		Armories = {
			{ x = 196.51, y = -1654.73, z = 28.81 },
		},

		Vehicles = {
			{
				Spawner    = { x = 214.63, y = -1651.15, z = 28.81 },
				SpawnPoints = {
					{ x = 212.38, y = -1649.61, z = 29.0, heading = 319.46, radius = 6.0 },
					{ x = 216.72, y = -1646.52, z = 29.0, heading = 320.05, radius = 6.0 }
				}
			}
		},

		VehicleDeleters = {
			{ x = 209.93, y = -1652.67, z = 28.81 },
			{ x = 206.85, y = -1649.85, z = 28.81 }
		},

		BossActions = {
			{ x = 198.31, y = -1646.46, z = 28.81 }
		},

	},

}

Config.AuthorizedWeapons = {
recruit = {
	--{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
	--{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 500 },
	--{ weapon = 'WEAPON_FIREAXE', price = 500 },
	--{ weapon = 'WEAPON_CROWBAR', price = 1000 }
},

officer = {
	--{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
	--{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 500 },
	--{ weapon = 'WEAPON_FIREAXE', price = 500 },
	--{ weapon = 'WEAPON_CROWBAR', price = 1000 }
},

sergeant = {
	--{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
	--{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 500 },
	--{ weapon = 'WEAPON_FIREAXE', price = 500 },
	--{ weapon = 'WEAPON_CROWBAR', price = 1000 }
},

lieutenant = {
	--{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
	--{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 500 },
	--{ weapon = 'WEAPON_FIREAXE', price = 500 },
	--{ weapon = 'WEAPON_CROWBAR', price = 1000 }
},

boss = {
	{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
	{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 500 },
	{ weapon = 'WEAPON_FIREAXE', price = 500 },
	{ weapon = 'WEAPON_CROWBAR', price = 1000 }
  }
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{ model = 'firetruk3', label = 'Släckbil'},
	},
	
	recruit = {
		{ model = 'firetruk3', label = 'Stegbil'},
	},

	officer = {
		{ model = 'firetruk3', label = 'Släckbil'},
	 },

	sergeant = {
		{ model = 'firetruk3', label = 'Släckbil'},
	 },


	lieutenant = {
		{ model = 'firetruk3', label = 'Släckbil'},
	 },


	boss = {
		{ model = 'firetruk3', label = 'Släckbil'},
		{ model = 'Brandled', label = 'Ledningsfordon'},
		{ model = 'boattrailer', label = 'Båttrailer'},
		{ model = 'bison', label = 'Fordon (Båt)'},
	}
}

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 278, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 109, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 6, ['tshirt_2'] = 0,
			['torso_1'] = 298, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 111,
			['pants_1'] = 119, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['Glasses_1'] = 0, ['Glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 278, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 109, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 6, ['tshirt_2'] = 0,
			['torso_1'] = 298, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 111,
			['pants_1'] = 119, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['Glasses_1'] = 0, ['Glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 278, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 109, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 6, ['tshirt_2'] = 0,
			['torso_1'] = 298, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 111,
			['pants_1'] = 119, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['Glasses_1'] = 0, ['Glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		}
	},
	lieutenant_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 278, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 109, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 6, ['tshirt_2'] = 0,
			['torso_1'] = 298, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 111,
			['pants_1'] = 119, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 1,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['Glasses_1'] = 0, ['Glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		}
	},
	boss_wear = { 
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 278, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 109, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 6, ['tshirt_2'] = 0,
			['torso_1'] = 298, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 111,
			['pants_1'] = 119, ['pants_2'] = 0,
			['shoes_1'] = 24, ['shoes_2'] = 1,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['Glasses_1'] = 0, ['Glasses_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		}
	}
}