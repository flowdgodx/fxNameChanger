# fxNameChanger
Name Changer for FiveM - QBCore

Add this event into your qb-core/server/player.lua before `function self.Functions.SetPlayerData(key, val) .. end`:
```lua
    function self.Functions.SetName(firstname, lastname)
        self.PlayerData.charinfo.firstname = firstname
        self.PlayerData.charinfo.lastname = lastname
        self.Functions.UpdatePlayerData()
    end
```

![image](https://github.com/flowdgodx/fxNameChanger/assets/64509394/aac8bac9-df48-447d-ac74-6ddb6be13cb2)
