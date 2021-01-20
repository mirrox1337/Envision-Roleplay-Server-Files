--[[
***** How to Setup a vehicle_names.lua for Custom Addon Vehicles *****
* Create a vehicle_names.lua & past the below Code
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	--Example 1: AddTextEntry('SPAWN_NAME_HERE', 'VEHICLE_NAME_HERE')
	--Example 2: AddTextEntry('f350', '2013 Ford F350')
end)
]]

Config = {}
Config.Locale = 'sv'

Config.KickPossibleCheaters = false -- If true it will kick the player that tries store a vehicle that they changed the Hash or Plate.
Config.UseCustomKickMessage = true -- If KickPossibleCheaters is true you can set a Custom Kick Message in the locales.

Config.UseDamageMult = true -- If true it costs more to store a Broken Vehicle.
Config.DamageMult = 5 -- Higher Number = Higher Repair Price.

Config.CarPoundPrice      = 500 -- Car Pound Price.
Config.BoatPoundPrice     = 4500 -- Boat Pound Price.
Config.AircraftPoundPrice = 7500 -- Aircraft Pound Price.

Config.PolicingPoundPrice  = 1000 -- Policing Pound Price.
Config.AmbulancePoundPrice = 1000 -- Ambulance Pound Price.

Config.UseCarGarages        = true -- Allows use of Car Garages.
Config.UseBoatGarages       = false -- Allows use of Boat Garages.
Config.UseAircraftGarages   = false -- Allows use of Aircraft Garages.
Config.UsePrivateCarGarages = false -- Allows use of Private Car Garages.
Config.UseJobCarGarages     = true -- Allows use of Job Garages.

Config.DontShowPoundCarsInGarage = false -- If set to true it won't show Cars at the Pound in the Garage.
Config.ShowVehicleLocation       = true -- If set to true it will show the Location of the Vehicle in the Pound/Garage in the Garage menu.
Config.UseVehicleNamesLua        = true -- Must setup a vehicle_names.lua for Custom Addon Vehicles.

Config.ShowGarageSpacer1 = false -- If true it shows Spacer 1 in the List.
Config.ShowGarageSpacer2 = false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowGarageSpacer3 = false -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.ShowPoundSpacer2 = false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowPoundSpacer3 = false -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.MarkerType   = 36
Config.DrawDistance = 30.0

Config.BlipGarage = {
	Sprite = 290,
	Color = 38,
	Display = 2,
	Scale = 0.65
}

Config.BlipGaragePrivate = {
	Sprite = 290,
	Color = 53,
	Display = 2,
	Scale = 0.65
}

Config.BlipPound = {
	Sprite = 569,
	Color = 2,
	Display = 2,
	Scale = 0.65
}

Config.BlipJobPound = {
	Sprite = 380,
	Color = 22,
	Display = 2,
	Scale = 0.65
}

Config.PointMarker = {
	r = 0, g = 255, b = 0,     -- Green Color
	x = 0.0, y = 0.0, z = 0.0  -- Standard Size Circle
}

Config.DeleteMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 0.0, y = 0.0, z = 0.0  -- Big Size Circle
}

Config.PoundMarker = {
	r = 0, g = 0, b = 100,     -- Blue Color
	x = 1.3, y = 1.3, z = 1.3  -- Standard Size Circle
}

Config.JobPoundMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 1.3, y = 1.3, z = 1.3  -- Standard Size Circle
}

-- Start of Jobs

Config.PolicePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.29 },
		SpawnPoint = { x = 391.74, y = -1619.0, z = 28.29, h = 318.34 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 37.65 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -223.6, y = 6243.37, z = 30.49 },
		SpawnPoint = { x = -230.88, y = 6255.89, z = 30.49, h = 136.5 }
	}
}

Config.AmbulancePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.29 },
		SpawnPoint = { x = 391.74, y = -1619.0, z = 28.29, h = 318.34 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 37.65 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -223.6, y = 6243.37, z = 30.49 },
		SpawnPoint = { x = -230.88, y = 6255.89, z = 30.49, h = 136.5 }
	}
}

