SLASH_EVENT1 = "/event"
SLASH_REWARD1 = "/reward"

function eventCommand(msg)
	local command = split(msg, " ")

	if IsInGuild() then
		if command[1] == "start" then
			if vAGet("isStarted") == false or vAGet("isStarted") == nil then
				vASave("isStarted", true)
				
				if command[2] ~= nil then
		  			vASave("key", command[2])
					vASave("playingUsers", {})
			  			
					local s = split(command[2], "_")
					local c = ""

					for i=1, getArraySize(s) do
						print(s[i])
					end

					for i,v in ipairs(s) do
					    c = c .. " " .. crypt(v)
					end

					-- On enregistre la clé
					vASave("key", c)
					-- On enregistre le MJ
					vASave("GM", UnitName("player"))

		  			SendChatMessage("Clé d'évènement : " .. c, "GUILD") -- SAY
					SendChatMessage("Le Maître du Jeu sera : " .. UnitName("player"), "GUILD")
					
					if vAGet("maxTime") ~= "" and vAGet("maxTime") ~= "// :" then
						SendChatMessage("Date maximale de fin : " .. vAGet("maxTime"), "GUILD")
					else
						SendChatMessage("Date maximale de fin : Aucune", "GUILD")
					end

					function chrono(t, num)
                        wait(t, function()
                        	if vAGet("isStarted") == true then
								SendChatMessage("---- Départ de l'évènement dans .... " .. num .. " ----", "GUILD")
		                        
		                        if num ~= 1 then
		                        	chrono(t, num - 1)
		                        else
		                        	wait(1.3, function()
										SendChatMessage("---- L'évènement Nuttenh Ayms automatisé débute ! ----", "GUILD")
		                        	end)
		                        end
                        	end
                        end)
					end

					wait(1, function()
						chrono(1.5, 5)
					end)

		  		end
			else
		  		print("|cFFF547FF[Addon] [" .. addonName .. "] : Un event est déjà en cours !")
			end
		elseif command[1] == "stop" then
	  		if vAGet("isStarted") == true then
				vASmoothClear()

				playingUsers = {}

				SendChatMessage("L'évènement est terminé !", "GUILD") -- SAY
			else
				print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucun event n'est en cours !")
			end
		end
	end
end

function rewardCommand(msg)
	local command = split(msg, " ")

	if vAGet("isStarted") == false or vAGet("isStarted") == nil then
		if command[1] == "add" then

			local amount = tonumber(command[3])

			-- La quantité doit être supérieure à 0
			if amount > 0 then				

				-- On ajoute des P.O. en récompense si le 2ème argument est égal à "gold"
				if command[2] == "gold" then
					SendChatMessage(UnitName("player") .. " a ajouté x" .. amount .. " P.O. en récompense !", "GUILD")
				else -- Sinon on ajoute un item
					local itemName = GetItemInfo(tonumber(command[2]))
				
					SendChatMessage(UnitName("player") .. " a ajouté x" .. amount .. " " .. itemName .. " (" .. command[2] .. ") en récompense !", "GUILD")
					
					if getArraySize(vAGet("rewards")) == nil then
						vASave("rewards", {})
						_Admin["rewards"]["0"] = {id=id, amount=amount}
					else
						_Admin["rewards"][getArraySize(vAGet("rewards"))] = {id=id, amount=amount}
					end
				end
			else
				print("|cFFF547FF[Addon] [" .. addonName .. "] : Commande invalide !")
			end
		elseif command[1] == "remove" then
			SendChatMessage(UnitName("player") .. " a retiré une récompense.", "GUILD")
		else
			print("|cFFF547FF[Addon] [" .. addonName .. "] : Commande invalide !")
		end
	else
		print("|cFFF547FF[Addon] [" .. addonName .. "] : Un event est déjà en cours !")
	end
end

SlashCmdList["EVENT"] = function(msg)
	eventCommand(msg)
end

SlashCmdList["REWARD"] = function(msg)
	rewardCommand(msg)
end