SLASH_EVENT1 = "/event"
SLASH_GRADE1 = "/grade"

SlashCmdList["EVENT"] = function(msg)
	local command = split(msg, " ")

	if IsInGuild() then
	  	if command[1] == "start" then

	  		if _0Admin["isStarted"] == false and command[2] ~= nil then
		  		_0Admin["isStarted"] = true

		  		if command[2] == nil then
		  			-- key = generate_key(10)
		  		else
		  			_0Admin["key"] = command[2]
			  			
			  		print("Clé d'évènement : " .. _0Admin["key"])

			  		eventDurationHours = 4

					hour = tonumber(getServerDate("%H")) + eventDurationHours -- date("%H")
					endHour = hour - math.floor(hour / 24) * 24
					minutes = tonumber(getServerDate("%M")) -- date("%M")

					day = tonumber(getServerDate("%d"), base)

					if endHour <= 4 then
						day = day + 1
					end

					if #tostring(day) == 1 then
						day = "0" .. tostring(day)
					end

		  			SendChatMessage("Clé d'évènement : " .. _0Admin["key"], "GUILD") -- SAY
					SendChatMessage("Date de fin maximale : " .. day .. "/06/2019 " .. endHour .. "h" .. minutes, "GUILD")
		  		end
		  	else
		  		print("Un event est déjà en cours !")
		  	end
	  	elseif command[1] == "stop" then
	  		if _0Admin["isStarted"] == true then
				_0Admin["isStarted"] = false
				_0Admin["key"] = ""

				SendChatMessage("L'évènement est terminé !", "GUILD") -- SAY
			else
				print("Aucun event n'est en cours !")
			end
		end
	end
end

SlashCmdList["GRADE"] = function(msg)
	print(getPlayerGuildRankIndex(sender))
end