-- End of Jobs
-- Start of Cars

Config.CarGarages = {
	Garage_Pillbox = {
		GaragePoint = { x = 44.71, y = -854.77, z = 30.71 -0.95 },
		SpawnPoint = { x = 44.71, y = -854.77, z = 30.71 -0.95, h = 144.51 },
		DeletePoint = { x = 38.08, y = -871.85, z = 30.43 -0.95 }
	},
	Garage_Sandy = {
		GaragePoint = { x = 1737.59, y = 3710.2, z = 33.14 -0.95 },
		SpawnPoint = { x = 1737.84, y = 3719.28, z = 33.04 -0.95, h = 21.22 },
		DeletePoint = { x = 1722.66, y = 3713.74, z = 33.21 -0.95 }
	},
	Garage_Paleto = {
		GaragePoint = { x = 105.359, y = 6613.586, z = 31.3973 -0.95 },
		SpawnPoint = { x = 128.7822, y = 6622.9965, z = 30.7828 -0.95, h = 315.01 },
		DeletePoint = { x = 126.3572, y = 6608.4150, z = 30.8565 -0.95 }
	},
	Garage_Prison = {
		GaragePoint = { x = 1846.56, y = 2585.86, z = 44.67 -0.95 },
		SpawnPoint = { x = 1855.11, y = 2592.72, z = 44.67 -0.95, h = 274.8 },
		DeletePoint = { x = 1855.21, y = 2615.3, z = 34.67 -0.95 } -- z = 44.67
	},
	--Motell
	Garage_PinkCageMotel = {
		GaragePoint = { x = 290.47, y = -338.05, z = 44.96 -0.95 },
		SpawnPoint = { x = 290.47, y = -338.05, z = 44.96 -0.95, h = 167.0 },
		DeletePoint = { x = 273.95, y = -331.75, z = 44.92 -0.95 }
	},
	Garage_PerreraBeachMotel = {
		GaragePoint = { x = -1445.88, y = -681.95, z = 26.36 -0.95 },
		SpawnPoint = { x = -1445.88, y = -681.95, z = 26.36 -0.95, h = 274.8 },
		DeletePoint = { x = -1429.63, y = -670.69, z = 26.75 -0.95 } -- z = 44.67
	},
	Garage_TahitianMotel = {
		GaragePoint = { x = -14.51, y = -1512.65, z = 30.07 -0.95 },
		SpawnPoint = { x = -14.51, y = -1512.65, z = 30.07 -0.95, h = 321.82 },
		DeletePoint = { x = -7.61, y = -1501.19, z = 29.95 -0.95 } -- z = 44.67
	},
	Garage_BilingsgateMotel = {
		GaragePoint = { x = 564.65, y = -1799.29, z = 29.2 -0.95 },
		SpawnPoint = { x = 564.65, y = -1799.29, z = 29.2 -0.95, h = 347.95 },
		DeletePoint = { x = 545.13, y = -1795.38, z = 29.2 -0.95 } -- z = 44.67
	},
	Garage_EasternMotel = {
		GaragePoint = { x = 317.91, y = 2623.53, z = 44.47 -0.95 },
		SpawnPoint = { x = 329.9, y = 2613.64, z = 44.49 -0.95, h = 2.12 },
		DeletePoint = { x = 346.64, y = 2636.23, z = 44.49 -0.95 } -- z = 44.67
	},
	Garage_TheMotorMotel = {
		GaragePoint = { x = 1141.69, y = 2663.98, z = 38.16 -0.95 },
		SpawnPoint = { x = 1127.34, y = 2664.85, z = 38.02 -0.95, h = 181.03 },
		DeletePoint = { x = 1098.17, y = 2663.42, z = 37.96 -0.95 } -- z = 44.67
	},
	Garage_DreamViewMotel = {
		GaragePoint = { x = -96.42, y = 6324.44, z = 31.58 -0.95 },
		SpawnPoint = { x = -86.06, y = 6339.68, z = 31.49 -0.95, h = 45.62 },
		DeletePoint = { x = -58.74, y = 6344.96, z = 31.48 -0.95 } -- z = 44.67
	},
}

