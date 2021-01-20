Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = true
Config.EnableMoneyWash            = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.MissCraft                  = 10 -- %


Config.AuthorizedVehicles = {

	{ name = 'Patriot',  label = 'Dragans' },

}

Config.Blips = {

    
    Blip = {
      Pos     = { x = -120.65, y = -1258.48, z = 29.31 },
      Sprite  = 463,
      Display = 4,
      Scale   = 1.4,
      Colour  = 27,
    },

}

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = -1619.75, y = -3020.03, z = -76.20 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 255, g = 187, b = 255 },
        Type  = 27,
    },

    Fridge = {
        Pos   = { x = -1583.04, y = -3013.95, z = -77.00 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = -1,
    },

    Vehicles = {
        Pos          = { x = -191.56, y = -1280.22, z = 30.21 },
        SpawnPoint   = { x = -191.60, y = -1284.31, z = 31.23, },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 126, g = 1, b = 117 },
        Type         = 27,
        Heading      = 264.83,
    },
   
    VehicleDeleters = {
        Pos   = { x = -190.58, y = -1290.44, z = 30.30 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 126, g = 1, b = 117 },
        Type  = 1,
    },

    Helicopters = {
        Pos          = { x = 246.20, y = -3250.52, z = 39.55 },
        SpawnPoint   = { x = 235.35, y = -3260.38, z = 39.54 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 207.43,
    },

    HelicopterDeleters = {
        Pos   = { x = 212.21, y = -3256.65, z = 39.53 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 1,
    },

    BossActions = {
        Pos   = { x = -1608.46, y = -3018.27, z = -75.60 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = -1,
    },

-----------------------
-------- SHOPS --------

    Flacons = {
        Pos   = { x = -1584.58, y = -3012.67, z = -77.00 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 0, b = 0 },
        Type  = -1,
        Items = {
            { name = 'jager',      label = _U('jager'),   price = 3 },
            { name = 'vodka',      label = _U('vodka'),   price = 4 },
            { name = 'sourz',      label = _U('sourz'),   price = 2 },
            { name = 'hotshot',      label = _U('hotshot'),   price = 2 },
            { name = 'fireball',      label = _U('fireball'),   price = 2 },
            { name = 'rhum',       label = _U('rhum'),    price = 2 },
            { name = 'whisky',     label = _U('whisky'),  price = 7 },
            { name = 'champagne',    label = _U('champagne'), price = 50 },
            { name = 'tequila',    label = _U('tequila'), price = 2 },
            { name = 'tequilasunrise',    label = _U('tequilasunrise'), price = 5 },
            { name = 'colada',    label = _U('colada'), price = 5 },
            { name = 'martini',    label = _U('martini'), price = 5 },
            { name = 'bira',    label = _U('bira'), price = 5 },
            { name = 'vinva',    label = _U('vin'), price = 5 },
            { name = 'cider',    label = _U('cider'), price = 5 },
            { name = 'soda',        label = _U('soda'),     price = 4 },
            { name = 'jusfruit',    label = _U('jusfruit'), price = 3 },
            { name = 'icetea',      label = _U('icetea'),   price = 4 },
            { name = 'energy',      label = _U('energy'),   price = 7 },
            { name = 'drpepper',    label = _U('drpepper'), price = 2 },
            { name = 'limonade',    label = _U('limonade'), price = 1 },
            { name = 'ice',     label = _U('ice'),      price = 1 },
            { name = 'menthe',  label = _U('menthe'),   price = 2 },
        },
    },

     NoAlcool = {
         Pos   = { x = -130.41, y = -1290.87, z = 46.90 },
         Size  = { x = 1.6, y = 1.6, z = 1.0 },
         Color = { r = 238, g = 110, b = 0 },
         Type  = 23,
        Items = {
           { name = 'jager',      label = _U('jager'),   price = 3 },
           { name = 'vodka',      label = _U('vodka'),   price = 4 },
           { name = 'rhum',       label = _U('rhum'),    price = 2 },
           { name = 'whisky',     label = _U('whisky'),  price = 7 },
           { name = 'tequila',    label = _U('tequila'), price = 2 },
           { name = 'martini',    label = _U('martini'), price = 5 },
           { name = 'soda',        label = _U('soda'),     price = 4 },
           { name = 'jusfruit',    label = _U('jusfruit'), price = 3 },
           { name = 'icetea',      label = _U('icetea'),   price = 4 },
           { name = 'energy',      label = _U('energy'),   price = 7 },
           { name = 'drpepper',    label = _U('drpepper'), price = 2 },
           { name = 'limonade',    label = _U('limonade'), price = 1 },
           { name = 'ice',     label = _U('ice'),      price = 1 },
           { name = 'menthe',  label = _U('menthe'),   price = 2 },
        },
     },

    Apero = {
        Pos   = { x = -1582.15, y = -3012.22, z = -75.01 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 142, g = 125, b = 76 },
        Type  = -1,
        Items = {
            { name = 'bolcacahuetes',   label = _U('bolcacahuetes'),    price = 7 },
            { name = 'bolnoixcajou',    label = _U('cashew'),     price = 10 },
            { name = 'bolpistache',     label = _U('pistage'),      price = 15 },
            { name = 'bolchips',        label = _U('chips'),         price = 5 },
            { name = 'saucisson',       label = _U('korv'),        price = 25 },
            { name = 'grapperaisin',    label = _U('druvor'),     price = 20 },
            { name = 'burger1',         label = _U('burger1'),     price = 20 },
            { name = 'burger2',         label = _U('burger2'),     price = 20 },
            { name = 'burgare3',         label = ('BBQ Ost & Baconburgare'),     price = 20 },
            { name = 'burger4',         label = _U('burger4'),     price = 20 },
        },
    },

    -- Ice = {
    --     Pos   = { x = -1576.01, y = -3017.11, z = -80.00 },
    --     Size  = { x = 1.6, y = 1.6, z = 1.0 },
    --     Color = { r = 255, g = 255, b = 255 },
    --     Type  = 23,
    --     Items = {
    --         { name = 'ice',     label = _U('ice'),      price = 1 },
    --         { name = 'menthe',  label = _U('menthe'),   price = 2 }
    --     },
    -- },

}


-----------------------
----- TELEPORTERS -----

Config.TeleportZones = {
  --EnterBuilding = {
    --Pos       = { x = 132.608, y = -1293.978, z = 28.269 },
    --Size      = { x = 1.2, y = 1.2, z = 0.1 },
    --Color     = { r = 128, g = 128, b = 128 },
    --Marker    = 1,
    --Hint      = _U('e_to_enter_1'),
    --Teleport  = { x = 126.742, y = -1278.386, z = 28.569 }
  --},

  --ExitBuilding = {
    --Pos       = { x = 132.517, y = -1290.901, z = 28.269 },
    --Size      = { x = 1.2, y = 1.2, z = 0.1 },
    --Color     = { r = 128, g = 128, b = 128 },
    --Marker    = 1,
    --Hint      = _U('e_to_exit_1'),
    --Teleport  = { x = 131.175, y = -1295.598, z = 28.569 },
  --},

  EnterHeliport = {
    Pos       = { x = -175.72, y = -1266.13, z = 31.50 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 126, g = 1, b = 117 },
    Marker    = 1,
    Hint      = _U('e_to_enter_2'),
    Teleport  = { x = -1639.59, y = -3015.26, z = -77.10 }
  },

  ExitHeliport = {
    Pos       = { x = -1639.59, y = -3015.26, z = -79.30 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 126, g = 1, b = 117 },
    Marker    = 1,
    Hint      = _U('e_to_exit_2'),
    Teleport  = { x = -175.72, y = -1266.13, z = 32.06 }
  },
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
   barman_outfit = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 12,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 12,
        ['pants_1'] = 4,   ['pants_2'] = 0,
        ['shoes_1'] = 26,   ['shoes_2'] = 1,
        ['chain_1'] = 0,  ['chain_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 13,   ['tshirt_2'] = 15,
        ['torso_1'] = 57,    ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 7,
        ['pants_1'] = 43,   ['pants_2'] = 0,
        ['shoes_1'] = 3,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 2,
    }
  },
  guard_outfit = {
    male = {
        ['tshirt_1'] = 96,  ['tshirt_2'] = 6,
        ['torso_1'] = 219,   ['torso_2'] = 21,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 6,
        ['pants_1'] = 94,   ['pants_2'] = 21,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['chain_1'] = 6,  ['chain_2'] = 1,
        ['mask_1'] = 121,  ['mask_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 103,   ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 7,
        ['pants_1'] = 32,   ['pants_2'] = 0,
        ['shoes_1'] = 25,   ['shoes_2'] = 0,
        ['chain_1'] = 0,   ['chain_2'] = 0,
        ['bproof_1'] = 0,    ['bproof_2'] = 1,
    }
  }, 
  dancer_outfit_1 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 26,    ['pants_2'] = 9,
        ['shoes_1'] = 26,   ['shoes_2'] = 1,
        ['chain_1'] = 118,  ['chain_2'] = 0,
        },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 5,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 108,   ['pants_2'] = 8,
        ['shoes_1'] = 19,   ['shoes_2'] = 7,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['bproof_1'] = 0,    ['bproof_2'] = 1,
    }
  },    
  dancer_outfit_2 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 26,   ['pants_2'] = 8,
        ['shoes_1'] = 42,   ['shoes_2'] = 1,
        ['chain_1'] = 0,  ['chain_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 32,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 12,   ['pants_2'] = 7,
        ['shoes_1'] = 0,   ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['bproof_1'] = 0,    ['bproof_2'] = 1,
    }
  },
  dancer_outfit_3 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 237,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 5,
        ['pants_1'] = 4,   ['pants_2'] = 4,
        ['shoes_1'] = 42,   ['shoes_2'] = 0,
        ['chain_1'] = 0,  ['chain_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 26,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 12,
        ['pants_1'] = 9,   ['pants_2'] = 8,
        ['shoes_1'] = 6,   ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['bproof_1'] = 0,    ['bproof_2'] = 1,
        
    }
  },
  dancer_outfit_4 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 61,   ['pants_2'] = 5,
        ['shoes_1'] = 16,   ['shoes_2'] = 10,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 22,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 19,   ['pants_2'] = 0,
        ['shoes_1'] = 14,   ['shoes_2'] = 3,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['bproof_1'] = 0,    ['bproof_2'] = 1,
        
    }
  },
  dancer_outfit_5 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 61,   ['pants_2'] = 3,
        ['shoes_1'] = 16,   ['shoes_2'] = 10,
        ['chain_1'] = 118,  ['chain_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 111,  ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 3,
        ['shoes_1'] = 41,   ['shoes_2'] = 3,
        ['chain_1'] = 12,    ['chain_2'] = 0,
        ['bproof_1'] = 0,    ['bproof_2'] = 1,
    }
  },
  dancer_outfit_6 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 61,   ['pants_2'] = 9,
        ['shoes_1'] = 16,   ['shoes_2'] = 10,
        ['chain_1'] = 0,  ['chain_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 111,  ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 62,   ['pants_2'] = 1,
        ['shoes_1'] = 42,   ['shoes_2'] = 1,
        ['chain_1'] = 12,    ['chain_2'] = 0,
        ['bproof_1'] = 0,    ['bproof_2'] = 1,
    }
  },
  dancer_outfit_7 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 61,   ['pants_2'] = 11,
        ['shoes_1'] = 16,   ['shoes_2'] = 10,
        ['chain_1'] = 0,  ['chain_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 111,  ['torso_2'] = 10,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 10,
        ['shoes_1'] = 41,   ['shoes_2'] = 10,
        ['chain_1'] = 12,    ['chain_2'] = 0,
        ['bproof_1'] = 0,    ['bproof_2'] = 1,
    }
  }
}

-- markers
Config.zones = {

	NightclubEnter = {
		x = -121.65,
		y = -1258.48,
		z = 28.61,
		w = 2.0,
		h = 1.0,		
		visible = true,
		t = 31,
		color = {
			r = 105,
			g = 1,
			b = 107
		}
	},

	NightclubExit = {
		x = -1569.63,
		y = -3016.86,
		z = -74.41,
		w = 2.0,
		h = 1.0,		
		visible = true,
		t = 31,
		color = {
			r = 105,
			g = 1,
			b = 107
		}
	},
}

-- Landing point,
Config.point = {

	NightclubEnter = {
		x = -1569.63,
		y = -3013.52,
		z = -74.00
	},
	
	NightclubExit = {
		x = -117.86,
		y = -1259.07,
		z = 29.31
	}
}


-- Automatic teleport list
Config.auto = {
	'Nightclub',
	'NightclubEnter',
	'NightclubExit'
}