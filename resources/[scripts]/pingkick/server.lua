-- CONFIG --

-- Ping Limit
pingLimit = 1000

-- Kod --

RegisterServerEvent("checkMyPingBro")
AddEventHandler("checkMyPingBro", function()
	ping = GetPlayerPing(source)
	if ping >= pingLimit then
		DropPlayer(source, "För hög ping (Gräns: " .. pingLimit .. " Din ping: " .. ping .. ")")
	end
end)