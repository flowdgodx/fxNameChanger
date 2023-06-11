fx_version 'cerulean'

game 'gta5'

author 'Flowd#9275'
description 'Name Changer'

lua54 'yes'

ui_page 'web/ui.html'

files {
	'web/*.*'
}

shared_scripts {
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}

client_scripts {
    'client.lua'
}