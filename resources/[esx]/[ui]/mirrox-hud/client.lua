--Traction Control
RegisterNetEvent('tc')
    AddEventHandler('tc', function()
        if tc == true then
            tc = false
            TC()
        else
            tc = true
            TC()
        end
    end)

function TC()
playerped = GetPlayerPed(-1)
local veh = GetVehiclePedIsIn(playerped,false)
local drivebias = GetVehicleHandlingFloat(veh,"CHandlingData", "fDriveBiasFront")
local tcOn = false

oldvalue = GetVehicleHandlingFloat(vehicle,'CHandlingData','fLowSpeedTractionLossMult')     
repeat
Wait(0)
if IsPedGettingIntoAVehicle(playerped) then
Wait(2000)
veh =   GetVehiclePedIsIn(playerped,false)
drivebias = GetVehicleHandlingFloat(veh,"CHandlingData", "fDriveBiasFront")
oldvalue = GetVehicleHandlingFloat(vehicle,'CHandlingData','fLowSpeedTractionLossMult') 
end


if IsPedInAnyVehicle and not IsPedOnAnyBike(playerped) then
    if tcacting == true then
    --  SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',newvalue5)  
    --SetVehicleEngineTorqueMultiplier(veh, var1)
    else
    SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',oldvalue)   
    SetVehicleEngineTorqueMultiplier(veh, 1.0)
    end
var1 = 1.0      
mod1 = 0.0  
newvalue5 = oldvalue

tcacting = false    


wh1 = GetVehicleWheelSpeed(veh,0)
wh1 = (GetVehicleWheelSpeed(veh,1) + wh1) / 2 
wh2 = (GetVehicleWheelSpeed(veh,1) + wh1) / 2 
wh3 = GetVehicleWheelSpeed(veh,2)
wh4 = GetVehicleWheelSpeed(veh,3) 
throttle = 0.0 
wheelave = (GetVehicleWheelSpeed(veh,0) + GetVehicleWheelSpeed(veh,1) + GetVehicleWheelSpeed(veh,2) + GetVehicleWheelSpeed(veh,3)) / 4
steerang = GetVehicleSteeringAngle(veh)
    if steerang > 1 then
    mod1 = steerang / 20
    elseif steerang < -1.0 then
    steerang = steerang - steerang*2
    mod1 = steerang / 20
    end
    if wh1 > (wheelave + 0.05 + mod1) then
    var1 = 1.0 / ((wh1 - (wheelave + 0.00 + mod1) )- 0.04) *0.1
    newvalue5 = oldvalue * var1
    tcacting = true
    elseif  wh2 > (wheelave + 0.05 + mod1) then
    var1 = 1.0 / ((wh2 - (wheelave + 0.00 + mod1) )- 0.04) *0.1
    newvalue5 = oldvalue * var1 
    tcacting = true
    elseif  wh3 > (wheelave + 0.05 + mod1) then
    var1 = 1.0 / ((wh3 - (wheelave + 0.00 + mod1) )- 0.04) *0.1
    newvalue5 = oldvalue * var1
    tcacting = true
    elseif  wh4 > (wheelave + 0.05 + mod1) then
    var1 = 1.0 / ((wh4 - (wheelave + 0.00 + mod1) )- 0.04) *0.1
    newvalue5 = oldvalue * var1
    tcacting = true
    end
    if tcacting == true then
        if newvalue5 > 0.0 and newvalue5 < oldvalue  then
        SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',newvalue5)
        newvalue5 = oldvalue * var1
        elseif newvalue5 > oldvalue then
        newvalue5 = oldvalue * var1
        SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',newvalue5)
        elseif newvalue5 < 0.0 then
        newvalue5 = 0.01
        SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',newvalue5)
        end
        if var1 < 1.0 then
        SetVehicleEngineTorqueMultiplier(veh, var1)
            if var1 < 0.98 then
            end
            if var1 < 0.7 then
            end
            if var1 < 0.5 then
            end
            if var1 < 0.3 then
            end
            if var1 < 0.2 then
            end
        else
        var1 = 1.0
        SetVehicleEngineTorqueMultiplier(veh, var1)
        end

    end
