Config                            = {}
Config.DrawDistance               = 10.0
Config.MarkerColor                = { r = 0, g = 150, b = 255 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.Locale                     = 'sv'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

	ShopEntering = {
		Pos   = { x = -55.55, y = -1098.11, z = 26.42 - 0.98 },
		Heading = 359.31,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 1
	},

	ShopInside = {
		Pos     = { x = -47.570, y = -1097.221, z = 25.422 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = -20.0,
		Type    = -1
	},

	ShopOutside = {
		Pos     = { x = -28.637, y = -1085.691, z = 25.565 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 330.0,
		Type    = -1
	},

	BossActions = {
		Pos   = { x = -32.065, y = -1114.277, z = 25.422 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},
	GiveBackVehicle = {
		Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = (Config.EnablePlayerManagement and 1 or -1)
	},

	ResellVehicle = {
		Pos   = { x = 4442, y = -1080.738, z = -5525.683 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = 1
	}

}


Uppvisning = {

	["markerPos"] = vector3(-52.1, -1088.66, 26.42),

	["carPos"] = {
		[1] = {
			coords = vector3(-40.61, -1094.79, 25.97),
			heading = 200.09,
			active = false
		},

		[2] = {
			coords = vector3(-44.78, -1093.69, 25.97),
			heading = 200.09,
			active = false
		},

		[3] = {
			coords = vector3(-48.69, -1092.5, 25.97),
			heading = 200.09,
			active = false
		}

	 }
	 
}

Storage = vector3(-26.59, -1090.34, 26.42)



