-- Dot

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
	'@es_extended/locale.lua',
	"config.lua",
	"client/main.lua",
	'locales/en.lua',
}

server_scripts {
	'@es_extended/locale.lua',
	"@async/async.lua",
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server/main.lua",
	'locales/en.lua',
}