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
			
			SendChatMessage(message, "WHISPER", nil, sender) -- SAY
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
	elseif string.find(message, " a gagné ! Clé de victoire : ") then
		local vicKey = string.sub(message, -9):sub(1, -6)

		local win = false

		local atime = time()
		local keys = {}

		local alphabet = {"N", "Y", "e", "F", "g", "H", "G", "D", "a"}
		alphabet[0] = "i"

		for i=0, 5 do
			local result = ""

			local r = string.sub(tostring(atime - 3 + i), -4)
			r = str_split_chunk(r, 1)

			for i=1, 4 do
		  		result = result .. alphabet[tonumber(r[i])]
			end

			if vicKey == result then
				win = true
			end
		end

		if win then
			SendChatMessage("---- Clé de victoire valide ! :) ----", "GUILD")

			local playerId = array_search(vAGet("playingUsers"), sender)

			if playerId ~= nil then
				NuttenhAdmin.main_frame.player_list.content[playerId]:SetTextColor(0, 255, 0, 255)
				NuttenhAdmin.main_frame.player_list.content[playerId]:SetText(playerId .. ". " .. sender .. " [V]")
			end
		else
			SendChatMessage("---- Clé de victoire invalide ! T'es mauuuuvaaaaiiis Jack ! :( ----", "GUILD")
		end
	end
end)