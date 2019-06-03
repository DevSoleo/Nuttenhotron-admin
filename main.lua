SLASH_REWARD1 = "/reward"

SlashCmdList["REWARD"] = function(msg)
	local command = split(msg, " ")

	if _0Admin["isStarted"] == false then
		if command[1] == "add" then
				
			local amount = tonumber(command[3])

			if command[2] ~= "gold" then
				local itemName = GetItemInfo(tonumber(command[2]))
			
				SendChatMessage(UnitName("player") .. " a ajouté x" .. amount .. " " .. itemName .. " en récompense !", "GUILD")
			else
				SendChatMessage(UnitName("player") .. " a ajouté x" .. amount .. " Pièces d'Or en récompense !", "GUILD")
			end
		elseif command[1] == "remove" then
			local amount = tonumber(command[3])

			SendChatMessage(UnitName("player") .. " a retiré une récompense.", "GUILD")
		else
			print("|cffff0000Commande invalide !")
		end
	else
		print("|cffff0000Un event est déjà en cours !")
	end
end
		
local chatGuildEvent = CreateFrame("Frame")
chatGuildEvent:RegisterEvent("CHAT_MSG_GUILD") -- CHAT_MSG_SAY
chatGuildEvent:SetScript("OnEvent", function(self, event, message, sender, ...)
	if _0Admin["rewards"] == nil then
		_0Admin["rewards"] = {}

		_0Admin["rewards"][get_array_size(_0Admin["rewards"])] = "ok"
	else
		_0Admin["rewards"][get_array_size(_0Admin["rewards"])] = "oka"
	end
end)