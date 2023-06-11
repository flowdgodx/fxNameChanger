local QBCore = exports['qb-core']:GetCoreObject()

if Config.UseCommand then
    QBCore.Commands.Add(Config.CommandName, Config.CommandNameHelp, {{name = Config.ArgumentCitizenID, help = Config.ArgumentCitizenIDHelp},{name = Config.ArgumentFirstName, help = Config.ArgumentFirstNameHelp}, {name = Config.ArgumentLastName, help = Config.ArgumentLastNameHelp}}, false, function(source, args)
        local source = source
        local Player = QBCore.Functions.GetPlayerByCitizenId(args[1]) 
        local citizenid, newFirstName, newLastName = args[1], args[2], args[3]
        
        TriggerClientEvent('fxNameChanger:changeName', source, citizenid, newFirstName, newLastName)


    end, Config.CommandPermission)

else
    QBCore.Commands.Add(Config.CommandName, Config.CommandNameHelp, {}, false, function(source)

        TriggerClientEvent('fxNameChanger:OpenMenu', source)

    end, Config.CommandPermission)
end



RegisterNetEvent('fxNameChanger:changeName', function(citizenid, newFirstName, newLastName)
    local source = source
    local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid) 

    if citizenid  ~= nil and newFirstName  ~= nil and newLastName ~= nil then
        if Player then
            local fullName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
            MySQL.Async.execute("UPDATE players SET charinfo = JSON_SET(charinfo, '$.firstname', @firstname, '$.lastname', @lastname) WHERE citizenid = @citizenid", {
                    ['@firstname'] = newFirstName,
                    ['@lastname'] = newLastName,
                    ['@citizenid'] = citizenid
                }, function(rowsChanged)
                if rowsChanged > 0 then

                    Player.Functions.SetName(newFirstName, newLastName)
                    Player.Functions.UpdatePlayerData(false)

                    if Player.Functions.GetItemByName(Config.IDCardItem) then
                        local info = Player.Functions.GetItemByName(Config.IDCardItem).info
                        Player.Functions.RemoveItem(Config.IDCardItem, 1)
                        info.firstname = newFirstName
                        info.lastname = newLastName
                        Player.Functions.AddItem(Config.IDCardItem, 1, false, info)
                    end

                    TriggerClientEvent('QBCore:Notify', source, fullName .. Config.ChangeNameSuccessOnline .. newFirstName .. ' ' .. newLastName .. '!' , 'success')
                    TriggerClientEvent('fxNameChanger:closeMenu', source)
                else
                    TriggerClientEvent('QBCore:Notify', source, Config.ChangeNameFailed, 'error')
                end
            end)
        else
            MySQL.Async.execute("UPDATE players SET charinfo = JSON_SET(charinfo, '$.firstname', @firstname, '$.lastname', @lastname) WHERE citizenid = @citizenid", {
                    ['@firstname'] = newFirstName,
                    ['@lastname'] = newLastName,
                    ['@citizenid'] = citizenid
                }, function(rowsChanged)
                if rowsChanged > 0 then

                    TriggerClientEvent('QBCore:Notify', source, Config.ChangeNameSuccessOffline .. newFirstName .. ' ' .. newLastName .. '!' , 'success')
                    TriggerClientEvent('fxNameChanger:closeMenu', source)
                else
                    TriggerClientEvent('QBCore:Notify', source, Config.ChangeNameFailed, 'error')
                end
            end)
        end
    else 
        TriggerClientEvent('QBCore:Notify', source, Config.FillEverything, 'error')
    end
end)