-- Création de la fenêtre principale
NuttenhAdmin.main_frame = CreateFrame("Frame", nil, UIParent)
NuttenhAdmin.main_frame:SetFrameStrata("BACKGROUND")
NuttenhAdmin.main_frame:SetMovable(true) -- Permet le déplacement de la fenêtre
NuttenhAdmin.main_frame:EnableMouse(true)
NuttenhAdmin.main_frame:RegisterForDrag("LeftButton") -- Définit le clic gauche comme le bouton à utiliser pour déplacer la fenêtre
NuttenhAdmin.main_frame:SetScript("OnDragStart", NuttenhAdmin.main_frame.StartMoving)  -- frame.StartMoving
NuttenhAdmin.main_frame:SetScript("OnDragStop", NuttenhAdmin.main_frame.StopMovingOrSizing) -- frame.StopMovingOrSizing
NuttenhAdmin.main_frame:SetWidth(900)
NuttenhAdmin.main_frame:SetHeight(500)
NuttenhAdmin.main_frame:SetFrameLevel(5)

NuttenhAdmin.main_frame:SetBackdrop({
	bgFile="Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile="Interface/Tooltips/UI-Tooltip-Border",
	tile=false,
	tileSize=64, 
	edgeSize=14, 
	insets={
		left=4,
		right=4,
		top=4,
		bottom=4
	}
})

NuttenhAdmin.main_frame:SetBackdropColor(0, 0, 0)
NuttenhAdmin.main_frame:SetPoint("TOP", 20, -20)

NuttenhAdmin.main_frame:Show()

-- Création du titre de la fenêtre
NuttenhAdmin.main_frame.title = NuttenhAdmin.main_frame:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.title:SetFont("Fonts\\FRIZQT__.ttf", 15)
NuttenhAdmin.main_frame.title:SetPoint("TOP", 0, -20)
NuttenhAdmin.main_frame.title:SetText("Nuttenh Admin Panel - " .. UnitName("player"))
NuttenhAdmin.main_frame.title:SetTextColor(1, 1, 1, 1)

