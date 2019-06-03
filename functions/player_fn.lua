function get_player_coords()

  -- CATA
  SetMapToCurrentZone()
  local x, y = GetPlayerMapPosition("player")

  -- BFA 
  -- local x, y = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player"):GetXY()

  local zoneText = GetZoneText()
  local subZoneText = GetSubZoneText()
  
  x = x * 100
  y = y * 100

  return {x=x, y=y, zoneText=zoneText, subZoneText=subZoneText};
end

function guildSendMessage(message)
  SendChatMessage(message, "GUILD", nil, GetUnitName("PLAYERTARGET"))
end