Config.CarPounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 408.61, y = -1625.47, z = 29.29 -0.95 },
		SpawnPoint = { x = 405.64, y = -1643.4, z = 27.61 -0.95, h = 229.54 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1661.97, y = 3820.5, z = 34.55 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -234.82, y = 6198.65, z = 30.94 },
		SpawnPoint = { x = -230.08, y = 6190.24, z = 30.49, h = 140.24 }
	}
}

-- End of Cars
-- Start of Boats

Config.BoatGarages = {
	Garage_LSDock = {
		GaragePoint = { x = -735.87, y = -1325.08, z = 0.6 },
		SpawnPoint = { x = -718.87, y = -1320.18, z = -0.47477427124977, h = 45.0 },
		DeletePoint = { x = -731.15, y = -1334.71, z = -0.47477427124977 }
	},
	Garage_SandyDock = {
		GaragePoint = { x = 1333.2, y = 4269.92, z = 30.5 },
		SpawnPoint = { x = 1334.61, y = 4264.68, z = 29.86, h = 87.0 },
		DeletePoint = { x = 1323.73, y = 4269.94, z = 29.86 }
	},
	Garage_PaletoDock = {
		GaragePoint = { x = -283.74, y = 6629.51, z = 6.3 },
		SpawnPoint = { x = -290.46, y = 6622.72, z = -0.47477427124977, h = 52.0 },
		DeletePoint = { x = -304.66, y = 6607.36, z = -0.47477427124977 }
	}
}

Config.BoatPounds = {
	Pound_LSDock = {
		PoundPoint = { x = -738.67, y = -1400.43, z = 4.0 },
		SpawnPoint = { x = -738.33, y = -1381.51, z = 0.12, h = 137.85 }
	},
	Pound_SandyDock = {
		PoundPoint = { x = 1299.36, y = 4217.93, z = 32.91 },
		SpawnPoint = { x = 1294.35, y = 4226.31, z = 29.86, h = 345.0 }
	},
	Pound_PaletoDock = {
		PoundPoint = { x = -270.2, y = 6642.43, z = 6.36 },
		SpawnPoint = { x = -290.38, y = 6638.54, z = -0.47477427124977, h = 130.0 }
	}
}

-- End of Boats
-- Start of Aircrafts

Config.AircraftGarages = {
	Garage_LSAirport = {
		GaragePoint = { x = -1617.14, y = -3145.52, z = 12.99 },
		SpawnPoint = { x = -1657.99, y = -3134.38, z = 12.99, h = 330.11 },
		DeletePoint = { x = -1642.12, y = -3144.25, z = 12.99 }
	},
	Garage_SandyAirport = {
		GaragePoint = { x = 1723.84, y = 3288.29, z = 40.16 },
		SpawnPoint = { x = 1710.85, y = 3259.06, z = 40.69, h = 104.66 },
		DeletePoint = { x = 1714.45, y = 3246.75, z = 40.07 }
	},
	Garage_GrapeseedAirport = {
		GaragePoint = { x = 2152.83, y = 4797.03, z = 40.19 },
		SpawnPoint = { x = 2122.72, y = 4804.85, z = 40.78, h = 115.04 },
		DeletePoint = { x = 2082.36, y = 4806.06, z = 40.07 }
	}
}

Config.AircraftPounds = {
	Pound_LSAirport = {
		PoundPoint = { x = -1243.0, y = -3391.92, z = 12.94 },
		SpawnPoint = { x = -1272.27, y = -3382.46, z = 12.94, h = 330.25 }
	}
}

-- End of Aircrafts
-- Start of Private Garages

Config.PrivateCarGarages = {
	Garage_PinkCageMotellet = {
		Private = "PinkCageMotel",
		GaragePoint = { x = 327.92, y = -204.04, z = 54.09 -0.95 },
		SpawnPoint = { x = 323.5, y = -203.66, z = 54.09, h = 158.0 },
		DeletePoint = { x = 331.8, y = -206.66, z = 54.09 }
	}
}

-- End of Private Garages
