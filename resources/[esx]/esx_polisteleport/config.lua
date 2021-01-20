Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 27
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.75 }
Config.MarkerColor                = { r = 0, g = 255, b = 0 }

Config.Pads = {
 --[[ PolisFangelseUpp = {
	Text = 'Tryck ~INPUT_CONTEXT~ för att gå upp till ~g~station.',
	Marker = {x = 2155.11, y = 2920.93, z = -62.88},
	TeleportPoint = {x = 464.97, y = -989.98, z = 23.95},  --= 1800.973, ['y'] = 2483.247, ['z'] = -122.703
  },]]
  PolisHelikopterUpp = {
	Text = 'Tryck ~INPUT_CONTEXT~ för att gå upp till ~g~helikopterplattan.',
	Marker = {x = 458.87, y = -1007.88, z = 27.27},
	TeleportPoint = {x = 473.45, y = -1003.67, z = 40.01}
  },
  PolisHelikopterNer = {
	Text = 'Tryck ~INPUT_CONTEXT~ för att gå ner.',
	Marker = {x = 473.45, y = -1003.67, z = 40.01},
	TeleportPoint = {x = 458.87, y = -1007.88, z = 27.27}
  },
  PolisGarageIn2 = {
	Text = 'Tryck ~INPUT_CONTEXT~ för att gå in.',
	Marker = {x = 464.49, y = -1012.99, z = 27.10},
	TeleportPoint = {x = 452.16, y = -988.34, z = 25.70}
  },
  PolisGarageUt2 = {
	Text = 'Tryck ~INPUT_CONTEXT~ för att gå ut.',
	Marker = {x = 452.16, y = -988.34, z = 25.70},
	TeleportPoint = {x = 464.49, y = -1012.99, z = 27.30}
  }
}