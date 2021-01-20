vcf_files = {
	"SHERIFF.xml",
    "sheriff2.xml",
    "fbi.xml",
    "FBI2.xml",
    "ambulance.xml",
    "ambulance1.xml",
    "ambulance2.xml",
    "ambulance3.xml",
    "ambulance4.xml",
    "ambulance5.xml",
    "ambulance6.xml",
    "akutv90.xml",
    "ambulance7.xml",
    "ambulance8.xml",
    "ambulance9.xml",
    "ambulance10.xml",
    "policebef.xml",
    "ambulance11.xml",
    "ambutb1xml",
    "arbt6.xml",
    "baragre1.xml",
    "firetruk1.xml",
    "firetruk2.xml",
    "FIRETRUK3.xml",
    "firetruk4.xml",
    "firetruk5.xml",
    "firetruk6.xml",
    "firetruk7.xml",
    "firetruk8.xml",
    "ambulance6.xml",
    "msb1.xml",
    "phs1.xml",
    "POLICE.xml",
    "POLICE2.xml",
    "POLICE4.xml",
    "ambulance2.xml",
    "police5.xml",
    "police6.xml",
    "polic7.xml",
    "police8.xml",
    "police9.xml",
    "police10.xml",
    "ambulance3.xml",
    "police11.xml",
    "police12.xml",
    "police20",
    "flatbed.xml",    
    "policeb.xml",
    "policeold1.xml",
    "POLICET.xml",
    "polisboat.xml",
    "polisboat2.xml",
    "PRANGER.xml",
    "police3.xml",
    "sheriff2.xml",
    "FIRETRUK.xml",
    "speedo.xml",
    "tullv1.xml",
    "LGUARD.xml",
    "BRANDLED.xml"
}

pattern_files = {
	"WIGWAG.xml",
	"WIGWAG3.xml",
	"FAST.xml",
	"COMPLEX.xml",
	"BACKFOURTH.xml",
	"BACKFOURTH2.xml",
	"T_ADVIS_RIGHT_LEFT.xml",
	"T_ADVIS_LEFT_RIGHT.xml",
	"T_ADVIS_BACKFOURTH.xml",
	"WIGWAG5.xml"
}

modelsWithTrafficAdvisor = {
	"FBI2"
}

modelsWithFireSiren =
{
    "FIRETRUK3",
    "BRANDLED.xml",
}


modelsWithAmbWarnSiren =
{   
    "AMBULANCE",
    "FIRETRUK",
    "LGUARD",
}

stagethreewithsiren = false
playButtonPressSounds = true
vehicleStageThreeAdvisor = {
    "FBI3",
}


vehicleSyncDistance = 150
envirementLightBrightness = 0.2

build = "master"

shared = {
	horn = 86,
}

keyboard = {
	modifyKey = 132,
	stageChange = 85,
	guiKey = 243,
	takedown = 245,
	siren = {
		tone_one = 157,
		tone_two = 158,
		tone_three = 160,
		dual_toggle = 164,
		dual_one = 165,
		dual_two = 159,
		dual_three = 161,
	},
	pattern = {
		primary = 7,
		secondary = 303,
		advisor = 182,
	},
}

controller = {
	modifyKey = 73,
	stageChange = 80,
	takedown = 74,
	siren = {
		tone_one = 173,
		tone_two = 85,
		tone_three = 172,
	},
}