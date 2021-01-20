RegisterNetEvent('ESX_FWD_UI:updateStatus')
AddEventHandler('ESX_FWD_UI:updateStatus', function(Status)
    status = Status
    SendNUIMessage({
        show = IsPauseMenuActive(),
        action = "updateStatus",
        st = Status,
    })
end)