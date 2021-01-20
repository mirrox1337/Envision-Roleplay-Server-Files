resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX RADDNINGSTJANST'

version '1.3.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'translation/en.lua',
	'translation/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'translation/en.lua',
	'translation/sv.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'esx_billing'
}