end
until tc == false
SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',oldvalue)
Wait(500)
end
--[[
local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false
local playerPed = GetPlayerPed(-1)	

IsCar = function(veh)
		    local vc = GetVehicleClass(veh)
		    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end	

Fwv = function (entity)
		    local hr = GetEntityHeading(entity) + 90.0
		    if hr < 0.0 then hr = 360.0 + hr end
		    hr = hr * 0.0174533
		    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end

Citizen.CreateThread(function()
	Citizen.Wait(500)
	while true do
		
		local ped = GetPlayerPed(-1)
		local car = GetVehiclePedIsIn(ped)
		
		if car ~= 0 and (wasInCar or IsCar(car)) then
		
			wasInCar = true
			
			if beltOn then DisableControlAction(0, 75) end
			
			speedBuffer[2] = speedBuffer[1]
			speedBuffer[1] = GetEntitySpeed(car)
			
			if speedBuffer[2] ~= nil 
			   and not beltOn
			   and GetEntitySpeedVector(car, true).y > 1.0  
			   and speedBuffer[1] > 19.25
			   and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255 ) then
			   
				local co = GetEntityCoords(ped)
				local fw = Fwv(ped)
				SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
				SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
				Citizen.Wait(1)
				SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
			end
				
			velBuffer[2] = velBuffer[1]
			velBuffer[1] = GetEntityVelocity(car)
				
			if IsControlJustReleased(0, 305) then
                beltOn = not beltOn	
                if not beltOn then
                exports['mythic_notify']:SendAlert('error', ('Du tog av dig bältet.'))			  
				elseif beltOn then 
                    exports['mythic_notify']:SendAlert('success', ('Du tar på dig bältet.'))
local startTimer = GetGameTimer()
local timerMS = 2000

while (GetGameTimer() - startTimer) / timerMS * 100 < 100 do
    Citizen.Wait(0)

    DisableAllControlActions(0)
end
 end 
	end
			
		elseif wasInCar then
			wasInCar = false
			beltOn = false
			speedBuffer[1], speedBuffer[2] = 0.0, 0.0
		end
		Citizen.Wait(0)
	end
end)
--]]

--Base HUD
hud = true

dir = { [0] = 'N', [90] = 'V', [180] = 'S', [270] = 'Ö', [360] = 'N'}
 
Citizen.CreateThread(function()
    while true do
        CheckClock()
        CheckPlayerPosition()
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        disableHud()
 
        local UI = GetMinimapAnchor()
        local HP = GetEntityHealth(PlayerPedId()) / 200.0
        local Armor = GetPedArmour(PlayerPedId()) / 100.0
        local Breath = GetPlayerUnderwaterTimeRemaining(PlayerId()) / 10.0
        local thirst, hunger = 0.1, 0.1
 
        if Armor > 1.0 then Armor = 1.0 end
        if hud == true then
        drawRct(UI.Left_x, UI.Bottom_y - 0.017, UI.Width, 0.028, 0, 0, 0, 255) -- Black background
        drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.015, UI.Width - 0.072 , 0.009, 88, 88, 88, 200) -- HP background
        drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.015, (UI.Width -0.072) * HP , 0.009, 48, 209, 88, 255) -- HP bar
        drawRct(UI.Left_x + 0.071 , UI.Bottom_y - 0.015, UI.Width - 0.072 , 0.009, 88, 88, 88, 200) -- Armor background
        end
           
        if hud == true and Armor > 0.0 then
            drawRct(UI.Left_x + 0.071 , UI.Bottom_y - 0.015, (UI.Width - 0.072) * Armor , 0.009, 10, 132, 255, 255) -- Armor bar
        end
 
        if hud == true and IsPedInAnyVehicle(PlayerPedId(), false) then
            local speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936)
            DisplayRadar(true) -- Activates minimap
            drawRct(UI.Left_x, UI.Bottom_y - 0.248 , UI.Width, 0.073, 0, 0, 0, 55)
            drawTxt(UI.Left_x + 0.001 , UI.Bottom_y - 0.249, 0.55, Hours .. ":" .. Minutes .. " ", 255, 255, 255, 255, 8) -- Clock
            drawTxt(UI.Left_x + 0.001 , UI.Bottom_y - 0.217 , 0.58, heading, 255, 55, 95, 255, 8) -- Heading
            drawTxt(UI.Left_x + 0.023 , UI.Bottom_y - 0.216 , 0.3, GetStreetNameFromHashKey(rua), 255, 255, 255, 255, 8) -- Street
            drawTxt(UI.Left_x + 0.023 , UI.Bottom_y - 0.199 , 0.25, Zone, 255, 255, 255, 255, 8) -- Area
           
            --drawTxt(UI.Left_x + 0.003 , UI.Bottom_y - 0.045 , 0.4, speed .. " MPH", 255, 255, 255, 255, 4) -- Speed
            if tc == true then
                drawTxt(UI.Left_x + 0.003 , UI.Bottom_y - 0.045 , 0.4, " Traction Control: ~g~PÅ", 255, 255, 255, 255, 4)
            else
                drawTxt(UI.Left_x + 0.003 , UI.Bottom_y - 0.045 , 0.4, " Traction Control: ~r~AV", 255, 255, 255, 255, 4)
            end
