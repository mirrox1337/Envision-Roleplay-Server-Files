fx_version 'adamant'
game 'gta5'

description 'ESX Advanced Garage'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'client/utils.lua',
	'config.lua',
	'client/main.lua',
	'client/vehicle_names.lua'
}

dependencies {
	'es_extended',
	'esx_vehicleshop',
}