----------------------------------------------------------------------------------------------------------
NuttenhAdmin.main_frame.infos = CreateFrame("Frame", "MainFrame_RewardsFrame", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.infos:SetWidth(245)
NuttenhAdmin.main_frame.infos:SetHeight(85)
NuttenhAdmin.main_frame.infos:SetPoint("TOPRIGHT", -40, -45)
NuttenhAdmin.main_frame.infos:SetBackdrop({
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false,
	tileSize=64, 
	edgeSize=10, 
	insets={
		left=4,
		right=4,
		top=4,
		bottom=4
	}
})

NuttenhAdmin.main_frame.infos.coords = NuttenhAdmin.main_frame.infos:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.infos.coords:SetFont("Fonts\\FRIZQT__.ttf", 12)
NuttenhAdmin.main_frame.infos.coords:SetPoint("TOPLEFT", 15, -15)
NuttenhAdmin.main_frame.infos.coords:SetText("Coordonées: x=" .. getPlayerCoords()["x"] .. " / y=75.56")
NuttenhAdmin.main_frame.infos.coords:SetTextColor(1, 1, 1, 1)


NuttenhAdmin.main_frame.infos.zoneText = NuttenhAdmin.main_frame.infos:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.infos.zoneText:SetFont("Fonts\\FRIZQT__.ttf", 12)
NuttenhAdmin.main_frame.infos.zoneText:SetPoint("TOPLEFT", 15, -35)
NuttenhAdmin.main_frame.infos.zoneText:SetText("Zone : " .. getPlayerCoords()["zone_text"])
NuttenhAdmin.main_frame.infos.zoneText:SetTextColor(1, 1, 1, 1)

NuttenhAdmin.main_frame.infos.subZoneText = NuttenhAdmin.main_frame.infos:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.infos.subZoneText:SetFont("Fonts\\FRIZQT__.ttf", 12)
NuttenhAdmin.main_frame.infos.subZoneText:SetPoint("TOPLEFT", 15, -55)
NuttenhAdmin.main_frame.infos.subZoneText:SetText("Sous-zone : " .. getPlayerCoords()["sub_zone_text"])
NuttenhAdmin.main_frame.infos.subZoneText:SetTextColor(1, 1, 1, 1)

local lastUpdate = 0
local onUpdate = CreateFrame("Frame")
onUpdate:SetScript("OnUpdate", function(self, elapsed)
    lastUpdate = lastUpdate + elapsed;

    if lastUpdate > 0.4 then

        -- Début /0.1s
		NuttenhAdmin.main_frame.infos.coords:SetText("Coordonées: x=" .. round(getPlayerCoords()["x"], 2) .. " / y=" .. round(getPlayerCoords()["y"], 2))
		NuttenhAdmin.main_frame.infos.zoneText:SetText("Zone : " .. getPlayerCoords()["zone_text"])

		if getPlayerCoords()["sub_zone_text"] == "" then
			NuttenhAdmin.main_frame.infos.subZoneText:SetText("Sous-zone : " .. getPlayerCoords()["zone_text"])
		else
			NuttenhAdmin.main_frame.infos.subZoneText:SetText("Sous-zone : " .. getPlayerCoords()["sub_zone_text"])
		end


        lastUpdate = 0;
    end
end)

-- Player List
NuttenhAdmin.main_frame.player_list = CreateFrame("Frame", "PlayerList", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.player_list:SetWidth(245)
NuttenhAdmin.main_frame.player_list:SetHeight(300)
NuttenhAdmin.main_frame.player_list:SetPoint("TOPRIGHT", -40, -140)
NuttenhAdmin.main_frame.player_list:SetBackdrop({
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false,
	tileSize=64, 
	edgeSize=10, 
	insets={
		left=4,
		right=4,
		top=4,
		bottom=4
	}
})

local bg = NuttenhAdmin.main_frame.player_list:CreateTexture(nil, "BACKGROUND") 
bg:SetAllPoints(NuttenhAdmin.main_frame.player_list) 
bg:SetTexture(0, 0, 0, 0.1) 

-- Player list scroll bar
local scrollframe = CreateFrame("ScrollFrame", nil, NuttenhAdmin.main_frame.player_list) 
scrollframe:SetPoint("TOPLEFT", 10, -10) 
scrollframe:SetPoint("BOTTOMRIGHT", -10, 10)

local texture = scrollframe:CreateTexture() 
texture:SetAllPoints() 
-- texture:SetTexture(0.5, 0.5, 0.5, 1) 
NuttenhAdmin.main_frame.player_list.scrollframe = scrollframe 

--scrollbar 
local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate") 
scrollbar:SetPoint("TOPLEFT", NuttenhAdmin.main_frame.player_list, "TOPRIGHT", -18, -18) 
scrollbar:SetPoint("BOTTOMLEFT", NuttenhAdmin.main_frame.player_list, "BOTTOMRIGHT", -18, 18) 
scrollbar:SetMinMaxValues(1, 220) 
scrollbar.scrollStep = 1
scrollbar:SetValueStep(scrollbar.scrollStep) 
scrollbar:SetValue(0) 
scrollbar:SetWidth(16) 
scrollbar:SetScript("OnValueChanged", function (self, value) 
	self:GetParent():SetVerticalScroll(value) 
end)
scrollbar.maxValue = 0

local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND") 
scrollbg:SetAllPoints(scrollbar) 
scrollbg:SetTexture(0, 0, 0, 0) 
NuttenhAdmin.main_frame.player_list.scrollbar = scrollbar

--content frame 
NuttenhAdmin.main_frame.player_list.content = CreateFrame("Frame", nil, scrollframe) 
NuttenhAdmin.main_frame.player_list.content:SetSize(250, 250) 

scrollframe:SetScrollChild(NuttenhAdmin.main_frame.player_list.content)

function getIndication(mission_type, setting)
	if mission_type == "1" then
		return "Cibler : " .. TARGETS_LIST[setting]["name"][GetLocale()]
	elseif mission_type == "2" then
		return "Trouver : " .. LOCATIONS_LIST[setting]["zoneText"][GetLocale()]
	elseif mission_type == "3" then
		return "Posséder : x" .. ITEMS_LIST[setting]["amount"] .. " " .. ITEMS_LIST[setting]["name"][GetLocale()]
	elseif mission_type == "4" then
		return "Tuer : x" .. KILL_LIST[setting]["amount"] .. " " .. KILL_LIST[setting]["name"][GetLocale()]
	end
end

function getSubIndication(mission_type, setting)
	if mission_type == "1" then
		return TARGETS_LIST[setting]["indication"]
	elseif mission_type == "2" then
		return LOCATIONS_LIST[setting]["indication"]
	elseif mission_type == "3" then
		return ITEMS_LIST[setting]["indication"]
	elseif mission_type == "4" then 
		return "Compteur : 0/" .. KILL_LIST[setting]["amount"]
	end
end

function addPlayerLine(playerName)
	local lineNumber = array_size(NuttenhAdmin.main_frame.player_list.content)

	local _, className = UnitClass(playerName)

	-- local rgb = getClassColor(className)["rgb"]

	NuttenhAdmin.main_frame.player_list.content[lineNumber] = NuttenhAdmin.main_frame.player_list.content:CreateFontString(nil, "ARTWORK")
	NuttenhAdmin.main_frame.player_list.content[lineNumber]:SetFont("Fonts\\ARIALN.ttf", 12)
	NuttenhAdmin.main_frame.player_list.content[lineNumber]:SetPoint("TOPLEFT", 0, 10 - (lineNumber * 20))
	NuttenhAdmin.main_frame.player_list.content[lineNumber]:SetText(lineNumber .. ". " .. playerName)
	-- NuttenhAdmin.main_frame.player_list.content[lineNumber]:SetTextColor(rgb["r"] / 255, rgb["g"] / 255, rgb["b"] / 255, 1)
end

-- Mission Frame
NuttenhAdmin.main_frame.missions = CreateFrame("Frame", "MainFrame_MissionFrame", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.missions:SetWidth(245)
NuttenhAdmin.main_frame.missions:SetHeight(400)
NuttenhAdmin.main_frame.missions:SetPoint("CENTER", 0, 5)
NuttenhAdmin.main_frame.missions:SetBackdrop({
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false,
	tileSize=64, 
	edgeSize=10, 
	insets={
		left=4,
		right=4,
		top=4,
		bottom=4
	}
})

-- Mission List
NuttenhAdmin.main_frame.missions.list = CreateFrame("Frame", "MissionList", NuttenhAdmin.main_frame.missions)
NuttenhAdmin.main_frame.missions.list:SetWidth(200)
NuttenhAdmin.main_frame.missions.list:SetHeight(200)
NuttenhAdmin.main_frame.missions.list:SetPoint("CENTER", 0, 0)
NuttenhAdmin.main_frame.missions.list:SetBackdrop({
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false,
	tileSize=64, 
	edgeSize=10, 
	insets={
		left=4,
		right=4,
		top=4,
		bottom=4
	}
})

local bg = NuttenhAdmin.main_frame.missions.list:CreateTexture(nil, "BACKGROUND") 
bg:SetAllPoints(NuttenhAdmin.main_frame.missions.list) 
bg:SetTexture(0, 0, 0, 0.1) 

-- Mission list scroll bar
local scrollframe = CreateFrame("ScrollFrame", nil, NuttenhAdmin.main_frame.missions.list) 
scrollframe:SetPoint("TOPLEFT", 10, -10) 
scrollframe:SetPoint("BOTTOMRIGHT", -10, 10)

local texture = scrollframe:CreateTexture() 
texture:SetAllPoints() 
-- texture:SetTexture(0.5, 0.5, 0.5, 1) 
NuttenhAdmin.main_frame.missions.list.scrollframe = scrollframe 

--scrollbar 
local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate") 
scrollbar:SetPoint("TOPLEFT", NuttenhAdmin.main_frame.missions.list, "TOPRIGHT", -20, -18) 
scrollbar:SetPoint("BOTTOMLEFT", NuttenhAdmin.main_frame.missions.list, "BOTTOMRIGHT", -20, 18) 
scrollbar:SetMinMaxValues(1, 1) 
scrollbar.scrollStep = 1
scrollbar:SetValueStep(scrollbar.scrollStep) 
scrollbar:SetValue(0) 
scrollbar:SetWidth(16) 
scrollbar:SetScript("OnValueChanged", function (self, value) 
	self:GetParent():SetVerticalScroll(value) 
end)
scrollbar.maxValue = 0
scrollbar:Hide()

local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND") 
scrollbg:SetAllPoints(scrollbar) 
scrollbg:SetTexture(0, 0, 0, 0) 
NuttenhAdmin.main_frame.missions.list.scrollbar = scrollbar 


--content frame 
NuttenhAdmin.main_frame.missions.list.content = CreateFrame("Frame", nil, scrollframe) 
NuttenhAdmin.main_frame.missions.list.content:SetSize(250, 250) 

scrollframe:SetScrollChild(NuttenhAdmin.main_frame.missions.list.content)

function addLineAdmin(text, mission_type, setting)
	local lineNumber = array_size(NuttenhAdmin.main_frame.missions.list.content)
	NuttenhAdmin.main_frame.missions.list.content[lineNumber] = NuttenhAdmin.main_frame.missions.list.content:CreateFontString(nil, "ARTWORK")
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:SetFont("Fonts\\ARIALN.ttf", 12)
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:SetPoint("TOPLEFT", 0, 15 - (lineNumber * 20))
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:SetText(lineNumber .. ". " .. tostring(text))
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:SetTextColor(1, 1, 1, 1)
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]["mission_type"] = mission_type
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]["setting"] = setting

	if lineNumber > 9 then
		NuttenhAdmin.main_frame.missions.list.scrollbar:SetMinMaxValues(1, (lineNumber - 9) * 20)
		NuttenhAdmin.main_frame.missions.list.scrollbar:Show()
		NuttenhAdmin.main_frame.missions.list.scrollbar:SetValue((lineNumber - 9) * 20)
	end
end

function removeLastLine()
	local lineNumber = array_size(NuttenhAdmin.main_frame.missions.list.content) - 1

	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:Hide()
	NuttenhAdmin.main_frame.missions.list.content[lineNumber] = nil
end

----------------------------------------------------------------------------------------------------------

local dropdownSelectNpcValues = {"Nom du PNJ"}

for o=1, array_size(TARGETS_LIST) do
	dropdownSelectNpcValues[o + 1] = TARGETS_LIST[tostring(o)]["npc_name"]
end

local dropdownSelectNpcValue = 0
local pSelectNpc = nil
pSelectNpc = CreateFrame("Frame", "DropdownSelectNpc", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectNpc.line = i
pSelectNpc:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectNpc, 150)
UIDropDownMenu_SetText(pSelectNpc, "Nom du PNJ")

UIDropDownMenu_Initialize(pSelectNpc, function(self, level, menuList)
	for i=1, array_size(dropdownSelectNpcValues) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.func = dropdownSelectNpcValues[i], i, self.SetValue

		if dropdownSelectNpcValue == i then
			info.checked = true
		end

		UIDropDownMenu_AddButton(info)
	end
end)

function pSelectNpc:SetValue(value)
	UIDropDownMenu_SetText(pSelectNpc, dropdownSelectNpcValues[value])
	dropdownSelectNpcValue = value
	local v = value - 1
	pSelectNpc.value = v

	-- add2Key(r, v, 1)

	CloseDropDownMenus()
end

pSelectNpc:Hide()

----------------------------------------------------------------------------------------------------------

local dropdownSelectZoneValues = {"Type de mission :"}

for o=1, array_size(LOCATIONS_LIST) do
	dropdownSelectZoneValues[o + 1] = LOCATIONS_LIST[tostring(o)]["location_name"]
end

local dropdownSelectZoneValue = 0
local pSelectZone = nil
pSelectZone = CreateFrame("Frame", "DropdownSelectZone", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectZone.line = i
pSelectZone:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectZone, 150)
UIDropDownMenu_SetText(pSelectZone, "Lieu")

UIDropDownMenu_Initialize(pSelectZone, function(self, level, menuList)
	for i=1, array_size(dropdownSelectZoneValues) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.func = dropdownSelectZoneValues[i], i, self.SetValue

		if dropdownSelectZoneValue == i then
			info.checked = true
		end

		UIDropDownMenu_AddButton(info)
	end
end)

function pSelectZone:SetValue(value)
	UIDropDownMenu_SetText(pSelectZone, dropdownSelectZoneValues[value])
	dropdownSelectZoneValue = value
	local v = value - 1
	pSelectZone.value = v

	CloseDropDownMenus()
end

pSelectZone:Hide()

----------------------------------------------------------------------------------------------------------

local missions_types = {"Type de mission", "Cibler", "Trouver", "Posséder", "Tuer", "Répondre", "Mini-Jeux"}

-- Création du menu déroulant
local pSelectMissionType = CreateFrame("Frame", "DropdownMissionType", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectMissionType:SetPoint("TOP", 0, -20)
UIDropDownMenu_SetWidth(pSelectMissionType, 150)
UIDropDownMenu_SetText(pSelectMissionType, "Type de mission")
pSelectMissionType.value = 0
pSelectMissionType.text = "Type de mission"

-- Ajout des options au menu déroulant
UIDropDownMenu_Initialize(pSelectMissionType, function(self, level, menuList)
	for i=1, array_size(missions_types) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.func = missions_types[i], i, self.SetValue

		if pSelectMissionType.value == i - 1 then
			info.checked = true
		end

		UIDropDownMenu_AddButton(info)
	end
end)

----------------------------------------------------------------------------------------------------------

local dropdownSelectItemValues = {"Item"}

for o=1, array_size(ITEMS_LIST) do
	dropdownSelectItemValues[o + 1] = "x" .. ITEMS_LIST[tostring(o)]["amount"] .. " " .. ITEMS_LIST[tostring(o)]["item_name"]
end

local dropdownSelectItemValue = 0
local pSelectItem = nil
pSelectItem = CreateFrame("Frame", "DropdownSelectItem", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectItem.line = i
pSelectItem:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectItem, 150)
UIDropDownMenu_SetText(pSelectItem, "Item")

UIDropDownMenu_Initialize(pSelectItem, function(self, level, menuList)
	for i=1, array_size(dropdownSelectItemValues) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.func = dropdownSelectItemValues[i], i, self.SetValue

		if dropdownSelectItemValue == i then
			info.checked = true
		end

		UIDropDownMenu_AddButton(info)
	end
end)

function pSelectItem:SetValue(value)
	UIDropDownMenu_SetText(pSelectItem, dropdownSelectItemValues[value])
	dropdownSelectItemValue = value
	local v = value - 1
	pSelectItem.value = v

	CloseDropDownMenus()
end

pSelectItem:Hide()

----------------------------------------------------------------------------------------------------------

local dropdownSelectMobValues = {"Mob"}

for o=1, array_size(KILL_LIST) do
	dropdownSelectMobValues[o + 1] = "x" .. KILL_LIST[tostring(o)]["amount"] .. " " .. KILL_LIST[tostring(o)]["mob_name"]
end

local dropdownSelectMobValue = 0
local pSelectMob = nil
pSelectMob = CreateFrame("Frame", "DropdownSelectMob", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectMob.line = i
pSelectMob:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectMob, 150)
UIDropDownMenu_SetText(pSelectMob, "Mob")

UIDropDownMenu_Initialize(pSelectMob, function(self, level, menuList)
	for i=1, array_size(dropdownSelectMobValues) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.func = dropdownSelectMobValues[i], i, self.SetValue

		if dropdownSelectMobValue == i then
			info.checked = true
		end

		UIDropDownMenu_AddButton(info)
	end
end)

function pSelectMob:SetValue(value)
	UIDropDownMenu_SetText(pSelectMob, dropdownSelectMobValues[value])
	dropdownSelectMobValue = value
	local v = value - 1
	pSelectMob.value = v

	CloseDropDownMenus()
end

pSelectMob:Hide()

----------------------------------------------------------------------------------------------------------

local dropdownSelectQuestionValues = {"Questions"}

for o=1, array_size(QUESTIONS_LIST) do
	dropdownSelectQuestionValues[o + 1] = QUESTIONS_LIST[tostring(o)]["question"]
end

local dropdownSelectQuestionValue = 0
local pSelectQuestion = nil
pSelectQuestion = CreateFrame("Frame", "DropdownSelectQuestion", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectQuestion.line = i
pSelectQuestion:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectQuestion, 150)
UIDropDownMenu_SetText(pSelectQuestion, "Questions")

UIDropDownMenu_Initialize(pSelectQuestion, function(self, level, menuList)
	for i=1, array_size(dropdownSelectQuestionValues) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.func = dropdownSelectQuestionValues[i], i, self.SetValue

		if dropdownSelectQuestionValue == i then
			info.checked = true
		end

		UIDropDownMenu_AddButton(info)
	end
end)

function pSelectQuestion:SetValue(value)
	UIDropDownMenu_SetText(pSelectQuestion, dropdownSelectQuestionValues[value])
	dropdownSelectQuestionValue = value
	local v = value - 1
	pSelectQuestion.value = v

	CloseDropDownMenus()
end

pSelectQuestion:Hide()

----------------------------------------------------------------------------------------------------------

local dropdownSelectGameValues = {"Mini-jeux"}

for o=1, array_size(GAMES_LIST) do
	dropdownSelectGameValues[o + 1] = GAMES_LIST[tostring(o)]["name"]
end

local dropdownSelectGameValue = 0
local pSelectGame = nil
pSelectGame = CreateFrame("Frame", "DropdownSelectGame", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectGame.line = i
pSelectGame:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectGame, 150)
UIDropDownMenu_SetText(pSelectGame, "Mini-jeux")

UIDropDownMenu_Initialize(pSelectGame, function(self, level, menuList)
	for i=1, array_size(dropdownSelectGameValues) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.func = dropdownSelectGameValues[i], i, self.SetValue

		if dropdownSelectGameValue == i then
			info.checked = true
		end

		UIDropDownMenu_AddButton(info)
	end
end)

function pSelectGame:SetValue(value)
	UIDropDownMenu_SetText(pSelectGame, dropdownSelectGameValues[value])
	dropdownSelectGameValue = value
	local v = value - 1
	pSelectGame.value = v

	CloseDropDownMenus()
end

pSelectGame:Hide()

----------------------------------------------------------------------------------------------------------

-- Cette fonction est éxécutée lorsque l'utilisateur choisit une option dans le premier menu
function pSelectMissionType:SetValue(value)
	UIDropDownMenu_SetText(pSelectMissionType, missions_types[value])
	pSelectMissionType.value = value - 1

	pSelectNpc:Hide()
	pSelectZone:Hide()
	pSelectItem:Hide()
	pSelectMob:Hide()
	pSelectQuestion:Hide()
	pSelectGame:Hide()

	if pSelectMissionType.value == 1 then
		pSelectNpc:Show()
	elseif pSelectMissionType.value == 2 then
		pSelectZone:Show()
	elseif pSelectMissionType.value == 3 then
		pSelectItem:Show()
	elseif pSelectMissionType.value == 4 then
		pSelectMob:Show()
	elseif pSelectMissionType.value == 5 then
		pSelectQuestion:Show()
	elseif pSelectMissionType.value == 6 then
		pSelectGame:Show()
	end
	CloseDropDownMenus()
end


-- Bouton ajouter une mission
NuttenhAdmin.main_frame.missions.add_button = CreateFrame("Button", "AddMissionButton", NuttenhAdmin.main_frame.missions, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.missions.add_button:SetPoint("BOTTOM", 0, 50)
NuttenhAdmin.main_frame.missions.add_button:SetHeight(25)
NuttenhAdmin.main_frame.missions.add_button:SetWidth(200)
NuttenhAdmin.main_frame.missions.add_button:SetText("Ajouter cette mission ->")

NuttenhAdmin.main_frame.missions.add_button:SetScript("OnClick", function(self)
	if pSelectMissionType.value > 0 then

		if pSelectMissionType.value == 1 then

			if pSelectNpc.value ~= nil and pSelectNpc.value ~= 0 then
				addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectNpcValues[pSelectNpc.value + 1], pSelectMissionType.value, pSelectNpc.value)
			else
				print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucune valeur n'a été saisie !")
			end

		elseif pSelectMissionType.value == 2 then

			if pSelectZone.value ~= nil and pSelectZone.value ~= 0 then
				addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectZoneValues[pSelectZone.value + 1], pSelectMissionType.value, pSelectZone.value)
			else
				print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucune valeur n'a été saisie !")
			end

		elseif pSelectMissionType.value == 3 then

			if pSelectItem.value ~= nil and pSelectItem.value ~= 0 then
				addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectItemValues[pSelectItem.value + 1], pSelectMissionType.value, pSelectItem.value)
			else
				print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucune valeur n'a été saisie !")
			end

		elseif pSelectMissionType.value == 4 then
			
			if pSelectMob.value ~= nil and pSelectMob.value ~= 0 then
				addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectMobValues[pSelectMob.value + 1], pSelectMissionType.value, pSelectMob.value)
			else
				print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucune valeur n'a été saisie !")
			end
		elseif pSelectMissionType.value == 5 then
			
			if pSelectQuestion.value ~= nil and pSelectQuestion.value ~= 0 then
				addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectQuestionValues[pSelectQuestion.value + 1], pSelectMissionType.value, pSelectQuestion.value)
			else
				print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucune valeur n'a été saisie !")
			end
		elseif pSelectMissionType.value == 6 then
			
			if pSelectGame.value ~= nil and pSelectGame.value ~= 0 then
				addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectGameValues[pSelectGame.value + 1], pSelectMissionType.value, pSelectGame.value)
			else
				print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucune valeur n'a été saisie !")
			end
		end
	end
