Citizen.CreateThread(function()
        while true do
        --This is the Application ID (Replace this with you own)
                SetDiscordAppId(668530365765517312)

        --Here you will have to put the image name for the "large" icon.
                SetDiscordRichPresenceAsset('1024logo')--1024logo
        
                                players = {}
                for i = 0, 256 do
                        if NetworkIsPlayerActive( i ) then
                                table.insert( players, i )
                        end
                end
                SetRichPresence(#players .. " / 64"  .. " | " .. GetPlayerName(PlayerId()) .. " | ID: " .. GetPlayerServerId(PlayerId()))

        SetDiscordRichPresenceAssetText('https://discord.gg/Mugt9a3')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('fivemlogo')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('logg')--logg

        --It updates every one minute just in case.
                Citizen.Wait(60000)
        end
end)