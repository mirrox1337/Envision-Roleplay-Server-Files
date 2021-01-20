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

---esx
local ESX 				= nil
local PlayerData 	= {}

---custom scripts
local cardOpen = false
local snoing = 0
local hasHandcuffs 			  = false
local hasNyckel 			  = false
local hasBlindfold 			  = false
local hasDyrkset			  = false
local IsDragged               = false
local hasBulletproof 		  = false

local isSearching			  = false
local isBlindfolded 		  = false
local hasEquipped = false
local playerCars = {}
local Licenses = {}
-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

--för att öppna menyn i andra scripts TriggerEvent('esx_qalle:openMenu')
RegisterNetEvent('esx_qalle:openMenu')
AddEventHandler('esx_qalle:openMenu', function()
   openMenu()
end)

--- meny f5
function openMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'f3_menu',
		{
			title    = 'Person Meny',
			align    = 'right',
			elements = {
				{label = 'Person-Handlingar', value = 'id-card'},
				{label = 'Individåtgärder', value = 'citizen'},
				{label = 'Animationer', value = 'animations'},
				{label = 'Accessoarer', value = 'mask'},
				{label = 'Kläder', value = 'clothes'},
				{label = 'Färdigheter', value = 'skills'},
				{label = 'Räkningar', value = 'rakningar'},
				{label = 'Anteckningar', value = 'notes'},
				{label = 'VD-Meny', value = 'test'},
			}
		},
		function(data, menu)
			if data.current.value == 'animations' then
				TriggerEvent('loffe_animations:openMenu')
			elseif data.current.value == 'id-card' then
		        ESX.UI.Menu.Open(
		            'default', GetCurrentResourceName(), 'id_card_menu',
		            {
		                title    = 'Identifikation',
		                align    = 'right',
		                elements = {
		                	{label = 'Arbete: ' .. PlayerData.job.label .. ' - ' .. PlayerData.job.grade_label, value = 'work'},
		                    {label = 'Kolla på din legitimation', value = 'check'},
							{label = 'Visa legitimation', value = 'show'},
							{label = 'Kolla dina Körkort', value = 'korkort'},
		                    --{label = 'Kolla dina nycklar', value = 'keys'}
		                }
		            },
		            function(data2, menu2)
		            	local action = data2.current.value
	            		if action == 'korkort' then
	            			local ownedLicenses = {}

			for i=1, #Licenses, 1 do
				ownedLicenses[Licenses[i].type] = true
			end
		
			local elements = {}
		
			if ownedLicenses['drive'] then
				table.insert(elements, {label = 'B-körkort (personbil): <span style="color:green;">JA</span>', value = 'drive_test', type = 'drive'})
			else
				table.insert(elements, {label = 'B-körkort (personbil): <span style="color:red;">NEJ</span>', value = 'drive_test', type = 'drive'})
			end
		
			if ownedLicenses['drive_bike'] then
				table.insert(elements, {label = 'A-körkort (motorcykel): <span style="color:green;">JA</span>', value = 'drive_test', type = 'drive_bike'})
			else
				table.insert(elements, {label = 'A-körkort (motorcykel): <span style="color:red;">NEJ</span>', value = 'drive_test', type = 'drive_bike'})
			end
		
			if ownedLicenses['drive_truck'] then
				table.insert(elements, {label = 'C-körkort (lastbil): <span style="color:green;">JA</span>',value = 'drive_test',type = 'drive_truck'})
			else
				table.insert(elements, {label = 'C-körkort (lastbil): <span style="color:red;">NEJ</span>',value = 'drive_test',type = 'drive_truck'})
			end
		
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Dinakörkort',
			{
				["title"] = 'Dina körkort',
				["align"] = 'right',
				["elements"] = elements
			}, function(data3, menu3)

			end, function(data3, menu3)
				menu3.close()
				OpenPersonMeny()
			end
			)  
		            	elseif action == 'work' then
				          ESX.UI.Menu.Open(
				              'default', GetCurrentResourceName(), 'remove_confirmation',
				              {
				                  title    = 'Vill du säga upp dig?',
				                  elements = {
				                      {label = 'Ja', value = 'yes'},
				                      {label = 'Nej', value = 'no'}
				                  }
				              },
				              function(data3, menu3)

			                	if data3.current.value == 'yes' then
						            TriggerServerEvent('esx_qalle_jobs:unemployed', source)
									--sendNotification('Du sa upp dig!', 'success', 5000)
									exports['mythic_notify']:SendAlert('inform', 'Du har sagt upp dig.', { ['background-color'] = '#009c10', ['color'] = '#fff' })
						            ESX.UI.Menu.CloseAll()
						            openMenu()
				          		else
						            ESX.UI.Menu.CloseAll()
						            openMenu()
				          		end                         

			              end,

		              	function(data3, menu3)
			         	   menu3.close()
									end
								)                 			            		
									elseif data2.current.value == 'check' then
										TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
									elseif data2.current.value == 'show' then
											local player, distance = ESX.Game.GetClosestPlayer()

											if distance ~= -1 and distance <= 3.0 then
												TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
											else
													--ESX.ShowNotification('Ingen i närheten')
													exports['mythic_notify']:SendAlert('inform', 'Ingen person nära.', { ['background-color'] = '#b00000', ['color'] = '#fff' })
											end
									end
							end,
							function(data2, menu2)
					menu2.close()
				end
					)
			elseif data.current.value == 'mask' then					
					ESX.UI.Menu.Open(
						
						'default', GetCurrentResourceName(), 'asccesories_menu',
						{
							title    = 'Accessoarer',
							align    = 'right',
							elements = {
								{label = 'Hjälm/Hatt På/Av', value = 'Helmet'},
								{label = 'Mask På/Av', value = 'Mask'},
								{label = 'Glasögon På/Av', value = 'Glasses'},
								{label = 'Skottsäkervest På/Av', value = 'bulletproof'},
								--{label = 'Armaccessoarer På/Av', value = 'Watches'},
								{label = 'Örhänge(n) På/Av', value = 'Ears'}
							}
						},
						function(data2, menu2)

							if data2.current.value == 'Helmet' then
							   --menu2.close()
							   local dict = "misscommon@van_put_on_masks"
								local playerped = GetPlayerPed(PlayerId())
								RequestAnimDict(dict)
								while not HasAnimDictLoaded(dict) do
								  Citizen.Wait(0)
								end
								TaskPlayAnim(playerped, dict, "put_on_mask_ps", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
								Citizen.Wait(1000)
							   SetUnsetAccessory(data2.current.value)
							   ClearPedSecondaryTask(playerped)
							end

							if data2.current.value == 'Ears' then
								--menu2.close()
							   SetUnsetAccessory(data2.current.value)
							end

							if data2.current.value == 'Glasses' then
								--menu2.close()
								local dict = "clothingspecs"
								local playerped = GetPlayerPed(PlayerId())
								RequestAnimDict(dict)
								while not HasAnimDictLoaded(dict) do
								  Citizen.Wait(0)
								end
								TaskPlayAnim(playerped, dict, "try_glasses_neutral_c", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
								Citizen.Wait(1000)
							   SetUnsetAccessory(data2.current.value)
							   ClearPedSecondaryTask(playerped)
							end

							if data2.current.value == 'Watches' then
								--menu2.close()
							   SetUnsetAccessory(data2.current.value)
							end

							if data2.current.value == 'bulletproof' then
								if hasBulletproof and not hasEquipped then
								--menu2.close()
								TriggerEvent('esx_qalle:bulletproof')
								hasEquipped = true
								elseif hasEquipped then
								TriggerEvent('esx_qalle:bulletproofoff')
								hasEquipped = false
							else
								--sendNotification('Du har ingen Skottsäkervest', 'error', 2500)
								exports['mythic_notify']:SendAlert('error', 'Du har ingen skottsäkervest.')
							end
						end

							if data2.current.value == 'Mask' then
								--menu2.close()
								local dict = "misscommon@std_take_off_masks"
								local playerped = GetPlayerPed(PlayerId())
								RequestAnimDict(dict)
								while not HasAnimDictLoaded(dict) do
								  Citizen.Wait(0)
								end
								TaskPlayAnim(playerped, dict, "take_off_mask_rds", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
								Citizen.Wait(1000)
							   SetUnsetAccessory(data2.current.value)
							   ClearPedSecondaryTask(playerped)
							end

							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
			elseif data.current.value == 'skills' then
					exports["gamz-skillsystem"]:SkillMenu()
					
			elseif data.current.value == 'clothes' then
				OpenClothesMenu()

			elseif data.current.value == 'rakningar' then
				TriggerEvent('esx_billing')

			elseif data.current.value == 'notes' then
				TriggerEvent('barbies_notes:noteMenu')

			elseif data.current.value == 'citizen' then					
					ESX.UI.Menu.Open(
						
						'default', GetCurrentResourceName(), 'citizen_menu',
						{
							title    = 'Individåtgärder',
							align    = 'right',
							elements = {
							    {label = 'Sök Igenom', value = 'search'},
								--{label = ('Lyft upp person'), value = 'lift'},
							    --{label = 'Ögonbindel', value = 'blind'},
							    {label = ('Eskotera person'),    value = 'drag'},
								{label = ('Sätt på handbojor'),    value = 'handcuff'},
 								{label = ('Ta av handbojor'),    value = 'unhandcuff'},
						    }
						},function(data2, menu2)
							  if data2.current.value == 'search' then
								exports['disc-inventoryhud']:inventoryhudSteal(closestPlayer)
								    
							  elseif data2.current.value == 'handcuff' then
								ESX.TriggerServerCallback('f3-meny:getQty', function(quantity)
									if quantity > 0 then
										local target, distance = ESX.Game.GetClosestPlayer()
										playerheading = GetEntityHeading(GetPlayerPed(-1))
										playerlocation = GetEntityForwardVector(PlayerPedId())
										playerCoords = GetEntityCoords(GetPlayerPed(-1))
										local target_id = GetPlayerServerId(target)
										if distance <= 2.0 then
											TriggerServerEvent('esx_policejob:requestarrest', target_id, playerheading, playerCoords, playerlocation)
										else
											exports['mythic_notify']:SendAlert('error', ('Du har inga handfängsel'))
										end
										else
											exports['mythic_notify']:SendAlert('error', ('Ingen person i närheten'))
									end
								end, 'handcuffs')

							  elseif data2.current.value == 'unhandcuff' then
								ESX.TriggerServerCallback('f3-meny:getQty', function(quantity)
									if quantity > 0 then
										local target, distance = ESX.Game.GetClosestPlayer()
										playerheading = GetEntityHeading(GetPlayerPed(-1))
										playerlocation = GetEntityForwardVector(PlayerPedId())
										playerCoords = GetEntityCoords(GetPlayerPed(-1))
										local target_id = GetPlayerServerId(target)
										if distance <= 2.0 then
											TriggerServerEvent('esx_policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
										else
											exports['mythic_notify']:SendAlert('error', ('Du har ingen nyckel'))
										end
										else
											exports['mythic_notify']:SendAlert('error', ('Ingen person i närheten'))
										end
									end, 'key') end
  
							  
						  end,
						  function(data2, menu2)
							  menu2.close()
						  end
					)

			elseif data.current.value == 'vehicle' then					
					ESX.UI.Menu.Open(
						
						'default', GetCurrentResourceName(), 'vehicle_menu',
						{
							title    = 'Fordonåtgärder',
							align    = 'right',
							elements = {
							    {label = 'Lås / Låsupp', value = 'lock'},
							    {label = 'Motorn', value = 'engine'},
							    {label = 'Huven', value = 'door_f'},
							    {label = 'Bakluckan', value = 'door_f2'},
							    {label = 'Bakdörrarna', value = 'door_f3'},
							    {label = 'Framdörrarna', value = 'door_f4'},
							    {label = 'Lås Hastighet', value = 'hastighet'},
						    }
						},
						function(data2, menu2)

							if data2.current.value == 'lock' then
								OpenCloseVehicle()
							end

							if data2.current.value == 'engine' then
								TriggerEvent("engine")
							end					                                       

							if data2.current.value == 'door_f' then
								TriggerEvent("hood")
							end

							if data2.current.value == 'door_f2' then
								TriggerEvent("trunk")
							end

							if data2.current.value == 'door_f3' then
								TriggerEvent("rdoors")
							end

							if data2.current.value == 'door_f4' then
								TriggerEvent("fdoors")
							end

							if data2.current.value == 'hastighet' then
							ESX.UI.Menu.Open(
						
						'default', GetCurrentResourceName(), 'citizen_menu',
						{
							title    = 'Lås Hastighetsmeny',
							elements = {
							    {label = '40', value = '40'},
							    {label = '60', value = '60'},
							    {label = '80', value = '80'},
								{label = ('100'),    value = '100'},
 								{label = ('120'),    value = '120'},
 								{label = ('Återställ'), value = '0'}
						    }
						},
						function(data2, menu2)
							if data2.current.value == '0' then
								local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
								SetEntityMaxSpeed(veh, 10000/3.65)
							else
								local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
								SetEntityMaxSpeed(veh, data2.current.value/3.65)
							end


							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
						end

							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
			elseif data.current.value == 'test' and PlayerData.job.grade_name == 'boss' then					
					ESX.UI.Menu.Open(
						
						'default', GetCurrentResourceName(), 'boss_menu',
						{
							title    = 'CEO Meny',
							align    = 'right',
							elements = {
							    {label = 'Företagskassan', 				value = 'society_money'},
								{label = 'Rekrytera [Närmaste person]', value = 'recruit_player'},
								{label = 'Sparka [Närmaste person]', 	value = 'kick_player'},
								{label = 'Befodra [Närmaste person]', 	value = 'promote_player'},
								{label = 'Degradera [Närmaste person]', value = 'demote_player'}
						    }
						},
						function(data2, menu2)

							if data2.current.value == 'society_money' then
            	            money = nil
            	            ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            		            sendNotification('Ditt företag ligger just nu på ' .. money .. ' SEK', 'success', 5500)
            	             end, PlayerData.job.name)
							end

							if data2.current.value == 'recruit_player' then
								if PlayerData.job.grade_name == 'boss' then
										local job =  PlayerData.job.name
										local grade = 0
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										--sendNotification('Ingen person nära', 'error', 2500)
										exports['mythic_notify']:SendAlert('inform', 'Ingen person nära.', { ['background-color'] = '#b00000', ['color'] = '#fff' })
									else
										TriggerServerEvent('esx_qalle:recruit_player', GetPlayerServerId(closestPlayer), job,grade)
									end
								else
									--sendNotification('Du har inte rättigheterna', 'error', 2500)
									exports['mythic_notify']:SendAlert('inform', 'Du har inte rättigheterna.', { ['background-color'] = '#b00000', ['color'] = '#fff' })
								end								
							end

							if data2.current.value == 'kick_player' then
								if PlayerData.job.grade_name == 'boss' then
										local job =  PlayerData.job.name
										local grade = 0
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										--sendNotification('Ingen person nära', 'error', 2500)
										exports['mythic_notify']:SendAlert('inform', 'Ingen person nära.', { ['background-color'] = '#b00000', ['color'] = '#fff' })
									else
										TriggerServerEvent('esx_qalle:kick_player', GetPlayerServerId(closestPlayer))
									end
								else
									--sendNotification('Du har inte rättigheterna', 'error', 2500)
									exports['mythic_notify']:SendAlert('inform', 'Du har inte rättigheterna.', { ['background-color'] = '#b00000', ['color'] = '#fff' })
								end								
							end


							if data2.current.value == 'promote_player' then
								if PlayerData.job.grade_name == 'boss' then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										--sendNotification('Ingen person nära', 'error', 2500)
										exports['mythic_notify']:SendAlert('inform', 'Ingen person nära.', { ['background-color'] = '#b00000', ['color'] = '#fff' })
									else
										TriggerServerEvent('esx_qalle:promote_player', GetPlayerServerId(closestPlayer))
									end
								else
									--sendNotification('Du har inte rättigheterna', 'error', 2500)
									exports['mythic_notify']:SendAlert('inform', 'Du har inte rättigheterna.', { ['background-color'] = '#b00000', ['color'] = '#fff' })
								end																
							end

							if data2.current.value == 'demote_player' then
								if PlayerData.job.grade_name == 'boss' then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										--sendNotification('Ingen person nära', 'error', 2500)
										exports['mythic_notify']:SendAlert('inform', 'Ingen person nära.', { ['background-color'] = '#b00000', ['color'] = '#fff' })
									else
										TriggerServerEvent('esx_qalle:demote_player', GetPlayerServerId(closestPlayer))
									end
								else
									--sendNotification('Du har inte rättigheterna', 'error', 2500)
									exports['mythic_notify']:SendAlert('inform', 'Du har inte rättigheterna.', { ['background-color'] = '#b00000', ['color'] = '#fff' })
								end
							end
							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
			elseif data.current.value == 'material' then

		 	end

		end,
		function(data, menu)
			menu.close()
		end
	)
end

RegisterNetEvent('esx_dmvschool:loadLicenses')
AddEventHandler('esx_dmvschool:loadLicenses', function(licenses)
	Licenses = licenses
end)

---sökigenommeny
function OpenBodySearchMenu(player)
	exports['disc-inventoryhud']:inventoryhudSteal(closestPlayer)
end

function openVehicleMenu()
	ESX.UI.Menu.Open(

	'default', GetCurrentResourceName(), 'vehicle_menu',
	{
		title    = 'Fordonåtgärder',
		align    = 'right',
		elements = {
		    {label = 'Bälte av/på', value = 'beltToggle'},
		    {label = 'Lås / Låsupp', value = 'lock'},
		    {label = 'Motorn', value = 'engine'},
		    {label = 'Huven', value = 'door_f'},
		    {label = 'Bakluckan', value = 'door_f2'},
		    {label = 'Bakdörrarna', value = 'door_f3'},
		    {label = 'Framdörrarna', value = 'door_f4'},
			{label = 'Lås Hastighet', value = 'hastighet'},
			{label = 'Traction Control av/på', value = 'tc'},
	    }
	},
	function(data, menu)

		if data.current.value == 'lock' then
			OpenCloseVehicle()
		end

		if data.current.value == 'engine' then
			TriggerEvent("engine")
		end

		if data.current.value == 'beltToggle' then
             beltToggle()
        end				                                       

		if data.current.value == 'door_f' then
			TriggerEvent("hood")
		end

		if data.current.value == 'door_f2' then
			TriggerEvent("trunk")
		end

		if data.current.value == 'door_f3' then
			TriggerEvent("rdoors")
		end

		if data.current.value == 'door_f4' then
			TriggerEvent("fdoors")
		end

		if data.current.value == 'tc' then
			TriggerEvent('tc')
		end

		if data.current.value == 'hastighet' then
		ESX.UI.Menu.Open(

			'default', GetCurrentResourceName(), 'hastighet',
			{
				title    = 'Lås Hastighetsmeny',
				align    = 'right',
				elements = {
				    {label = '40', value = '40'},
				    {label = '60', value = '60'},
				    {label = '80', value = '80'},
					{label = ('100'),    value = '100'},
					{label = ('120'),    value = '120'},
					{label = ('Återställ'), value = '0'}
			    }
			},
		function(data2, menu2)
			if data2.current.value == '0' then
				local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				SetEntityMaxSpeed(veh, 10000/3.65)
			else
				local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				SetEntityMaxSpeed(veh, data2.current.value/3.65)
			end


		
		end,
	function(data2, menu2)
		menu2.close()
	end
	)
	end

		
	end,
	function(data, menu)
		menu.close()
	end
	)
end

---alla grejer
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

	TriggerEvent('esx_qalle:hasNotBulletproof')
	TriggerEvent('esx_qalle:hasNotHandcuffs')
	TriggerEvent('esx_qalle:hasNotNyckel')
	TriggerEvent('esx_qalle:hasNotBlindfold')
	TriggerEvent('esx_qalle:hasNotDyrkset')
	TriggerEvent('esx_qalle:hasNotECM')

	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'handcuff' then
			if PlayerData.inventory[i].count > 0 then
				TriggerEvent('esx_qalle:hasHandcuffs')
			end
		end
	end

	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'nyckel' then
			if PlayerData.inventory[i].count > 0 then
				TriggerEvent('esx_qalle:hasNyckel')
			end
		end
	end
	
	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'blindfold' then
			if PlayerData.inventory[i].count > 0 then
				TriggerEvent('esx_qalle:hasBlindfold')
			end
		end
	end

	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'bulletproof' then
			if PlayerData.inventory[i].count > 0 then
				TriggerEvent('esx_qalle:hasBulletproof')
			end
		end
	end
	
	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'dyrkset' then
			if PlayerData.inventory[i].count > 0 then
				TriggerEvent('esx_qalle:hasDyrkset')
			end
		end
	end
end)

RegisterNetEvent('esx_qalle:hasHandcuffs')
AddEventHandler('esx_qalle:hasHandcuffs', function()
	hasHandcuffs = true
end)

RegisterNetEvent('esx_qalle:hasNotHandcuffs')
AddEventHandler('esx_qalle:hasNotHandcuffs', function()
	hasHandcuffs = false
end)

RegisterNetEvent('esx_qalle:hasBlindfold')
AddEventHandler('esx_qalle:hasBlindfold', function()
	hasBlindfold = true
end)

RegisterNetEvent('esx_qalle:hasNotBlindfold')
AddEventHandler('esx_qalle:hasNotBlindfold', function()
	hasBlindfold = false
end)

RegisterNetEvent('esx_qalle:hasDyrkset')
AddEventHandler('esx_qalle:hasDyrkset', function()
	hasDyrkset = true
end)

RegisterNetEvent('esx_qalle:hasNotDyrkset')
AddEventHandler('esx_qalle:hasNotDyrkset', function()
	hasDyrkset = false
end)

RegisterNetEvent('esx_qalle:hasBulletproof')
AddEventHandler('esx_qalle:hasBulletproof', function()
	hasBulletproof = true
end)

RegisterNetEvent('esx_qalle:hasNotBulletproof')
AddEventHandler('esx_qalle:hasNotBulletproof', function()
	hasBulletproof = false
end)

-- asccesories
function SetUnsetAccessory(accessory)
    
    ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
        local _accessory = string.lower(accessory)

        if hasAccessory then
            TriggerEvent('skinchanger:getSkin', function(skin)
                local mAccessory = -1
                local mColor = 0      
                if _accessory == "mask" then
                    mAccessory = 0
                end
                if skin[_accessory .. '_1'] == mAccessory then
                    mAccessory = accessorySkin[_accessory .. '_1']
                    mColor = accessorySkin[_accessory .. '_2']
                end
                local accessorySkin = {}
                accessorySkin[_accessory .. '_1'] = mAccessory
                accessorySkin[_accessory .. '_2'] = mColor
                TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            end)
        else
            sendNotification('Du har inte denna accessoaren', 'error', 2500)
        end

    end, accessory)
    
end

-- C O N F I G --
interactionDistance = 9.5 --The radius you have to be in to interact with the vehicle.
lockDistance = 25 --The radius you have to be in to lock your vehicle.

--  V A R I A B L E S --
engineoff = false
saved = false
controlsave_bool = false

-- E N G I N E --
IsEngineOn = true
RegisterNetEvent('engine')
AddEventHandler('engine',function() 
	local player = GetPlayerPed(-1)
	
	if (IsPedSittingInAnyVehicle(player)) then 
		local vehicle = GetVehiclePedIsIn(player,false)
		
		if IsEngineOn == true then
			IsEngineOn = false
			SetVehicleEngineOn(vehicle,false,false,false)
		else
			IsEngineOn = true
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
		end
		
		while (IsEngineOn == false) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
		end
	end
end)

-- T R U N K --
RegisterNetEvent('trunk')
AddEventHandler('trunk',function() 
	local player = GetPlayerPed(-1)
			if controlsave_bool == true then
				vehicle = saveVehicle
			else
				vehicle = GetVehiclePedIsIn(player,true)
			end
			
			local isopen = GetVehicleDoorAngleRatio(vehicle,5)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,5,0,0)
				else
				SetVehicleDoorShut(vehicle,5,0)
				end
			else

			end
end)

RegisterNetEvent('fdoors')
AddEventHandler('fdoors',function() 
	local player = GetPlayerPed(-1)
    		if controlsave_bool == true then
				vehicle = saveVehicle
			else
				vehicle = GetVehiclePedIsIn(player,true)
			end
			local isopen = GetVehicleDoorAngleRatio(vehicle,0) and GetVehicleDoorAngleRatio(vehicle,1)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,0,0,0)
				SetVehicleDoorOpen(vehicle,1,0,0)
				else
				SetVehicleDoorShut(vehicle,0,0)
				SetVehicleDoorShut(vehicle,1,0)
				end
			else

			end
end)	
-- R E A R  D O O R S --
RegisterNetEvent('rdoors')
AddEventHandler('rdoors',function() 
	local player = GetPlayerPed(-1)
    		if controlsave_bool == true then
				vehicle = saveVehicle
			else
				vehicle = GetVehiclePedIsIn(player,true)
			end
			local isopen = GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,2,0,0)
				SetVehicleDoorOpen(vehicle,3,0,0)
				else
				SetVehicleDoorShut(vehicle,2,0)
				SetVehicleDoorShut(vehicle,3,0)
				end
			else

			end
end)		

-- H O O D --
RegisterNetEvent('hood')
AddEventHandler('hood',function() 
	local player = GetPlayerPed(-1)
    	if controlsave_bool == true then
			vehicle = saveVehicle
		else
			vehicle = GetVehiclePedIsIn(player,true)
		end
			
			local isopen = GetVehicleDoorAngleRatio(vehicle,4)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,4,0,0)
				else
				SetVehicleDoorShut(vehicle,4,0)
				end
			else

			end
end)