--            if beltOn == true then
--                drawTxt(UI.Left_x + 0.003 , UI.Bottom_y - 0.045 , 0.4, " BÄLTE: ~g~PÅ", 255, 255, 255, 255, 4)
--            else
--                drawTxt(UI.Left_x + 0.003 , UI.Bottom_y - 0.045 , 0.4, " BÄLTE: ~r~AV", 255, 255, 255, 255, 4)
--            end
            drawRct(UI.Left_x, UI.Bottom_y - 0.045 , UI.Width, 0.027, 0, 0, 0, 55)
        else
            DisplayRadar(false) -- Deactivates minimap
            if hud == true then
            drawRct(UI.Left_x, UI.Bottom_y - 0.088 , UI.Width, 0.073, 0, 0, 0, 55) -- Background
            drawTxt(UI.Left_x + 0.001 , UI.Bottom_y - 0.09 , 0.55, Hours .. ":" .. Minutes .. " ", 255, 255, 255, 255, 8) -- Clock
            drawTxt(UI.Left_x + 0.001 , UI.Bottom_y - 0.058 , 0.58, heading, 255, 55, 95, 255, 8) -- Heading
            drawTxt(UI.Left_x + 0.023 , UI.Bottom_y - 0.057 , 0.3, GetStreetNameFromHashKey(rua), 255, 255, 255, 255, 8) -- Street
            drawTxt(UI.Left_x + 0.023 , UI.Bottom_y - 0.04 , 0.25, Zone, 255, 255, 255, 255, 8) -- Area
        end
    end
		
	end
end)

function CheckClock()
    Hours = GetClockHours()
	Minutes = GetClockMinutes()

	if useMilitaryTime == false then
		if Hours == 0 or Hours == 24 then
			Hours = 12
		elseif Hours >= 13 then
			Hours = Hours - 12
		end
	end

	if Hours <= 9 then
		Hours = "0" .. Hours
	end
	if Minutes <= 9 then
		Minutes = "0" .. Minutes
	end
	for k,v in pairs(dir)do
        heading = GetEntityHeading(PlayerPedId())
        if(math.abs(heading - k) < 45)then
            heading = v
			break
		end
	end
end
 
function CheckPlayerPosition()
    pos = GetEntityCoords(PlayerPedId())
    rua, cross = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    Zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))
end

function drawRct(x,y,Width,height,r,g,b,a)
    DrawRect(x+Width/2,y+height/2,Width,height,r,g,b,a)
end

function drawTxt(x,y,scale,text,r,g,b,a,font)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function disableHud()
	HideHudComponentThisFrame(1)
	--HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(14)
	HideHudComponentThisFrame(17)
	HideHudComponentThisFrame(20)
end

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.Width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.Left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.Bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.Left_x + Minimap.Width
    Minimap.top_y = Minimap.Bottom_y - Minimap.height
    Minimap.x = Minimap.Left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end


Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      if IsPauseMenuActive() and not IsPaused then
        IsPaused = true
      SendNUIMessage({action = "toggle", show = true})
      elseif not IsPauseMenuActive() and IsPaused then
      IsPaused = false
      SendNUIMessage({action = "toggle", show = true})
      end
      if hud == false then
        SendNUIMessage({action = "toggle", show = true})
      end
    end
  end)

--Hunger/Thirst
RegisterNetEvent('ESX_FWD_UI:updateStatus')
AddEventHandler('ESX_FWD_UI:updateStatus', function(Status)
    status = Status
    SendNUIMessage({
        show = IsPauseMenuActive(),
        action = "updateStatus",
        st = Status,
    })
end)

function hideHud()
    hud = false
end

function showHud()
    hud = true
end