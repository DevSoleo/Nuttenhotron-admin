SLASH_EVENT1 = "/event"
SLASH_REWARD1 = "/reward"

SlashCmdList["EVENT"] = function(msg)
	local command = split(msg, " ")

	if IsInGuild() then
		if command[1] == "start" then
			if vAGet("isStarted") == false or vAGet("isStarted") == nil then
				vASave("isStarted", true)
				
				if command[2] == nil then
		  			-- key = generate_key(10)
		  		else
		  			vASave("key", command[2])
			  			
			  		-- print("Clé d'évènement : " .. _Admin["key"])

			  		local eventDurationHours = 4

					local hour = tonumber(getServerDate("%H")) + eventDurationHours -- date("%H")
					local endHour = hour - math.floor(hour / 24) * 24
					local minutes = tonumber(getServerDate("%M")) -- date("%M")

					local day = tonumber(getServerDate("%d"))

					if endHour <= 4 then
						day = day + 1
					end

					if #tostring(day) == 1 then
						day = "0" .. tostring(day)
					end

					if #tostring(endHour) == 1 then
						endHour = "0" .. tostring(endHour)
					end

					if #tostring(minutes) == 1 then
						minutes = "0" .. tostring(minutes)
					end

		  			SendChatMessage("Clé d'évènement : " .. vAGet("key"), "GUILD") -- SAY
					SendChatMessage("Le Maître du Jeu sera : " .. "Soleo", "GUILD")
					SendChatMessage("Date de fin maximale : " .. day .. "/06/2019 " .. endHour .. "h" .. minutes, "GUILD")
		  		end
			else
		  		print("|cFFF547FF[Addon] [" .. addonName .. "] : Un event est déjà en cours !")
			end
		elseif command[1] == "stop" then
	  		if vAGet("isStarted") == true then
				vASave("isStarted", false)
				vASave("key", "")

				playingUsers = {}

				SendChatMessage("L'évènement est terminé !", "GUILD") -- SAY
			else
				print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucun event n'est en cours !")
			end
		end
	end
end

SlashCmdList["REWARD"] = function(msg)
	local command = split(msg, " ")

	if vAGet("isStarted") == false or vAGet("isStarted") == nil then
		if command[1] == "add" then
				
			local amount = tonumber(command[3])

			if command[2] ~= "gold" then
				local itemName = GetItemInfo(tonumber(command[2]))
			
				SendChatMessage(UnitName("player") .. " a ajouté x" .. amount .. " " .. itemName .. " (" .. command[2] .. ") en récompense !", "GUILD")
				
				if getArraySize(vAGet("rewards")) == nil then
					vASave("rewards", {})
					_Admin["rewards"]["0"] = {id=id, amount=amount}
				else
					_Admin["rewards"][getArraySize(vAGet("rewards"))] = {id=id, amount=amount}
				end
			else
				SendChatMessage(UnitName("player") .. " a ajouté x" .. amount .. " Pièces d'Or en récompense !", "GUILD")
			end
		elseif command[1] == "remove" then
			local amount = tonumber(command[3])

			SendChatMessage(UnitName("player") .. " a retiré une récompense.", "GUILD")
		else
			print("|cFFF547FF[Addon] [" .. addonName .. "] : Commande invalide !")
		end
	else
		print("|cFFF547FF[Addon] [" .. addonName .. "] : Un event est déjà en cours !")
	end
end