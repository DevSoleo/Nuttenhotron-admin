local chatGuildEvent = CreateFrame("Frame")
chatGuildEvent:RegisterEvent("CHAT_MSG_GUILD") -- CHAT_MSG_SAY
chatGuildEvent:SetScript("OnEvent", function(self, event, message, sender, ...)

	if string.find(message, sender .. " souhaite aussi participer à l'event !") then -- Pour les joueurs en retard
		if getArrayIndex(vAGet("playingUsers"), sender) ~= nil then
			SendChatMessage("Vous êtes déjà inscrit à l'event en cours.", "WHISPER", nil, sender)
		else
			SendChatMessage("Clé d'évènement : " .. vAGet("key"), "WHISPER", nil, sender) -- SAY
			-- SendChatMessage("Le Maître du Jeu sera : " .. "Soleo", "WHISPER")
			-- SendChatMessage("Date de fin maximale : " .. day .. "/06/2019 " .. endHour .. "h" .. minutes, "WHISPER")
			-- SendChatMessage(vAGet("key"), "WHISPER", nil, sender)
			_Admin["playingUsers"][table.getn(vAGet("playingUsers")) + 1] = sender
		end

	elseif string.find(message, sender .. " participe à l'event !") then -- Pour les joueurs à l'heure
		if getArrayIndex(vAGet("playingUsers"), sender) ~= nil then
			SendChatMessage("Vous êtes déjà inscrit à l'event en cours.", "WHISPER", nil, sender)
		else
			_Admin["playingUsers"][table.getn(vAGet("playingUsers")) + 1] = sender
		end
	end
end)