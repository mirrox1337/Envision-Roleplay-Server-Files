local blips = {

     {title="Starta Jakt", colour=5, id=141, x = -769.23773193359, y = 5595.6215820313, z = 33.48571395874},
     {title="Jägaren", colour=5, id=367, x = 969.16375732422, y = -2107.9033203125, z = 31.475671768188},
     --{title="Gå ut med hund", colour=48, id=80, x = -660.86297607422, y = -937.98333740234, z = 21.82924079895},
     {title="Mio", colour=40, id=78, x = 63.95, y = -1728.98, z = 28.62},
     --{title="Garage beslagta", colour=49, id=474, x = 872.64, y = -1350.50, z = 26.30},
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)