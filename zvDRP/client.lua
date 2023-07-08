Citizen.CreateThread(function()
    while true do
      SetDiscordAppId(Config.DiscordBot)
      SetDiscordRichPresenceAsset(Config.Icon)
      if Config.SmallIcon then
        SetDiscordRichPresenceAssetSmall(Config.Icon)
      end
  
      local players = {}
      for _, player in ipairs(GetActivePlayers()) do
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
        local StreetHash = GetStreetNameAtCoord(x, y, z)
        table.insert(players, {
          steamName = GetPlayerName(PlayerId()),
          id = GetPlayerServerId(PlayerId()),
          StreetName = GetStreetNameFromHashKey(StreetHash)
        })
      end    
  
      if #players > 0 then
        SetDiscordRichPresenceAction(0, Config.DiscordText, Config.DiscordLink)
        SetDiscordRichPresenceAction(1, Config.ServerRulesText, Config.ServerRulesLink)
        local player = players[1]
        local location
        if Config.showID then
          if Config.showLocation then
            if Config.showPlayer then
              SetRichPresence(string.format("%s | ".. Config.ID ..": %s | ".. Config.Player ..": %s | ".. Config.LocationText ..": %s", player.steamName, player.id, #players, player.StreetName))
            else
              SetRichPresence(string.format("%s | ".. Config.ID ..": %s | ".. Config.LocationText ..": %s", player.steamName, player.id, player.StreetName))
            end
          else
            if Config.showPlayer then
              SetRichPresence(string.format("%s | ".. Config.ID ..": %s | ".. Config.Player ..": %s", player.steamName, player.id, #players))
            else
              SetRichPresence(string.format("%s | ".. Config.ID ..": %s", player.steamName, player.id))
            end
          end
        else
          if Config.showLocation then
            if Config.showPlayer then
              SetRichPresence(string.format("%s | ".. Config.Player ..": %s | ".. Config.LocationText ..": %s", player.steamName, #players, player.StreetName))
            else
              SetRichPresence(string.format("%s | ".. Config.LocationText ..": %s", player.steamName, player.StreetName))
            end
          else
            if Config.showPlayer then
              SetRichPresence(string.format("%s | ".. Config.Player ..": %s", player.steamName, #players))
            else
              SetRichPresence(string.format("%s", player.steamName))
            end
          end
        end
  
  
  
      else
        ClearRichPresence()
        SetDiscordRichPresenceAssetSmallText("Test")
      end
      Citizen.Wait(5000)
    end
  end)