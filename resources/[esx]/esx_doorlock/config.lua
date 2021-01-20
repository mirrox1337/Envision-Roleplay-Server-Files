Config = {}
Config.Locale = 'en'

Config.DoorList = {

-- Guide Index --
-- Rad 25 -- Whitelist Jobb
-- Rad 27 -- Sjukhus
-- Rad 211 -- Polisstation Stad
-- Rad 727 -- Polisstation Sandy
-- Rad 810 -- Nattklubb
-- Rad 871 -- Klubblokaler
-- Rad 873 -- Grimknights
-- Rad 884 -- Byggnader övrigt
-- Rad 886 -- Ranchen









------Whitelist Jobb--------------------

------SJUKHUS------

	{--Avdelning A
		objName = 'gabz_pillbox_doubledoor_l',
		objCoords  = {x = 302.80310, y = -581.42460, z = 43.43391},
		textCoords = {x = 303.80310, y = -581.8, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Avdelning A
		objName = 'gabz_pillbox_doubledoor_r',
		objCoords  = {x = 305.22190, y = -582.30560, z = 43.43391},
		textCoords = {x = 304.20310, y = -582.0, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Avdelning B
		objName = 'gabz_pillbox_doubledoor_l',
		objCoords  = {x = 324.23600, y = -589.22620, z = 43.43391},
		textCoords = {x = 325.23600, y = -589.5, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Avdelning B
		objName = 'gabz_pillbox_doubledoor_r',
		objCoords  = {x = 326.65500, y = -590.10660, z = 43.43391},
		textCoords = {x = 325.75500, y = -589.69, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Avdelning A -> Avdelning B
		objName = 'gabz_pillbox_doubledoor_l',
		objCoords  = {x = 326.54990, y = -578.04060, z = 43.43391},
		textCoords = {x = 326.20090, y = -579.04060, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Avdelning A -> Avdelning B
		objName = 'gabz_pillbox_doubledoor_r',
		objCoords  = {x = 325.66950, y = -580.45960, z = 43.43391},
		textCoords = {x = 325.97050, y = -579.45960, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Avdelning B -> Avdelning C
		objName = 'gabz_pillbox_doubledoor_l',
		objCoords  = {x = 349.31380, y = -586.32600, z = 43.43391},
		textCoords = {x = 349.0000, y = -587.32600, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Avdelning B -> Avdelning C
		objName = 'gabz_pillbox_doubledoor_r',
		objCoords  = {x = 348.43330, y = -588.74500, z = 43.43391},
		textCoords = {x = 348.73330, y = -587.74500, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Reception
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 313.48010, y = -595.45830, z = 43.43391},
		textCoords = {x = 313.18, y = -596.45, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--OMKL
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 309.13370, y = -597.75150, z = 43.43391},
		textCoords = {x = 308.13370, y = -597.35150, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Förråd
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 303.95960, y = -572.55790, z = 43.43391},
		textCoords = {x = 304.20960, y = -571.55790, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Lab
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 307.11820, y = -569.56900, z = 43.43391},
		textCoords = {x = 308.11820, y = -569.76900, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Koontrollrum
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 340.78180, y = -581.82150, z = 43.43391},
		textCoords = {x = 341.78180, y = -582.12150, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Administration
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 339.00500, y = -586.70340, z = 43.43391},
		textCoords = {x = 340.00500, y = -587.00340, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{-- Enhetschef
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 336.86650, y = -592.57880, z = 43.43391},
		textCoords = {x = 337.86650, y = -592.87880, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--Läkarrum
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 358.72650, y = -593.88140, z = 43.43391},
		textCoords = {x = 359.72650, y = -594.18140, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--läkarrum
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 352.19970, y = -594.14780, z = 43.43391},
		textCoords = {x = 351.89970, y = -595.14780, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{--undersökning
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 346.88550, y = -593.60000, z = 43.43391},
		textCoords = {x = 347.18550, y = -592.60000, z = 44.0},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 2.5
	},

	{-- Sjukhuset Vänster
		objName = 'v_ilev_cor_firedoor',
		objCoords  = {x = 328.624, y = -585.2011, z = 43.327},
		textCoords = {x = 329.553, y = -585.6, z = 43.357},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = false,
		heading = 160.0
	},

	{-- Sjukhuset Höger
		objName = 'v_ilev_cor_firedoor',
		objCoords  = {x = 330.793, y = -585.9909, z = 43.327},
		textCoords = {x = 329.793, y = -585.6, z = 43.327},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = false,
		heading = 340.0
	},

------Polisstation Stad------
	
	{-- Entré dörrar (Dubbeldörrar)
		objName = 'v_ilev_ph_door01',
		objCoords  = {x = 434.747, y = -980.618, z = 30.839},
		textCoords = {x = 434.747, y = -981.50, z = 31.50},
		authorizedJobs = { 'policecard' },
		locked = false,
		distance = 1.5,
		size = 0.3,
		heading = 269.0
	},
	{
		objName = 'v_ilev_ph_door002',
		objCoords  = {x = 434.747, y = -983.215, z = 30.839},
		textCoords = {x = 434.747, y = -982.50, z = 31.50},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = false,
		distance = 1.5,
		heading = 269.0
	},

	{-- Mötesrum
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 447.238, y = -980.630, z = 30.689},
		textCoords = {x = 447.200, y = -980.010, z = 31.739},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		heading = 176.0
	},
	
	{-- Förråd
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 452.618, y = -982.702, z = 30.689},
		textCoords = {x = 453.079, y = -982.600, z = 30.939},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		distance = 1.0,
		locked = true,
		heading = 270.0
	},

	{-- Dörren till Korridor & omklädningsrum
		objName = 'v_ilev_ph_gendoor004',
		objCoords  = {x = 449.698, y = -986.469, z = 30.689},
		textCoords = {x = 450.104, y = -986.388, z = 31.739},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		heading = 90.0
	},
	
	{-- Dörrar till Trapphus & Serverrum (Dubbeldörrar)
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 443.97, y = -989.033, z = 30.6896},
		textCoords = {x = 444.520, y = -989.445, z = 31.339},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		distance = 1.2,
		locked = true,

		heading = 180.09
	},
	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 445.37, y = -989.705, z = 30.6896},
		textCoords = {x = 444.950, y = -989.445, z = 31.339},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		distance = 1.2,
		locked = true,
		heading = 0.0

	},

	{-- Dörr till Trapphus Tak
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 461.286, y = -985.320, z = 30.839},
		textCoords = {x = 461.50, y = -986.00, z = 31.50},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		heading = 91.09
	},

	{-- Dörrar till Trapphus & Serverrum (Dubbeldörrar)
		objName = 'v_ilev_ph_gendoor006',
		objCoords  = {x = 440.74, y = -994.13, z = 30.6896},
		textCoords = {x = 440.35, y = -993.725, z = 31.339},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		distance = 1.5,
		locked = true,

		heading = -90.00
	},
	{
		objName = 'v_ilev_ph_gendoor006',
		objCoords  = {x = 440.74, y = -992.13, z = 30.6896},
		textCoords = {x = 440.35, y = -992.765, z = 31.339},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		distance = 1.5,
		locked = true,
		heading = 90.0

	},
	
	{-- Serverrum (Dubbeldörrar)
		objName = 'v_ilev_ph_door002',
		objCoords  = {x = 444.97, y = -998.75, z = 30.839},
		textCoords = {x = 444.57, y = -998.85, z = 31.50},
		authorizedJobs = { 'policecard' },
		locked = true,
		distance = 1.5,
		size = 0.3,
		heading = 0.0
	},
	{
		objName = 'v_ilev_ph_door01',
		objCoords  = {x = 443.97, y = -998.75, z = 30.839},
		textCoords = {x = 443.97, y = -998.85, z = 31.50},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.5,
		heading = 0.0
	},
	
	{-- Entré dörrar Garage nedervåning(Dubbeldörrar)
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 446.1488, y = -987.7888, z = 26.84951},
		textCoords = {x = 446.1488, y = -986.5888, z = 27.4},
		authorizedJobs = { 'policecard' },
		locked = true,
		distance = 2.5,
		size = 0.3,
		heading = -90.0
	},
	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 446.1488, y = -985.1924, z = 26.84951},
		textCoords = {x = 446.1488, y = -986.3924, z = 27.4},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 2.5,
		heading = 90.0
	},
	
	{-- Kontor nedervåning (Dubbeldörrar)
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 450.7958, y = -983.91, z = 26.85799},
		textCoords = {x = 451.8958, y = -983.91, z = 27.45799},
		authorizedJobs = { 'policecard' },
		locked = true,
		distance = 1.5,
		size = 0.3,
		heading = 0.0
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 453.3936, y = -983.9095, z = 26.85799},
		textCoords = {x = 452.2758, y = -983.9095, z = 27.45799},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.5,
		heading = 180.0
	},
	
	{-- Korridor till Förhörsrum nedervåning(Dubbeldörrar)
		objName = 'v_ilev_gendoor01',
		objCoords  = {x = 465.5664, y = -990.47, z = 24.91},
		textCoords = {x = 465.5664, y = -990.10, z = 25.51},
		authorizedJobs = { 'policecard' },
		distance = 1.5,
		size = 0.3,
		locked = true,
		heading = -90.0

	},
	{
		objName = 'v_ilev_gendoor01',
		objCoords  = {x = 465.5664, y = -989.47, z = 24.91},
		textCoords = {x = 465.5664, y = -989.92, z = 25.51},   
		authorizedJobs = { 'policecard' },
		distance = 1.5,
		size = 0.3,
		locked = true,
		heading = 90.0

	},

	{-- Cell 1 nedervåning
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 461.7235, y = -995.0233, z = 25.03327},
		textCoords = {x = 461.7235, y = -994.3233, z = 25.53327},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		distance = 1.0,
		locked = true,
		heading = 90.0
	},

	{-- Cell 2 nedervåning
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 461.7235, y = -998.6563, z = 25.03327},
		textCoords = {x = 461.7235, y = -997.9563, z = 25.53327},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		distance = 1.0,
		locked = true,
		heading = 90.0
	},
	
	{-- Cell 3 nedervåning
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 461.7235, y = -1002.807, z = 25.03327},
		textCoords = {x = 461.7235, y = -1002.107, z = 25.53327},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.0,
		heading = 90.0
	},

	{-- Cell 4 nedervåning
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 465.7235, y = -995.0233, z = 25.03327},
		textCoords = {x = 465.7235, y = -994.3233, z = 25.53327},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		distance = 1.0,
		locked = true,
		heading = 90.0
	},

	{-- Cell 5 nedervåning
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 465.7235, y = -998.6563, z = 25.03327},
		textCoords = {x = 465.7235, y = -997.9563, z = 25.53327},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		distance = 1.0,
		locked = true,
		heading = 90.0
	},
	
	{-- Cell 6 nedervåning
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 465.7235, y = -1002.807, z = 25.03327},
		textCoords = {x = 465.7235, y = -1002.107, z = 25.53327},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.0,
		heading = 90.0
	},
	
	{-- Dörrar till baksida nedervåning(Dubbeldörrar)
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 467.371, y = -1014.452, z = 26.536},
		textCoords = {x = 468.09, y = -1014.452, z = 27.1362},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 4,
		heading = 0.0
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 469.967, y = -1014.452, z = 26.536},
		textCoords = {x = 469.35, y = -1014.452, z = 27.136},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 4,
		heading = 180.0
	},
	
	{-- Dörr till gång till baksida nedervåning
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 463.478, y = -1003.538, z = 25.005},
		textCoords = {x = 464.00, y = -1003.50, z = 25.50},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		heading = 0.0
	},
	
	{-- Dörrar till fotorum nedervåning(Dubbeldörrar)
		objName = 'v_ilev_ph_gendoor003',
		objCoords  = {x = 467.8787, y = -988.3154, z = 25.536},
		textCoords = {x = 468.9787, y = -988.3154, z = 25.5362},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 4,
		heading = 180.0
	},
	{
		objName = 'v_ilev_ph_gendoor003',
		objCoords  = {x = 470.4809, y = -988.3154, z = 25.536},
		textCoords = {x = 469.3809, y = -988.3154, z = 25.5362},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 4,
		heading = 0.0
	},

	{-- Dörrar till servicerum nedervåning(Dubbeldörrar)
		objName = 'v_ilev_ph_gendoor003',
		objCoords  = {x = 474.8633, y = -991.9055, z = 25.536}, 
		textCoords = {x = 475.9633, y = -991.9055, z = 25.536},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 4,
		heading = 180.0
	},
	{
		objName = 'v_ilev_ph_gendoor003',
		objCoords  = {x = 477.4655, y = -991.9202, z = 25.536},
		textCoords = {x = 476.3655, y = -991.9202, z = 25.536},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 4,
		heading = 0.0
	},

	{-- Dörrar till förhörsrum 1 nedervåning(Dubbla dörrar)
		objName = 'v_ilev_phroofdoor',
		objCoords  = {x = 483.1782, y = -992.0184, z = 24.18713},
		textCoords = {x = 483.1782, y = -992.8184, z = 24.58713},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.5,
		heading = -90.0
	},
	{
		objName = 'v_ilev_door_orange',
		objCoords  = {x = 487.2126, y = -993.3586, z = 24.18713},
		textCoords = {x = 487.2126, y = -992.3586, z = 24.58713},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.5,
		heading = -90.0
	},
	
	{-- Dörrar till förhörsrum 2 nedervåning(Dubbla dörrar)
		objName = 'v_ilev_phroofdoor',
		objCoords  = {x = 483.1353, y = -1002.746, z = 24.18713},
		textCoords = {x = 483.1353, y = -1003.546, z = 24.58713},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.5,
		heading = -90.0
	},
	{
		objName = 'v_ilev_door_orange',
		objCoords  = {x = 487.2126, y = -1004.097, z = 24.18713},
		textCoords = {x = 487.2126, y = -1003.097, z = 24.58713},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.5,
		heading = -90.0
	},

	{-- Dörrar till Bevisrum nedervåning(Dubbeldörrar)
		objName = 'v_ilev_staffdoor',
		objCoords  = {x = 479.6168, y = -1003.796, z = 24.17772},
		textCoords = {x = 479.6168, y = -1005.02, z = 24.67772},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = -90.0
	},
	{
		objName = 'v_ilev_staffdoor',
		objCoords  = {x = 479.6055, y = -1006.4, z = 24.17772},
		textCoords = {x = 479.6055, y = -1005.2, z = 24.67772},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = 90.0
	},

	{-- Dörrar till balkong Övervåning(Dubbeldörrar)
		objName = 'sm_14_mp_door_l',
		objCoords  = {x = 429.1461, y = -996.3041, z = 36.00371},
		textCoords = {x = 429.1461, y = -995.4041, z = 36.00371},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = 90.0
	},
	{
		objName = 'sm_14_mp_door_l',
		objCoords  = {x = 429.1461, y = -993.9622, z = 36.00371},
		textCoords = {x = 429.1461, y = -994.8622, z = 36.00371},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = -90.0
	},

	{-- Dörrar Kontorslandskap till Allmänt Övervåning(Dubbeldörrar)
		objName = 'v_ilev_ph_gendoor004',
		objCoords  = {x = 445.5964, y = -989.1501, z = 36.05446},
		textCoords = {x = 446.7964, y = -989.1501, z = 36.05446},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = 180.0
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objCoords  = {x = 448.2003, y = -989.1528, z = 36.05446},
		textCoords = {x = 447.0003, y = -989.1528, z = 36.05446},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = 0.0
	},
	
	{-- Dörrar Allmänt till utsättningsrum Övervåning(Dubbeldörrar)
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 452.2564, y = -979.5861, z = 36.05663},
		textCoords = {x = 452.2564, y = -980.7861, z = 36.05663},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = 90.0
	},
	{
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 452.2432, y = -982.1906, z = 36.05663},
		textCoords = {x = 452.2432, y = -980.9861, z = 36.05663},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = -90.0
	},
	
	{-- Dörrar Trapphus till Övervåning
		objName = 'v_ilev_ph_gendoor004',
		objCoords  = {x = 463.6942, y = -983.3768, z = 36.05663},
		textCoords = {x = 463.6942, y = -984.3768, z = 36.05663},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.5,
		heading = 90.0
	}, 
	
	{-- Dörrar Trapphus till Tak
		objName = 'v_ilev_gtdoor02',
		objCoords  = {x = 464.361, y = -984.678, z = 43.834},
		textCoords = {x = 464.361, y = -983.550, z = 44.034},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 1.5,
		heading = 90.0
	}, 
	
	{-- Grind baksida
		objName = 'hei_prop_station_gate',
		objCoords  = {x = 488.894, y = -1017.210, z = 27.146},
		textCoords = {x = 488.894, y = -1020.210, z = 30.00},
		authorizedJobs = { 'policecard' },
		size = 0.3,
		locked = true,
		distance = 14,
		size = 2,
		heading = false
	},
	
	{-- Dörrar Chefskontor Övervåning (polischef)
		objName = 'prop_ld_bankdoors_02',
		objCoords  = {x = 444.4481, y = -978.0731, z = 36.02956},
		textCoords = {x = 445.5481, y = -978.0731, z = 36.02956},
		authorizedJobs = { 'policeoffice' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = 0.0
	},
	{-- (Överintendent)
		objName = 'prop_ld_bankdoors_02',
		objCoords  = {x = 448.7605, y = -978.0731, z = 36.02956},
		textCoords = {x = 449.8605, y = -978.0731, z = 36.02956},
		authorizedJobs = { 'policeoffice' },
		size = 0.3,
		locked = true,
		distance = 2,
		heading = 0.0
	},
	
------Polisstation Sandy------

    {-- Entré dörr
	 objName = 'v_ilev_shrfdoor',
	 objCoords  = {x = 1855.105, y = 3683.516, z = 34.266},
	 textCoords = {x = 1854.813, y = 3683.303, z = 35.286},
	 authorizedJobs = { 'policecard' },
	 size = 0,9,
	 distance = 1,7,
	 locked = true,
	 heading = 34.29
    },
    {-- Cell 1
	 objName = 'v_ilev_ph_cellgate',
	 objCoords  = {x = 1848.513, y = 3681.458, z = 34.286},
	 textCoords = {x = 1848.513, y = 3681.458, z = 35.286},
	 authorizedJobs = { 'policecard' },
	 size = 0.5,
	 distance = 1.5,
	 locked = false,
	 heading = 180.0
    },
	{-- Cell 2
	 objName = 'v_ilev_ph_cellgate',
	 objCoords  = {x = 1846.230, y = 3685.170, z = 34.290},
	 textCoords = {x = 1846.513, y = 3685.200, z = 35.286},
	 authorizedJobs = { 'policecard' },
	 size = 0.5,
	 distance = 1.5,
	 locked = false,
	 heading = 299.23
	},
	{-- Vid Colamaskinen
	 objName = 'v_ilev_ph_gendoor004',
	 objCoords  = {x = 1848.986, y = 3690.347, z = 34.286},
	 textCoords = {x = 1848.986, y = 3690.347, z = 35.286},
	 authorizedJobs = { 'policecard' },
	 size = 0.5,
	 distance = 1.5,
	 locked = true,
	 heading = 31.80
	},
	{-- Höger om disken
	 objName = 'v_ilev_ph_gendoor004',
	 objCoords  = {x = 1856.935, y = 3689.418, z = 34.286},
	 textCoords = {x = 1856.935, y = 3689.418, z = 35.286},
	 authorizedJobs = { 'policecard' },
	 size = 0.5,
	 distance = 1.5,
	 locked = true,
	 heading = 38.73
	},
	{-- In till cellerna
		objName = 'v_ilev_ph_gendoor004',
		objCoords  = {x = 1851.253, y = 3683.222, z = 34.286},
		textCoords = {x = 1851.253, y = 3683.222, z = 35.286},
		authorizedJobs = { 'policecard' },
		size = 0.5,
		distance = 1.5,
		locked = true,
		heading = 128.05
	},
	{-- Till omklädningsrum från cellerna
	 objName = 'v_ilev_ph_gendoor004',
	 objCoords  = {x = 1845.890, y = 3688.473, z = 34.286},
	 textCoords = {x = 1845.890, y = 3688.473, z = 35.286},
	 authorizedJobs = { 'policecard' },
	 size = 0.5,
	 distance = 1.5,
	 locked = true,
	 heading = 36.88
	},
    {-- Omklädningsrum
	 objName = 'v_ilev_ph_gendoor004',
	 objCoords  = {x = 1843.445, y = 3691.287, z = 34.286},
	 textCoords = {x = 1843.445, y = 3691.287, z = 35.286},
	 authorizedJobs = { 'policecard' },
	 size = 0.5,
	 distance = 1.5,
	 locked = true,
	 heading = 304.92
	},

------Nattklubb------	

	{-- VIP dörr
		objName = 'ba_prop_door_club_generic_vip',
		objCoords  = {x = -1607.52, y = -3006.08, z = -75.21},
		textCoords = {x = -1607.36, y = -3006.11, z = -75.05},
		authorizedJobs = { 'nightcard' },
		size = 0.3,
		locked = true,
		heading = 269.0
	},
	{-- VIP område Glassdörr
		objName = 'ba_prop_door_club_glass',
		objCoords  = {x = -1614.37, y = -3008.45, z = -75.21},
		textCoords = {x = -1614.37, y = -3008.45, z = -75.21},
		authorizedJobs = { 'nightcard' },
		size = 0.3,
		locked = true,
		heading = 136.0
	},
	{-- Dörr vid WC till Förråd
		objName = 'ba_prop_door_club_glam_generic',
		objCoords  = {x = -1610.86, y = -3005.03, z = -79.01},
		textCoords = {x = -1610.86, y = -3005.03, z = -78.91},
		authorizedJobs = { 'nightcard' },
		size = 0.3,
		locked = true,
		heading = 181.0
	},
	{-- Dörr till bardisk
	 objName = 'ba_prop_door_club_glam_generic',
	 objCoords  = {x = -1583.550, y = -3005.710, z = -76.000},
	 textCoords = {x = -1583.550, y = -3005.710, z = -76.000},
	 authorizedJobs = { 'nightcard' },
	 size = 0.5,
	 distance = 1.2,
	 locked = true,
	 heading = 270.220
	},
	{-- Grind vid Gränden
	 objName = 'hei_prop_station_gate',
	 objCoords  = {x = -130.140, y = -1250.870, z = 29.780},
	 textCoords = {x = -130.570, y = -1253.360, z = 29.720},
	 authorizedJobs = { 'nightcard' },
	 size = 0.5,
	 distance = 15.0,
	 locked = true,
	 heading = 90.000
	},	
	{-- Grind Baksida
     objName = 'hei_prop_station_gate',
	 objCoords  = {x = -182.566, y = -1293.060, z = 30.400},
	 textCoords = {x = -185.310, y = -1292.69, z = 31.80},
	 authorizedJobs = { 'nightcard' },
	 size = 0.5,
	 distance = 15.0,
	 locked = true,
	 heading = 360.000
	},	
	

--------Klubblokaler--------------------

-- Grimknights
	{-- Entré dörr
		objName = 'v_ilev_lostdoor',
		objCoords  = {x = 981.66, y = -103.4, z = 74.82},
		textCoords = {x = 981.66, y = -102.74, z = 75.45},
		authorizedJobs = { 'hacard' },
		size = 0.3,
		locked = true,
		heading = 44.0
	},

------Byggnader övrigt------------------

--Ranchen
	{-- Entré dörr
	 objName = 'v_ilev_ra_door4l',
	 objCoords  = {x = 1395.930, y = 1141.390, z = 114.640},
	 textCoords = {x = 1395.930, y = 1141.390, z = 114.640},
	 authorizedJobs = { 'policecard' },
	 size = 0.5,
	 distance = 1.5,
	 locked = true,
	 heading = 269.520
	},
	{
	 objName = 'v_ilev_ra_door4r',
	 objCoords  = {x = 1395.940, y = 1142.19, z = 114.650},
	 textCoords = {x = 1395.940, y = 1142.19, z = 114.650},
	 authorizedJobs = { 'policecard' },
	 size = 0.5,
	 distance = 1.5,
	 locked = true,
	 heading = 90.650
	},





































}