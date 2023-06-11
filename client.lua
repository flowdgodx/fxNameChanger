local QBCore = exports['qb-core']:GetCoreObject()

-- Open the Change Name Menu
RegisterNetEvent('fxNameChanger:OpenMenu', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ 
        action = 'openMenu'
    })
end)

-- Callack to get the info from the UI
RegisterNUICallback("action", function(data, cb)

    if data.action == "close" then
        SetNuiFocus(false, false)

    elseif data.action == "changeName" then
        TriggerServerEvent('fxNameChanger:changeName', data.citizenID, data.firstname, data.lastname)
    end 
end)

-- Close the Menu
RegisterNetEvent('fxNameChanger:closeMenu', function()
    SetNuiFocus(false, false)
    SendNUIMessage({ 
        action = 'closeMenu'
    })
end)


RegisterNetEvent("fxNameChanger:changeName")
AddEventHandler("fxNameChanger:changeName", function(citizenid, newFirstName, newLastName)

    TriggerServerEvent('fxNameChanger:changeName', citizenid, newFirstName, newLastName)

end)