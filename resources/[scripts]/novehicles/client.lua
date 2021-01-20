-- Density values from 0.0 to 1.0.
DensityMultiplier = 0.1
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetPedDensityMultiplierThisFrame(DensityMultiplier)
	    SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetParkedVehicleDensityMultiplierThisFrame(0.0)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
	end
end)