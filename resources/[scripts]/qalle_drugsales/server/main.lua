ESX = nil

local cachedData = {}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterServerCallback("qalle_drugsales:sellDrugs", function(source, callback, pedData)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	local drugCount = player.getInventoryItem(Config.SellItem)["count"]

	if drugCount <= 0 then return callback(false) end
	if pedData["amount"] > drugCount then pedData["amount"] = drugCount end

	player.removeInventoryItem(Config.SellItem, pedData["amount"])
	player.addMoney(pedData["offer"] * pedData["amount"])

	callback(true)
end)