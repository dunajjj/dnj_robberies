fx_version 'cerulean'
game 'gta5'
author "dnj"
lua54 "on"
shared_script {
    'shared/*.lua',
    '@ox_lib/init.lua'
}

server_scripts {
   -- '@dnj_sydo/protect.lua',
    'server/*.lua'
}

client_scripts {
    --'@dnj_sydo/protect.lua',
    'client/*.lua'
}
