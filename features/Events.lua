local chatGuildEvent = CreateFrame("Frame")
chatGuildEvent:RegisterEvent("CHAT_MSG_GUILD") -- CHAT_MSG_SAY
chatGuildEvent:SetScript("OnEvent", function(self, event, message, sender, ...)

	if string.find(message, sender .. " souhaite aussi participer à l'event !") or string.find(message, sender .. " participe à l'event !") then -- Pour les joueurs en retard
		if vAGet("isStarted") == true then
			if getArrayIndex(playingUsers, sender) ~= nil then
				SendChatMessage("Nope !", "WHISPER", nil, sender)
			else
				SendChatMessage("Clé d'évènement : " .. vAGet("key"), "WHISPER", nil, sender) -- SAY
				SendChatMessage("Le Maître du Jeu sera : " .. "Soleo", "WHISPER")
				-- SendChatMessage("Date de fin maximale : " .. day .. "/06/2019 " .. endHour .. "h" .. minutes, "WHISPER")
				-- SendChatMessage(vAGet("key"), "WHISPER", nil, sender)
				playingUsers[table.getn(playingUsers) + 1] = sender
				-- MP -> CLE DEVENEMENT + DATE FIN + 
			end
		else
			SendChatMessage("Aucun event n'est en cours !", "WHISPER", nil, sender)
		end
	end
end)

-- /run for i=0, getArraySize(playingUsers) do print(playingUsers[i]) end