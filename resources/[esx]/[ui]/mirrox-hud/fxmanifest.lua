fx_version 'adamant'
game 'gta5'

-- Manifest Version

ui_page "ui/ui.html"

files {
    "ui/ui.html",
    "ui/ui.css",
    "ui/ui.js"
}

-- Client Scripts
client_scripts {
	'cinemamode.lua',
	'client.lua',
}

-- Server Scripts
server_scripts {
    '@mysql-async/lib/MySQL.lua',     -- MySQL init
    'server.lua',
}

exports {
    'hideHud',
    'showHud'
}