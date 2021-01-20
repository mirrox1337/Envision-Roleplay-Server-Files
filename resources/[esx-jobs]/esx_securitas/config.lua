Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'sv'

Config.SecuritasStations = {

	Securitas = {

		Blip = {
			Pos     = { x = -1084.44, y = -256.87, z = 37.76 },
			Sprite  = 120,
			Display = 2,
			Scale   = 0.6,
			Colour  = 1,
		},

		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 5000 },
			{ name = 'WEAPON_STUNGUN',          price = 6000 },
			{ name = 'WEAPON_FLASHLIGHT',       price = 750 }
		},


		Cloakrooms = {
			{ x = -1041.61, y = -233.71, z = 36.96 },
		},

		Armories = {
			{ x = -1052.69, y 	= -230.93, z = 39.20 },
		},
		
		Vehicles = {
			{
				Spawner    = { x = -1049.91, y = -239.73, z = 37.01 },
				SpawnPoints = {
					{ x = -1055.99, y = -241.99, z = 37.99, heading = 200.63, radius = 6.0 }

				}
			},
		},

		VehicleDeleters = {
			{ x = -1097.24, y = -256.18, z = 36.7 },  -- securitashouse 1
			{ x = -1051.63, y = -249.24, z = 36.87 },  -- securitashouse  2
			{ x = 469.12, y = -1024.52, z = 27.20 }   -- policestationen -- 
		},

		BossActions = {
			{ x = -1056.20, y = -233.15, z = 39.22 }
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	recruit = {
	   {
		model =  'securitas2', label = 'Caddy'
	   }   
	},

	officer = {
		{
			model =  'securitas2', label = 'Caddy'
		}   
	 },

	sergeant = {
		{
			model =  'securitas2', label = 'Caddy'
		}   
	 },

	intendent = {
		{
			model =  'securitas2',
			label = 'securitas'
		}   
	 },	
	

	lieutenant = {
		{
			model =  'securitas2', label = 'Chefsbil'
		}   
	 },

	chef = {
		{
			model =  'securitas2', label = 'Caddy'
		},
		{
			model =  'lguard', label = 'Chefsbil'
		}   
	 },
	
	boss = {
		{
			model =  'lguard', label = 'Chefsbil'
		},
		{
			model =  'securitas2', label = 'Caddy'
		}    
	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 1,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 1,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 1,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 1,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
	male = {
		['tshirt_1'] = 122,  ['tshirt_2'] = 0,
		['torso_1'] = 285,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 12,
		['pants_1'] = 112,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = 0,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
	},
	female = {
		['tshirt_1'] = 122,  ['tshirt_2'] = 0,
		['torso_1'] = 285,   ['torso_2'] = 1,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 12,
		['pants_1'] = 112,   ['pants_2'] = 1,
		['shoes_1'] = 25,   ['shoes_2'] = 1,
		['helmet_1'] = 0,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
	}
},
	chef_wear = {
		male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 285,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 112,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 1,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
		}
	},
	boss_wear = { -- currently the same as chef_wear
	male = {
		['tshirt_1'] = 122,  ['tshirt_2'] = 0,
		['torso_1'] = 285,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 12,
		['pants_1'] = 112,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = 0,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
	},
	female = {
		['tshirt_1'] = 122,  ['tshirt_2'] = 0,
		['torso_1'] = 285,   ['torso_2'] = 1,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 12,
		['pants_1'] = 112,   ['pants_2'] = 1,
		['shoes_1'] = 25,   ['shoes_2'] = 1,
		['helmet_1'] = 0,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
	}
},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}
