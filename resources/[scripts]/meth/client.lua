local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
ESX = nil

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_methcar:stop')
AddEventHandler('esx_methcar:stop', function()
	started = false
	DisplayHelpText("Prokuktion stoppad...")
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('esx_methcar:stopfreeze')
AddEventHandler('esx_methcar:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)
RegisterNetEvent('esx_methcar:notify')
AddEventHandler('esx_methcar:notify', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('esx_methcar:startprod')
AddEventHandler('esx_methcar:startprod', function()
	DisplayHelpText("Startar produktion")
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	print('Startad produktion')
	ESX.ShowNotification("Produktion startad")	
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('esx_methcar:blowup')
AddEventHandler('esx_methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)
	
end)


RegisterNetEvent('esx_methcar:smoke')
AddEventHandler('esx_methcar:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 4.7, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('esx_methcar:drugged')
AddEventHandler('esx_methcar:drugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(300000)
	ClearTimecycleModifier()
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'JOURNEY' and car then
				
					if GetPedInVehicleSeat(car, -1) == playerPed then
						if started == false then
							if displayed == false then
								DisplayHelpText("Tryck ~INPUT_THROW_GRENADE~ för att börja göra droger")
								displayed = true
							end
						end
						if IsControlJustReleased(0, Keys['G']) then
							if pos.y >= 3500 then
								if IsVehicleSeatFree(CurrentVehicle, 3) then
									TriggerServerEvent('esx_methcar:start')	
									progress = 0
									pause = false
									selection = 0
									quality = 0
									
								else
									DisplayHelpText('Bilen upptagen')
								end
							else
								ESX.ShowNotification('Du är för nära stan, det funkar aldrig')
							end
							
							
							
							
		
						end
					end
					
				
				
			
			end
			
		else

				
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Produktion stoppad')
					FreezeEntityPosition(LastCar,false)
				end
		end
		
		if started == true then
			
			if progress < 96 then
				Citizen.Wait(6000)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					ESX.ShowNotification('Producerar Meth: ' .. progress .. '%')
					Citizen.Wait(6000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Propantanken läcker,vad gör du?')	
						--ESX.ShowNotification('1. Laga med silvertejp')
						--ESX.ShowNotification('2. Gör ingenting ')
						--ESX.ShowNotification('3. Byt ut den')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Har du tur håller det')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Propantanken smällde, du fuckade upp...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Avbröt')
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Bra jobbat, den var sliten')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Du spillde en flaska Aceton på golvet, vad gör du?')	
						--ESX.ShowNotification('1. Öppna fönstret för att få bort lukten')
						--ESX.ShowNotification('2. Låt det vara')
						--ESX.ShowNotification('3. Sätt på dig en gasmask')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Du öppnade fönstret')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Du blev hög av exetonlukten')
						pause = false
						TriggerEvent('esx_methcar:drugged')
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Det är ju också en lösning')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Det stelnar för fort, vad gör du? ')	
						--ESX.ShowNotification('1. Höj trycket')
						--ESX.ShowNotification('2. Höj temperaturen')
						--ESX.ShowNotification('3. Sänk trycket')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Inte bra propanet börjar försvinna, du sänkte igen')
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Bra, det hjälpte...')
						quality = quality + 5
						pause = false
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Du gjorde det bara värre nu...')
						pause = false
						quality = quality -4
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Du hade på för mycket aceton,vad gör du?')	
						--ESX.ShowNotification('1. Ingenting')
						--ESX.ShowNotification('2. Försöker suga ut det med en spruta')
						--ESX.ShowNotification('3. Adderar mer lithium')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Det luktar inte så mycket aceton om knarket')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Det funka men det är fortfarande för mycket')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Snyggt, bra balans igen')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Du hittade lite färgat vatten, vad gör du?')	
						--ESX.ShowNotification('1. Addera')
						--ESX.ShowNotification('2. Kasta iväg')
						--ESX.ShowNotification('3. Drick det')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Bra ide, folk gillar färger')
						quality = quality + 4
						pause = false
					end
					if selection == 2 then
						print("Valde 1 2")
						ESX.ShowNotification('Bra, det kan förstöra smaken')
						pause = false
					end
					if selection == 3 then
						print("Valde 1 3")
						ESX.ShowNotification('Du är ett weirdo men det är okej')
						pause = false
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Filtret är igensatt,vad gör du?')	
						--ESX.ShowNotification('1. Gör rent med tryckluft')
						--ESX.ShowNotification('2. Byt ut filtret')
						--ESX.ShowNotification('3. Gör rent med en tandborste')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Jävligt dumt, du fick massa på dig')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Det var nog lika bra att byta')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Det funka ganska bra men är fortfarande skitig')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 5
				--
				if progress > 58 and progress < 60 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Du spillde en flaska Aceton på golvet, vad gör du?')	
						--ESX.ShowNotification('1. Öppna fönstret för att få bort lukten')
						--ESX.ShowNotification('2. Låt det vara')
						--ESX.ShowNotification('3. Sätt på dig en gasmask')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Luktar inte lika mycket nu')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Du andas in för mycket och blir hög')
						pause = false
						TriggerEvent('esx_methcar:drugged')
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Quickfix, bra')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 1 - 6
				--
				if progress > 63 and progress < 65 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Propantanken läcker,vad gör du?')	
						--ESX.ShowNotification('1. Laga med silvertejp')
						--ESX.ShowNotification('2. Gör ingenting ')
						--ESX.ShowNotification('3. Byt ut den')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Det gick sådär')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Propantanken sprängs, idiot...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Stoppar tillverkning')
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Bra, den var helt slut')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 4 - 7
				--
				if progress > 71 and progress < 73 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Filtret är igensatt,vad gör du?')	
						--ESX.ShowNotification('1. Gör rent med tryckluft')
						--ESX.ShowNotification('2. Byt ut filtret')
						--ESX.ShowNotification('3. Gör rent med en tandborste')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Sämsta tänkbara')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Bra ide')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('fortfarande smutsig')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 8
				--
				if progress > 76 and progress < 78 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Du hade på för mycket aceton,vad gör du?')	
						--ESX.ShowNotification('1. Ingenting')
						--ESX.ShowNotification('2. Försöker suga ut det med en spruta')
						--ESX.ShowNotification('3. Adderar mer lithium')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Drogerna luktar helvete')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Funka typ men inge bra')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Du lyckades balansera det, snyggt')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Du måste skita,vad gör du?')	
						--ESX.ShowNotification('1. Håll dig')
						--ESX.ShowNotification('2. Gå ut o skit')
						--ESX.ShowNotification('3. Skit i bilen')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Smart, skita kan du göra sen')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Du välter en flaska när du ska gå ut,mupp...')
						pause = false
						quality = quality - 2
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Allt luktar skit nu')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = false
					if selection == 0 then
						--ESX.ShowNotification('Adderar du glas för att fylla ut grejerna?')	
						--ESX.ShowNotification('1. Ja!')
						--ESX.ShowNotification('2. Nej')
						--ESX.ShowNotification('3. Vad händer om jag gör tvärtom?')
						--ESX.ShowNotification('Vad väljer du att göra?')
					end
					if selection == 1 then
						print("Valde 1")
						ESX.ShowNotification('Du fick ut lite till')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Valde 2")
						ESX.ShowNotification('Bra, du göra finfint meth, det gillar knarkarna')
						pause = false
						quality = quality + 1
					end
					if selection == 3 then
						print("Valde 3")
						ESX.ShowNotification('Det är mer glas än meth')
						pause = false
						quality = quality - 1
					end
				end
				
				
				
				
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('esx_methcar:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = progress +  math.random(1, 2)
						ESX.ShowNotification('Meth produktion: ' .. progress .. '%')
					end
				else
					TriggerEvent('esx_methcar:stop')
				end

			else
				TriggerEvent('esx_methcar:stop')
				progress = 100
				ESX.ShowNotification('Meth produktion: ' .. progress .. '%')
				ESX.ShowNotification('Du är klar')
				TriggerServerEvent('esx_methcar:finish', quality)
				FreezeEntityPosition(LastCar, false)
			end	
			
		end
		
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Stannade producering')
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['1']) then
				selection = 1
				ESX.ShowNotification('Valde 1')
			end
			if IsControlJustReleased(0, Keys['2']) then
				selection = 2
				ESX.ShowNotification('Valde 2')
			end
			if IsControlJustReleased(0, Keys['3']) then
				selection = 3
				ESX.ShowNotification('Valde 3')
			end
		end

	end
end)