-- Moves all the cars from job_vehicles table to the garage on server restart

AddEventHandler('onMySQLReady', function()

	MySQL.Sync.execute("UPDATE job_vehicles SET stored=true WHERE stored=false", {})

end)