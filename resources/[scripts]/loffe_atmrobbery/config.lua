Config = {}

Strings = {
    ['Item_Required'] = 'Du behöver ~r~%s~w~ för att hacka automaten !',
    ['Rob'] = '~r~[~w~G~r~] ~w~Råna',
    ['Police'] = 'NÅGON RÅNAR EN ATM!\n~INPUT_DETONATE~ SET WAYPOINT',
    ['Stole'] = 'Du kom över KR%s'
}

Config['CopsRequired'] = 4

Config['Cash'] = {
    ['Min'] = 12500,
    ['Max'] = 30000
}

Config['Item'] = {
    ['Required'] = true,
    ['Name'] = 'hacking_tool',
    ['Remove'] = true,
    ['Label'] = 'ATM scammer'
}

Config['ATM'] = {
    'prop_atm_02',
    'prop_atm_03',
    'prop_fleeca_atm'
}

Config['3DText'] = function(coords, text)
    local StringRemove = {
        '~r~',
        '~w~',
        '~y~',
        '~b~',
        '~g~'
    }

    local OnScreen, x, y = World3dToScreen2d(table.unpack(coords))
    if OnScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x, y)
        for k, v in pairs(StringRemove) do
            text = text:gsub(v, '')
        end
        DrawRect(x, y + 0.0125, 0.015 + string.len(text) / 370, 0.03, 45, 45, 45, 150)
    end
end