-- notification
function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "wille",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end

--låsa / låsa upp
function OpenCloseVehicle()
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  local coords2 = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
  local vehicle = nil


  if IsPedInAnyVehicle(playerPed,  false) then
    vehicle = GetVehiclePedIsIn(playerPed, false)
  else
    vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 71 )
  end

  print(vehicle)

  if vehicle == 0 then
    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
        if targetVehicle ~= nil then
          vehicle = targetVehicle
        end
  end


  ESX.TriggerServerCallback('esx_vehiclelock:requestPlayerCars', function(isOwnedVehicle)

  
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	print (vehicleProps.plate)
	  if isOwnedVehicle then
		local locked = GetVehicleDoorLockStatus(vehicle)
		local heading = GetEntityHeading(playerPed)
		if locked == 1 then -- if unlocked
		  SetVehicleDoorsLocked(vehicle, 2)
				  PlayVehicleDoorCloseSound(vehicle, 1)
				  local dict = "anim@mp_player_intmenu@key_fob@"
				  local playerped = GetPlayerPed(PlayerId())
					  RequestAnimDict(dict)
					  while not HasAnimDictLoaded(dict) do
						Citizen.Wait(0)
					  end		  
					  exports['mythic_notify']:SendAlert('inform', 'Du har låst fordonet.')
					  --ESX.ShowNotification('Du har ~r~låst~w~ ditt fordon')
				  if not IsPedInAnyVehicle(PlayerPedId(), true) then
					  TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
  
					  Citizen.Wait(100)
						SetVehicleLights(vehicle, 2)
						Citizen.Wait(200)
						SetVehicleLights(vehicle, 1)
						Citizen.Wait(200)
						SetVehicleLights(vehicle, 2)
						Citizen.Wait(200)
						SetVehicleLights(vehicle, 1)
						Citizen.Wait(200)
						SetVehicleLights(vehicle, 2)
						Citizen.Wait(200)
						SetVehicleLights(vehicle, 0)
				  end	
		elseif locked == 2 then -- if locked
		  local dict = "anim@mp_player_intmenu@key_fob@"
				  local playerped = GetPlayerPed(PlayerId())
					  RequestAnimDict(dict)
					  while not HasAnimDictLoaded(dict) do
						Citizen.Wait(0)
					  end	
		  SetVehicleDoorsLocked(vehicle, 1)
		  PlayVehicleDoorOpenSound(vehicle, 0)
		  if not IsPedInAnyVehicle(PlayerPedId(), true) then
			  TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
		  end	
		  exports['mythic_notify']:SendAlert('inform', 'Du har låst upp fordonet.')
			--ESX.ShowNotification('Du har ~g~låst upp~w~ ditt fordon')
		  if not IsPedInAnyVehicle(playerPed,  false) then
			--SetPedIntoVehicle(playerPed, vehicle, -1)
			--TaskLeaveVehicle(playerPed, vehicle, 16)
			--SetEntityCoords(playerPed, coords.x, coords.y, coords.z-0.99, 1, 0, 0, 1)
			--SetEntityHeading(playerPed, heading)
			TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
  
			Citizen.Wait(100)
			SetVehicleLights(vehicle, 2)
			Citizen.Wait(200)
			SetVehicleLights(vehicle, 1)
			Citizen.Wait(200)
			SetVehicleLights(vehicle, 2)
			Citizen.Wait(200)
			SetVehicleLights(vehicle, 1)
			Citizen.Wait(200)
			SetVehicleLights(vehicle, 2)
			Citizen.Wait(200)
			SetVehicleLights(vehicle, 0)
			
		  end
		end
	  else
		  --sendNotification('Du har inga NYCKLAR till denna bil', 'error', 3500)
		  exports['mythic_notify']:SendAlert('error', 'Du har inga nycklar till fordonet.')
		  --ESX.ShowNotification('~r~Du har inga nycklar till fordonet.')
		  
	  end
	end, GetVehicleNumberPlateText(vehicle))
  end

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlPressed(0, Keys['F3']) then
			openMenu()
	  	end
	  	if IsControlPressed(0, Keys['M']) then
	  		openVehicleMenu()
	  	end
	end
