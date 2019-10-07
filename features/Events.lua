local chatGuildEvent = CreateFrame("Frame")
chatGuildEvent:RegisterEvent("CHAT_MSG_GUILD") -- CHAT_MSG_SAY
chatGuildEvent:SetScript("OnEvent", function(self, event, message, sender, ...)
	if string.find(message, "Retardataire ".. sender .. " souhaite aussi participer à l'event !") then -- Pour les joueurs en retard
		if array_search(vAGet("playingUsers"), sender) ~= nil then
			SendChatMessage("Vous êtes déjà inscrit à l'event en cours ou aucun event n'est en cours.", "WHISPER", nil, sender)
		else
			local date = ""

			if vAGet("maxTime") ~= "" and vAGet("maxTime") ~= "// :" then
				date = vAGet("maxTime") 
			else
				date = "Aucune"
			end

			local cryptedKey = vAGet("key")

			local speChars = {"µ", "$", "^", "@", "}", "#", "{", "&", "¤", "°"}

			for i=0, array_size(str_split(cryptedKey, " ")) do
			    cryptedKey = string.gsub(cryptedKey, " ", speChars[math.random(9)], 1)
			end

			local message = "Clé : " .. cryptedKey .. " - MJ : " .. vAGet("GM") .. " - Heure max : " .. date
			
			print(message)
			SendChatMessage(message, "WHISPER", nil, sender) -- SAY
			-- SendChatMessage("Date de fin maximale : " .. day .. "/06/2019 " .. endHour .. "h" .. minutes, "WHISPER")
			-- SendChatMessage(vAGet("key"), "WHISPER", nil, sender)
			-- _Admin["playingUsers"][table.getn(vAGet("playingUsers")) + 1] = sender
		end

	elseif string.find(message, sender .. " participe à l'event !") then -- Pour les joueurs à l'heure
		if array_search(vAGet("playingUsers"), sender) ~= nil then
			SendChatMessage("Vous êtes déjà inscrit à l'event en cours ou aucun event est en cours.", "WHISPER", nil, sender)
		else
			addPlayerLine(sender)
			_Admin["playingUsers"][table.getn(vAGet("playingUsers")) + 1] = sender
		end
	elseif string.find(message, "L'évènement est terminé !") then
		vASmoothClear()
	end
end)