end)

-- Bouton supprimer la dernière mission
NuttenhAdmin.main_frame.missions.remove_button = CreateFrame("Button", "RemoveMissionButton", NuttenhAdmin.main_frame.missions, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.missions.remove_button:SetPoint("BOTTOM", 0, 15)
NuttenhAdmin.main_frame.missions.remove_button:SetHeight(25)
NuttenhAdmin.main_frame.missions.remove_button:SetWidth(200)
NuttenhAdmin.main_frame.missions.remove_button:SetText("Supprimer la dernière mission")

NuttenhAdmin.main_frame.missions.remove_button:SetScript("OnClick", function(self)
	if array_size(NuttenhAdmin.main_frame.missions.list.content) - 1 > 0 then
		removeLastLine()
	end
end)

NuttenhAdmin.main_frame.gold = 0

-- Rewards Frame
NuttenhAdmin.main_frame.rewards = CreateFrame("Frame", "MainFrame_RewardsFrame", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.rewards:SetWidth(245)
NuttenhAdmin.main_frame.rewards:SetHeight(340)
NuttenhAdmin.main_frame.rewards:SetPoint("TOPLEFT", 40, -45)
NuttenhAdmin.main_frame.rewards:SetBackdrop({
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false,
	tileSize=64, 
	edgeSize=10, 
	insets={
		left=4,
		right=4,
		top=4,
		bottom=4
	}
})

NuttenhAdmin.main_frame.rewards.title = NuttenhAdmin.main_frame.rewards:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.rewards.title:SetFont("Fonts\\FRIZQT__.ttf", 12)
NuttenhAdmin.main_frame.rewards.title:SetPoint("TOP", 0, -6)
NuttenhAdmin.main_frame.rewards.title:SetText("Le vainqueur recevra :")
NuttenhAdmin.main_frame.rewards.title:SetTextColor(1, 1, 1, 1)

-- Items List
NuttenhAdmin.main_frame.rewards.items = CreateFrame("Frame", "MainFrame_RewardsFrame_ItemsList", NuttenhAdmin.main_frame.rewards)
NuttenhAdmin.main_frame.rewards.items:SetWidth(200)
NuttenhAdmin.main_frame.rewards.items:SetHeight(200)
NuttenhAdmin.main_frame.rewards.items:SetPoint("TOP", 0, -25)
NuttenhAdmin.main_frame.rewards.items:SetBackdrop({
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false,
	tileSize=64, 
	edgeSize=10, 
	insets={
		left=4,
		right=4,
		top=4,
		bottom=4
	}
})

NuttenhAdmin.main_frame.rewards.items.description = NuttenhAdmin.main_frame.rewards.items:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.rewards.items.description:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.rewards.items.description:SetPoint("BOTTOM", 0, -15)
NuttenhAdmin.main_frame.rewards.items.description:SetText("*Cliquez sur un item pour le retirer")
NuttenhAdmin.main_frame.rewards.items.description:SetTextColor(1, 1, 1, 1)

-- Affichage du nombre de P.O. à offrir au gagnant
NuttenhAdmin.main_frame.rewards.items.gold_value = NuttenhAdmin.main_frame.rewards.items:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.rewards.items.gold_value:SetFont("Fonts\\FRIZQT__.ttf", 12)
NuttenhAdmin.main_frame.rewards.items.gold_value:SetPoint("BOTTOM", 0, 20)
NuttenhAdmin.main_frame.rewards.items.gold_value:SetText(GetCoinTextureString(0))
NuttenhAdmin.main_frame.rewards.items.gold_value:SetTextColor(1, 1, 1, 1)

-- Titre pour les P.O.
NuttenhAdmin.main_frame.rewards.gold_title = NuttenhAdmin.main_frame.rewards:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.rewards.gold_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.rewards.gold_title:SetPoint("BOTTOMLEFT", 29, 15 + 7)
NuttenhAdmin.main_frame.rewards.gold_title:SetText("Nombre de pièces d'or")
NuttenhAdmin.main_frame.rewards.gold_title:SetTextColor(1, 1, 1, 1)

-- Input pour les P.O.
NuttenhAdmin.main_frame.rewards.gold_input = CreateFrame("EditBox", "MissionFrame_RewardFrame_GoldInput", NuttenhAdmin.main_frame.rewards, "InputBoxTemplate")
NuttenhAdmin.main_frame.rewards.gold_input:SetPoint("BOTTOMLEFT", 29, 15)
NuttenhAdmin.main_frame.rewards.gold_input:SetHeight(25)
NuttenhAdmin.main_frame.rewards.gold_input:SetWidth(120)
NuttenhAdmin.main_frame.rewards.gold_input:SetAutoFocus(false)

NuttenhAdmin.main_frame.rewards.gold_input:SetScript("OnTextChanged", function(self)
	if self:GetText() == "" then
		NuttenhAdmin.main_frame.rewards.gold_title:Show()
	else
		NuttenhAdmin.main_frame.rewards.gold_title:Hide()
	end

	self:SetText(string.gsub(self:GetText(), "[^%d]", ""))
end)

-- Bouton pour les P.O.
NuttenhAdmin.main_frame.rewards.gold_button = CreateFrame("Button", "MissionFrame_RewardFrame_GoldButton", NuttenhAdmin.main_frame.rewards, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.rewards.gold_button:SetPoint("BOTTOMRIGHT", -19, 15)
NuttenhAdmin.main_frame.rewards.gold_button:SetHeight(25)
NuttenhAdmin.main_frame.rewards.gold_button:SetWidth(70)
NuttenhAdmin.main_frame.rewards.gold_button:SetText("Définir")

NuttenhAdmin.main_frame.rewards.gold_button:SetScript("OnClick", function(self)
	if NuttenhAdmin.main_frame.rewards.gold_input:GetText() ~= "" and NuttenhAdmin.main_frame.rewards.gold_input:GetText() ~= "0" then
		NuttenhAdmin.main_frame.rewards.items.gold_value:SetText(GetCoinTextureString(NuttenhAdmin.main_frame.rewards.gold_input:GetText() * 10000))
		NuttenhAdmin.main_frame.gold = NuttenhAdmin.main_frame.rewards.gold_input:GetText()
	end
end)


NuttenhAdmin.main_frame.date = CreateFrame("Frame", "MainFrame_DateFrame", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.date:SetWidth(245)
NuttenhAdmin.main_frame.date:SetHeight(58)
NuttenhAdmin.main_frame.date:SetPoint("BOTTOMLEFT", 40, 55)
NuttenhAdmin.main_frame.date:SetBackdrop({
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false,
	tileSize=64, 
	edgeSize=10, 
	insets={
		left=4,
		right=4,
		top=4,
		bottom=4
	}
})

-- MEGA TITRE DATE
NuttenhAdmin.main_frame.date.title = NuttenhAdmin.main_frame.date:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.date.title:SetFont("Fonts\\FRIZQT__.ttf", 12)
NuttenhAdmin.main_frame.date.title:SetPoint("TOP", 0, -6)
NuttenhAdmin.main_frame.date.title:SetText("Date de fin de l'event :")
NuttenhAdmin.main_frame.date.title:SetTextColor(1, 1, 1, 1)


-- Texte Jour
NuttenhAdmin.main_frame.date.day_title = NuttenhAdmin.main_frame.date:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.date.day_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.date.day_title:SetPoint("BOTTOMLEFT", 15, 7 + 7)
NuttenhAdmin.main_frame.date.day_title:SetText("Jour")
NuttenhAdmin.main_frame.date.day_title:SetTextColor(1, 1, 1, 1)

-- Input : Jour
NuttenhAdmin.main_frame.date.day_input = CreateFrame("EditBox", "MissionFrame_DateFrame_DayInput", NuttenhAdmin.main_frame.date, "InputBoxTemplate")
NuttenhAdmin.main_frame.date.day_input:SetPoint("BOTTOMLEFT", 15, 7)
NuttenhAdmin.main_frame.date.day_input:SetHeight(25)
NuttenhAdmin.main_frame.date.day_input:SetWidth(40)
NuttenhAdmin.main_frame.date.day_input:SetAutoFocus(false)

NuttenhAdmin.main_frame.date.day_input:SetScript("OnTextChanged", function(self)
	if self:GetText() == "" then
		NuttenhAdmin.main_frame.date.day_title:Show()
	else
		NuttenhAdmin.main_frame.date.day_title:Hide()
	end

	self:SetText(string.gsub(self:GetText(), "[^%d]", ""))

end)

-- Texte Mois
NuttenhAdmin.main_frame.date.month_title = NuttenhAdmin.main_frame.date:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.date.month_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.date.month_title:SetPoint("BOTTOMLEFT", 63, 7 + 7)
NuttenhAdmin.main_frame.date.month_title:SetText("Mois")
NuttenhAdmin.main_frame.date.month_title:SetTextColor(1, 1, 1, 1)

-- Input : Mois
NuttenhAdmin.main_frame.date.month_input = CreateFrame("EditBox", "MissionFrame_DateFrame_MonthInput", NuttenhAdmin.main_frame.date, "InputBoxTemplate")
NuttenhAdmin.main_frame.date.month_input:SetPoint("BOTTOMLEFT", 63, 7)
NuttenhAdmin.main_frame.date.month_input:SetHeight(25)
NuttenhAdmin.main_frame.date.month_input:SetWidth(40)
NuttenhAdmin.main_frame.date.month_input:SetAutoFocus(false)

NuttenhAdmin.main_frame.date.month_input:SetScript("OnTextChanged", function(self)
	if self:GetText() == "" then
		NuttenhAdmin.main_frame.date.month_title:Show()
	else
		NuttenhAdmin.main_frame.date.month_title:Hide()
	end

	self:SetText(string.gsub(self:GetText(), "[^%d]", ""))

end)

-- Texte Année
NuttenhAdmin.main_frame.date.year_title = NuttenhAdmin.main_frame.date:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.date.year_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.date.year_title:SetPoint("BOTTOMLEFT", 111, 7 + 7)
NuttenhAdmin.main_frame.date.year_title:SetText("Année")
NuttenhAdmin.main_frame.date.year_title:SetTextColor(1, 1, 1, 1)

-- Input : Année
NuttenhAdmin.main_frame.date.year_input = CreateFrame("EditBox", "MissionFrame_DateFrame_YearInput", NuttenhAdmin.main_frame.date, "InputBoxTemplate")
NuttenhAdmin.main_frame.date.year_input:SetPoint("BOTTOMLEFT", 111, 7)
NuttenhAdmin.main_frame.date.year_input:SetHeight(25)
NuttenhAdmin.main_frame.date.year_input:SetWidth(40)
NuttenhAdmin.main_frame.date.year_input:SetAutoFocus(false)

NuttenhAdmin.main_frame.date.year_input:SetScript("OnTextChanged", function(self)
	if self:GetText() == "" then
		NuttenhAdmin.main_frame.date.year_title:Show()
	else
		NuttenhAdmin.main_frame.date.year_title:Hide()
	end

	self:SetText(string.gsub(self:GetText(), "[^%d]", ""))

end)

-- Texte Minutes
NuttenhAdmin.main_frame.date.minute_title = NuttenhAdmin.main_frame.date:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.date.minute_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.date.minute_title:SetPoint("BOTTOMRIGHT", -20	, 7 + 7)
NuttenhAdmin.main_frame.date.minute_title:SetText("Min")
NuttenhAdmin.main_frame.date.minute_title:SetTextColor(1, 1, 1, 1)

-- Input : Minutes
NuttenhAdmin.main_frame.date.minute_input = CreateFrame("EditBox", "MissionFrame_DateFrame_MinuteInput", NuttenhAdmin.main_frame.date, "InputBoxTemplate")
NuttenhAdmin.main_frame.date.minute_input:SetPoint("BOTTOMRIGHT", -15, 7)
NuttenhAdmin.main_frame.date.minute_input:SetHeight(25)
NuttenhAdmin.main_frame.date.minute_input:SetWidth(25)
NuttenhAdmin.main_frame.date.minute_input:SetAutoFocus(false)

NuttenhAdmin.main_frame.date.minute_input:SetScript("OnTextChanged", function(self)
	if self:GetText() == "" then
		NuttenhAdmin.main_frame.date.minute_title:Show()
	else
		NuttenhAdmin.main_frame.date.minute_title:Hide()
	end

	self:SetText(string.gsub(self:GetText(), "[^%d]", ""))

end)

-- Texte Heures
NuttenhAdmin.main_frame.date.hour_title = NuttenhAdmin.main_frame.date:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.date.hour_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.date.hour_title:SetPoint("BOTTOMRIGHT", -50.5, 7 + 7)
NuttenhAdmin.main_frame.date.hour_title:SetText("Heure")
NuttenhAdmin.main_frame.date.hour_title:SetTextColor(1, 1, 1, 1)

-- Input : Heures
NuttenhAdmin.main_frame.date.hour_input = CreateFrame("EditBox", "MissionFrame_DateFrame_HourInput", NuttenhAdmin.main_frame.date, "InputBoxTemplate")
NuttenhAdmin.main_frame.date.hour_input:SetPoint("BOTTOMRIGHT", -48, 7)
NuttenhAdmin.main_frame.date.hour_input:SetHeight(25)
NuttenhAdmin.main_frame.date.hour_input:SetWidth(30)
NuttenhAdmin.main_frame.date.hour_input:SetAutoFocus(false)

NuttenhAdmin.main_frame.date.hour_input:SetScript("OnTextChanged", function(self)
	if self:GetText() == "" then
		NuttenhAdmin.main_frame.date.hour_title:Show()
	else
		NuttenhAdmin.main_frame.date.hour_title:Hide()
	end

	self:SetText(string.gsub(self:GetText(), "[^%d]", ""))

end)

-- Titre pour les Items
NuttenhAdmin.main_frame.rewards.item_title = NuttenhAdmin.main_frame.rewards:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.rewards.item_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.rewards.item_title:SetPoint("BOTTOMLEFT", 29, 45 + 7)
NuttenhAdmin.main_frame.rewards.item_title:SetText("Identifiant de l'item")
NuttenhAdmin.main_frame.rewards.item_title:SetTextColor(1, 1, 1, 1)

-- Titre pour les Items
NuttenhAdmin.main_frame.rewards.amount_title = NuttenhAdmin.main_frame.rewards:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.rewards.amount_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.rewards.amount_title:SetPoint("BOTTOMLEFT", 29, 70 + 7)
NuttenhAdmin.main_frame.rewards.amount_title:SetText("Quantité")
NuttenhAdmin.main_frame.rewards.amount_title:SetTextColor(1, 1, 1, 1)

-- Input pour le nombre d'items à ajouter
NuttenhAdmin.main_frame.rewards.amount_input = CreateFrame("EditBox", "MissionFrame_RewardFrame_AmountInput", NuttenhAdmin.main_frame.rewards, "InputBoxTemplate")
NuttenhAdmin.main_frame.rewards.amount_input:SetPoint("BOTTOMLEFT", 29, 70)
NuttenhAdmin.main_frame.rewards.amount_input:SetHeight(25)
NuttenhAdmin.main_frame.rewards.amount_input:SetWidth(120)
NuttenhAdmin.main_frame.rewards.amount_input:SetAutoFocus(false)

NuttenhAdmin.main_frame.rewards.amount_input:SetScript("OnTextChanged", function(self)
	if self:GetText() == "" then
		NuttenhAdmin.main_frame.rewards.amount_title:Show()
	else
		NuttenhAdmin.main_frame.rewards.amount_title:Hide()
	end

	self:SetText(string.gsub(self:GetText(), "[^%d]", ""))
end)


-- Input pour les Items
NuttenhAdmin.main_frame.rewards.item_input = CreateFrame("EditBox", "MissionFrame_RewardFrame_ItemInput", NuttenhAdmin.main_frame.rewards, "InputBoxTemplate")
NuttenhAdmin.main_frame.rewards.item_input:SetPoint("BOTTOMLEFT", 29, 45)
NuttenhAdmin.main_frame.rewards.item_input:SetHeight(25)
NuttenhAdmin.main_frame.rewards.item_input:SetWidth(120)
NuttenhAdmin.main_frame.rewards.item_input:SetAutoFocus(false)

NuttenhAdmin.main_frame.rewards.item_input:SetScript("OnTextChanged", function(self)
	if self:GetText() == "" then
		NuttenhAdmin.main_frame.rewards.item_title:Show()
	else
		NuttenhAdmin.main_frame.rewards.item_title:Hide()
	end

	self:SetText(string.gsub(self:GetText(), "[^%d]", ""))
end)

-- Bouton pour les Items
NuttenhAdmin.main_frame.rewards.item_button = CreateFrame("Button", "MissionFrame_RewardFrame_ItemButton", NuttenhAdmin.main_frame.rewards, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.rewards.item_button:SetPoint("BOTTOMRIGHT", -19, 57)
NuttenhAdmin.main_frame.rewards.item_button:SetHeight(25)
NuttenhAdmin.main_frame.rewards.item_button:SetWidth(70)
NuttenhAdmin.main_frame.rewards.item_button:SetText("Ajouter")

NuttenhAdmin.main_frame.rewards.item_button:SetScript("OnClick", function(self)
	wait(0.1, function()
		local id = NuttenhAdmin.main_frame.rewards.item_input:GetText()
		local amount = NuttenhAdmin.main_frame.rewards.amount_input:GetText()

		if amount == nil or amount == 0 or amount == "" then
			amount = 1
		end

		if GetItemInfo(id) ~= nil then
			addItem(id, amount)
		end
	end)
end)

NuttenhAdmin.main_frame.items = {}
NuttenhAdmin.main_frame.itemsFrames = {}

function addItem(itemId, amount)
	local nList = array_size(NuttenhAdmin.main_frame.items) + 1

	if nList <= 6 then
		NuttenhAdmin.main_frame.items[nList] = {id=itemId, amount=amount, n=nList}

		displayItems()
	else
		message("Vous ne pouvez pas ajouter plus d'objets en récompense !")
	end
end

function removeItem(index)
	table.remove(NuttenhAdmin.main_frame.items, index)
	NuttenhAdmin.main_frame.itemsFrames[index]:Hide()
end

function undisplayItems()
	for i=1, array_size(NuttenhAdmin.main_frame.itemsFrames) do
		NuttenhAdmin.main_frame.itemsFrames[i]:Hide()
	end

	NuttenhAdmin.main_frame.itemsFrames = {}
end

function displayItems()
	undisplayItems()
	for i=1, array_size(NuttenhAdmin.main_frame.items) do
		local itemId = NuttenhAdmin.main_frame.items[i]["id"]
		local amount = NuttenhAdmin.main_frame.items[i]["amount"]

		if GetItemInfo(itemId) ~= nil then
			local nList = i

			local x = 23 + (60 * mod(nList - 1, 3))
			local y = -20

			if nList == 3 or nList == 6 then
				x = 23 + (60 * 2)
			end

			if nList > 3 then
				y = -90
			end

			NuttenhAdmin.main_frame.itemsFrames[i] = CreateFrame("Button", nil, NuttenhAdmin.main_frame.rewards.items)
			NuttenhAdmin.main_frame.itemsFrames[i]:SetFrameStrata("BACKGROUND")
			NuttenhAdmin.main_frame.itemsFrames[i]:SetBackdropBorderColor(255, 0, 0, 1)
			NuttenhAdmin.main_frame.itemsFrames[i]:SetPoint("TOPLEFT", x, y)
			NuttenhAdmin.main_frame.itemsFrames[i]:SetWidth(35) -- Set these to whatever height/width is needed 
			NuttenhAdmin.main_frame.itemsFrames[i]:SetHeight(35) -- for your Texture

			local t = NuttenhAdmin.main_frame.itemsFrames[i]:CreateTexture(nil,"BACKGROUND")
			t:SetTexture(GetItemIcon(itemId))
			t:SetAllPoints(NuttenhAdmin.main_frame.itemsFrames[i])
			NuttenhAdmin.main_frame.itemsFrames[i].texture = t

			NuttenhAdmin.main_frame.itemsFrames[i]:SetScript("OnClick", function(self)
				removeItem(i)
				displayItems()
			end)

			NuttenhAdmin.main_frame.itemsFrames[i]:SetScript("OnEnter", function(self)
				local name, link = GetItemInfo(itemId)
			  	GameTooltip:SetOwner(NuttenhAdmin.main_frame.itemsFrames[i], "ANCHOR_CURSOR")
			  	GameTooltip:SetHyperlink(link)
			  	GameTooltip:Show()
			end)

			NuttenhAdmin.main_frame.itemsFrames[i]:SetScript("OnLeave", function(self)
				GameTooltip:Hide()
			end)

			NuttenhAdmin.main_frame.itemsFrames[i].text = NuttenhAdmin.main_frame.itemsFrames[i]:CreateFontString(nil, "OVERLAY")
			NuttenhAdmin.main_frame.itemsFrames[i].text:SetPoint("BOTTOMRIGHT", NuttenhAdmin.main_frame.itemsFrames[i], 0, 0)
			NuttenhAdmin.main_frame.itemsFrames[i].text:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
			NuttenhAdmin.main_frame.itemsFrames[i].text:SetTextColor(255, 255, 255)
			NuttenhAdmin.main_frame.itemsFrames[i].text:SetText(amount)
		end
	end
end

NuttenhAdmin.main_frame.generate_button = CreateFrame("Button", "MainFrame_GenerateButton", NuttenhAdmin.main_frame, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.generate_button:SetPoint("BOTTOMLEFT", 20, 15)
NuttenhAdmin.main_frame.generate_button:SetHeight(25)
NuttenhAdmin.main_frame.generate_button:SetWidth(140)
NuttenhAdmin.main_frame.generate_button:SetText("Générer la clé")

NuttenhAdmin.main_frame.generate_button:SetScript("OnClick", function(self)
	if array_size(NuttenhAdmin.main_frame.missions.list.content) - 1 > 0 then
		local key = {}
		local k = ""

		for i=1, array_size(NuttenhAdmin.main_frame.missions.list.content) - 1 do
			key[array_size(key)] = NuttenhAdmin.main_frame.missions.list.content[i]["mission_type"] .. NuttenhAdmin.main_frame.missions.list.content[i]["setting"] .. "_"
		end

		for i=0, array_size(key) - 1 do
			k = k .. tostring(key[i])
		end

		k = k:sub(1, -2)
	
		StaticPopupDialogs["GENERATED_KEY"] = {
		  	text = "Clé générée : ",
		  	button2 = "Fermer",

		  	timeout = 0,
		  	whileDead = true,
		  	hideOnEscape = true,
		  	hasEditBox = true,

		  	OnShow = function(self)
		  		self.editBox:SetText(k)
		  	end
		}

		StaticPopup_Show("GENERATED_KEY")
	else
		print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucune mission n'a été ajoutée !")
	end
end)

NuttenhAdmin.main_frame.specific_button = CreateFrame("Button", "MainFrame_SpecificButton", NuttenhAdmin.main_frame, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.specific_button:SetPoint("BOTTOMLEFT", 170, 15)
NuttenhAdmin.main_frame.specific_button:SetHeight(25)
NuttenhAdmin.main_frame.specific_button:SetWidth(140)
NuttenhAdmin.main_frame.specific_button:SetText("Entrer une clé")

NuttenhAdmin.main_frame.specific_button:SetScript("OnClick", function(self)
	StaticPopupDialogs["ENTER_KEY"] = {
	  	text = "Enter une clé :",
	  	button1 = "Valider",
	  	button2 = "Fermer",

	  	timeout = 0,
	  	whileDead = true,
	  	hideOnEscape = true,
	  	hasEditBox = true,

	  	OnAccept = function(self)
	  		for i=1, array_size(NuttenhAdmin.main_frame.missions.list.content) - 1 do
				NuttenhAdmin.main_frame.missions.list.content[i]:Hide()
				NuttenhAdmin.main_frame.missions.list.content[i] = nil
			end

			local splitedKey = str_split(self.editBox:GetText(), "_")

			for i=1, array_size(splitedKey) do
				local mission = splitedKey[i]
				local mission_type = string.sub(mission, 1, 1)
				local setting = string.sub(mission, 2)

				addLineAdmin(getIndication(mission_type, setting), mission_type, setting)
			end

	  	end,

  		OnCancel = function(self)
	  		-- StaticPopup_Show("QUESTION")
		end
	}

	StaticPopup_Show("ENTER_KEY")
end)


NuttenhAdmin.main_frame.start_button = CreateFrame("Button", "MainFrame_StartButton", NuttenhAdmin.main_frame, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.start_button:SetPoint("BOTTOM", 0, 15)
NuttenhAdmin.main_frame.start_button:SetHeight(25)
NuttenhAdmin.main_frame.start_button:SetWidth(200)
NuttenhAdmin.main_frame.start_button:SetText("Démarrer l'event !")

NuttenhAdmin.main_frame.start_button:SetScript("OnClick", function(self)
	if array_size(NuttenhAdmin.main_frame.missions.list.content) - 1 > 0 then
		
		-- Ajout des récompense saisies (items)
		for i=1, array_size(NuttenhAdmin.main_frame.items) do
			rewardCommand("add " .. NuttenhAdmin.main_frame.items[i]["id"] .. " " .. NuttenhAdmin.main_frame.items[i]["amount"])
		end

		-- Ajout des récompense saisies (gold)
		if tonumber(NuttenhAdmin.main_frame.gold) > 0 then
			rewardCommand("add gold " .. tostring(NuttenhAdmin.main_frame.gold))
		end

		local key = {}
		local k = ""

		for i=1, array_size(NuttenhAdmin.main_frame.missions.list.content) - 1 do
			key[array_size(key)] = NuttenhAdmin.main_frame.missions.list.content[i]["mission_type"] .. NuttenhAdmin.main_frame.missions.list.content[i]["setting"] .. "_"
		end

		for i=0, array_size(key) - 1 do
			k = k .. tostring(key[i])
		end

		k = k:sub(1, -2)

		saveEndTime()
		
		eventCommand("start " .. k .. " " .. UnitName("player"))
		PlaySound("READYCHECK", "SFX")
	else
		print("|cFFF547FF[Addon] [" .. addonName .. "] : Aucune mission n'a été ajoutée !")
	end
end)

NuttenhAdmin.main_frame.stop_button = CreateFrame("Button", "MainFrame_StopButton", NuttenhAdmin.main_frame, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.stop_button:SetPoint("BOTTOMRIGHT", -62, 15)
NuttenhAdmin.main_frame.stop_button:SetHeight(25)
NuttenhAdmin.main_frame.stop_button:SetWidth(200)
NuttenhAdmin.main_frame.stop_button:SetText("Arrêter l'event !")

NuttenhAdmin.main_frame.stop_button:SetScript("OnClick", function(self)
	eventCommand("stop")
end)

wait(0.2, function()
	for i=1, array_size(vAGet("playingUsers")) do
		addPlayerLine(_Admin["playingUsers"][i])
	end
end)

-- Create minimap button
 
local minibtn = CreateFrame("Button", nil, Minimap)
minibtn:SetFrameLevel(8)
minibtn:SetSize(32,32)
minibtn:SetMovable(true)
 
-- minibtn:SetNormalTexture("Interface/AddOns/AutoSell/Leatrix_Plus_Up.blp")
-- minibtn:SetPushedTexture("Interface/AddOns/AutoSell/Leatrix_Plus_Up.blp")
-- minibtn:SetHighlightTexture("Interface/AddOns/AutoSell/Leatrix_Plus_Up.blp")
 
minibtn:SetNormalTexture("Interface/ICONS/Thumbsup.png")
minibtn:SetPushedTexture("Interface/ICONS/Thumbsup.png")
minibtn:SetHighlightTexture("Interface/ICONS/Thumbsup.png")
 
local myIconPos = 0
 
-- Control movement
local function UpdateMapBtn()
    local Xpoa, Ypoa = GetCursorPosition()
    local Xmin, Ymin = Minimap:GetLeft(), Minimap:GetBottom()
    Xpoa = Xmin - Xpoa / Minimap:GetEffectiveScale() + 70
    Ypoa = Ypoa / Minimap:GetEffectiveScale() - Ymin - 70
    myIconPos = math.deg(math.atan2(Ypoa, Xpoa))
    minibtn:ClearAllPoints()
    minibtn:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 52 - (80 * cos(myIconPos)), (80 * sin(myIconPos)) - 52)
end
 
minibtn:RegisterForDrag("LeftButton")
minibtn:SetScript("OnDragStart", function()
    minibtn:StartMoving()
    minibtn:SetScript("OnUpdate", UpdateMapBtn)
end)
 
minibtn:SetScript("OnDragStop", function()
    minibtn:StopMovingOrSizing();
    minibtn:SetScript("OnUpdate", nil)
    UpdateMapBtn();
end)
 
-- Set position
minibtn:ClearAllPoints();
minibtn:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 60 - (80 * cos(myIconPos)), (80 * sin(myIconPos)) - 90)
 
-- Control clicks
minibtn:SetScript("OnClick", function()
	if NuttenhAdmin.main_frame:IsShown() == nil then
    	NuttenhAdmin.main_frame:Show()
    else
    	NuttenhAdmin.main_frame:Hide()
    end
end)

function saveEndTime()
	local day = NuttenhAdmin.main_frame.date.day_input:GetText()
	local month = NuttenhAdmin.main_frame.date.month_input:GetText()
	local year = NuttenhAdmin.main_frame.date.year_input:GetText()
	local hour = NuttenhAdmin.main_frame.date.hour_input:GetText()
	local minute = NuttenhAdmin.main_frame.date.minute_input:GetText()

	-- local date = day .. "/" .. month .. "/" .. year .. " " .. hour .. ":" .. minute
	local date = year .. "-" .. month .. "-" .. day .. " " .. hour .. ":" .. minute .. ":00"
	
	vASave("maxTime", date)
end