end)

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

function getVehicleInDirection(coordFrom, coordTo)
  local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
  return vehicle
end

function beltToggle()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 8 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 13 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 14 then
    TriggerEvent('balte')
  end
    
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
  while true do

  Wait(500)
  if not IsPedInAnyVehicle(GetPlayerPed(-1),  false) then
    DecorRegister("IsBelted",  3)
      DecorSetInt(GetPlayerPed(-1), "IsBelted", 0)
    end
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(750)
        if IsPedInAnyVehicle(GetPlayerPed(-1),  false) and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 8 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 13 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) ~= 14 and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1)  or GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1)) then
          if beltep1 == false or beltep2 == false or beltep3 == false or beltep4 == false then
            balteswarning = not balteswarning
          else
            balteswarning = false
          end
        else
          balteswarning = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        numSeats = GetVehicleModelNumberOfSeats(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
      if numSeats > 0 and not IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) and DecorGetInt(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1),"IsBelted") ~= 1 then
        beltep1 = false
      else
        beltep1 = true
      end
      if numSeats > 1 and not IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) and DecorGetInt(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0),"IsBelted") ~= 1 then
        beltep2 = false
      else
        beltep2 = true
      end
      if  numSeats > 2 and not IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1) and DecorGetInt(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1),"IsBelted") ~= 1 then
        beltep3 = false
      else
        beltep3 = true
      end
      if  numSeats > 3 and not IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2) and DecorGetInt(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2),"IsBelted") ~= 1 then
        beltep4 = false
      else
        beltep4 = true
      end
    end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false) --False, allow everyone to run it

RegisterNetEvent('smerfikubrania:koszulka')
AddEventHandler('smerfikubrania:koszulka', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('smerfikubrania:spodnie')
AddEventHandler('smerfikubrania:spodnie', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['pants_1'] = 21, ['pants_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:buty')
AddEventHandler('smerfikubrania:buty', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['shoes_1'] = 34, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

function OpenClothesMenu(target)

	local elements = {}

	table.insert(elements, {label = ('Ta på dig kläderna'), value = 'ubie'})
	table.insert(elements, {label = ('Ta av dig tröjan'), value = 'tul'})
	table.insert(elements, {label = ('Ta av dig byxorna'), value = 'spo'})
	table.insert(elements, {label = ('Ta av dig skorna'), value = 'but'})
  		ESX.UI.Menu.CloseAll()	


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Clothes'),
			align    = 'right',
			elements = elements
		},
    function(data, menu)



		
		if data.current.value == 'ubie' then			
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		end)
		--ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'tul' then
		TriggerEvent('smerfikubrania:koszulka')
		--ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'spo' then
		TriggerEvent('smerfikubrania:spodnie')
		--ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'but' then
		TriggerEvent('smerfikubrania:buty')
		--ESX.UI.Menu.CloseAll()	
	  end
	end,
	  function(data, menu)
		menu.close()
	end
	)



	Citizen.CreateThread(function()
		while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "f3_menu") do
			Citizen.Wait(5)
	
			local cPlayer, cPlayerDst = ESX.Game.GetClosestPlayer()
	
			if cPlayer ~= closestPlayer then
				closestPlayer = cPlayer
			end
	
			local cPlayerPed = GetPlayerPed(closestPlayer)
	
			if DoesEntityExist(cPlayerPed) then
				DrawScriptMarker({
					["type"] = 2,
					["pos"] = GetEntityCoords(cPlayerPed) + vector3(0.0, 0.0, 1.2),
					["r"] = 0,
					["g"] = 0,
					["b"] = 255,
					["sizeX"] = 0.3,
					["sizeY"] = 0.3,
					["sizeZ"] = 0.3,
					["rotate"] = true,
					["bob"] = true
				})
			end
		end
	end)

	DrawScriptMarker = function(markerData)
		DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, markerData["bob"] and true or false, true, 2, false, false, false, false)
	end

end