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

-- Création d'un bouton permettant de réduire la fenêtre
NuttenhAdmin.main_frame.close_button = CreateFrame("Button", "CloseButton", NuttenhAdmin.main_frame, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.close_button:SetPoint("TOPRIGHT", 0, 0)
NuttenhAdmin.main_frame.close_button:SetFrameStrata("HIGH")
NuttenhAdmin.main_frame.close_button:SetFrameLevel(6)
NuttenhAdmin.main_frame.close_button:SetHeight(25.4)
NuttenhAdmin.main_frame.close_button:SetWidth(25.4)

-- Création du texte à afficher sur le bouton (+/-)
local fontString = NuttenhAdmin.main_frame.close_button:CreateFontString(nil, "ARTWORK")
fontString:SetAllPoints()
fontString:SetFont("Fonts\\FRIZQT__.TTF", 20)
fontString:SetTextColor(255, 255, 0, 1)
fontString:SetShadowOffset(1, -1)
fontString:SetText("-")

NuttenhAdmin.main_frame.close_button.fontString = fontString

local isMinimized = false

-- Cette fonction se déclenche lorsque l'utilisateur clique sur le bouton
NuttenhAdmin.main_frame.close_button:SetScript("OnClick", function(self, arg1)
	if isMinimized == false then
		-- On réduit la taille de la fenêtre et on masque les principales parties qui la compose
		NuttenhAdmin.main_frame:SetHeight(55)

		fontString:SetText("+")
		fontString:SetFont("Fonts\\FRIZQT__.TTF", 16)

		isMinimized = true
	else
		-- On redonne à la fenêtre sa taille de base et on réaffiche les parties qui la compose
		NuttenhAdmin.main_frame:SetHeight(500)

		fontString:SetFont("Fonts\\FRIZQT__.TTF", 20)
		fontString:SetText("-")

		isMinimized = false
	end
end)

-- Player List
NuttenhAdmin.main_frame.player_list = CreateFrame("Frame", "PlayerList", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.player_list:SetWidth(245)
NuttenhAdmin.main_frame.player_list:SetHeight(400)
NuttenhAdmin.main_frame.player_list:SetPoint("RIGHT", -40, 5)
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

function addPlayerLine(playerName)
	local lineNumber = getArraySize(NuttenhAdmin.main_frame.player_list.content)
	NuttenhAdmin.main_frame.player_list.content[lineNumber] = NuttenhAdmin.main_frame.player_list.content:CreateFontString(nil, "ARTWORK")
	NuttenhAdmin.main_frame.player_list.content[lineNumber]:SetFont("Fonts\\ARIALN.ttf", 12)
	NuttenhAdmin.main_frame.player_list.content[lineNumber]:SetPoint("TOPLEFT", 0, 10 - (lineNumber * 20))
	NuttenhAdmin.main_frame.player_list.content[lineNumber]:SetText(lineNumber .. ". " .. playerName)
	NuttenhAdmin.main_frame.player_list.content[lineNumber]:SetTextColor(1, 1, 1, 1)
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
scrollbar:SetMinMaxValues(1, 20) 
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
NuttenhAdmin.main_frame.missions.list.scrollbar = scrollbar 

--content frame 
NuttenhAdmin.main_frame.missions.list.content = CreateFrame("Frame", nil, scrollframe) 
NuttenhAdmin.main_frame.missions.list.content:SetSize(250, 250) 

scrollframe:SetScrollChild(NuttenhAdmin.main_frame.missions.list.content)

function addLineAdmin(text, mission_type, setting)
	local lineNumber = getArraySize(NuttenhAdmin.main_frame.missions.list.content)
	NuttenhAdmin.main_frame.missions.list.content[lineNumber] = NuttenhAdmin.main_frame.missions.list.content:CreateFontString(nil, "ARTWORK")
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:SetFont("Fonts\\ARIALN.ttf", 12)
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:SetPoint("TOPLEFT", 0, 10 - (lineNumber * 20))
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:SetText(lineNumber .. ". " .. tostring(text))
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:SetTextColor(1, 1, 1, 1)
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]["mission_type"] = mission_type
	NuttenhAdmin.main_frame.missions.list.content[lineNumber]["setting"] = setting
end

function removeLastLine()
	local lineNumber = getArraySize(NuttenhAdmin.main_frame.missions.list.content) - 1

	NuttenhAdmin.main_frame.missions.list.content[lineNumber]:Hide()
	NuttenhAdmin.main_frame.missions.list.content[lineNumber] = nil
end

----------------------------------------------------------------------------------------------------------

local dropdownSelectNpcValues = {"Nom du PNJ"}

for o=1, getArraySize(NPC_LIST) do
	dropdownSelectNpcValues[o + 1] = NPC_LIST[tostring(o)]["name"][GetLocale()]
end

local dropdownSelectNpcValue = 0
local pSelectNpc = nil
pSelectNpc = CreateFrame("Frame", "DropdownSelectNpc", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectNpc.line = i
pSelectNpc:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectNpc, 150)
UIDropDownMenu_SetText(pSelectNpc, "Nom du PNJ")

UIDropDownMenu_Initialize(pSelectNpc, function(self, level, menuList)
	for i=1, getArraySize(dropdownSelectNpcValues) do
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

for o=1, getArraySize(LOCATIONS_LIST) do
	dropdownSelectZoneValues[o + 1] = LOCATIONS_LIST[tostring(o)]["zoneText"][GetLocale()]
end

local dropdownSelectZoneValue = 0
local pSelectZone = nil
pSelectZone = CreateFrame("Frame", "DropdownSelectZone", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectZone.line = i
pSelectZone:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectZone, 150)
UIDropDownMenu_SetText(pSelectZone, "Lieu")

UIDropDownMenu_Initialize(pSelectZone, function(self, level, menuList)
	for i=1, getArraySize(dropdownSelectZoneValues) do
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

	-- add2Key(r, v, 1)

	CloseDropDownMenus()
end

pSelectZone:Hide()

----------------------------------------------------------------------------------------------------------

local missions_types = {"Type de mission", "Parler à un PNJ", "Trouver un lieu", "Ramasser un item", "Tuer des mobs", "Répondre à une question"}

-- Création du menu déroulant
local pSelectMissionType = CreateFrame("Frame", "DropdownMissionType", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectMissionType:SetPoint("TOP", 0, -20)
UIDropDownMenu_SetWidth(pSelectMissionType, 150)
UIDropDownMenu_SetText(pSelectMissionType, "Type de mission")
pSelectMissionType.value = 0
pSelectMissionType.text = "Type de mission"

-- Ajout des options au menu déroulant
UIDropDownMenu_Initialize(pSelectMissionType, function(self, level, menuList)
	for i=1, getArraySize(missions_types) do
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

for o=1, getArraySize(ITEMS_LIST) do
	dropdownSelectItemValues[o + 1] = ITEMS_LIST[tostring(o)]["name"][GetLocale()]
end

local dropdownSelectItemValue = 0
local pSelectItem = nil
pSelectItem = CreateFrame("Frame", "DropdownSelectItem", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectItem.line = i
pSelectItem:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectItem, 150)
UIDropDownMenu_SetText(pSelectItem, "Item")

UIDropDownMenu_Initialize(pSelectItem, function(self, level, menuList)
	for i=1, getArraySize(dropdownSelectItemValues) do
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
	dropdownSelectZoneValue = value
	local v = value - 1
	pSelectItem.value = v

	-- add2Key(r, v, 1)

	CloseDropDownMenus()
end

pSelectItem:Hide()

----------------------------------------------------------------------------------------------------------

local dropdownSelectMobValues = {"Mob"}

for o=1, getArraySize(KILL_LIST) do
	dropdownSelectMobValues[o + 1] = KILL_LIST[tostring(o)]["name"][GetLocale()]
end

local dropdownSelectMobValue = 0
local pSelectMob = nil
pSelectMob = CreateFrame("Frame", "DropdownSelectMob", NuttenhAdmin.main_frame.missions, "UIDropDownMenuTemplate")
pSelectMob.line = i
pSelectMob:SetPoint("TOP", 0, -60)
UIDropDownMenu_SetWidth(pSelectMob, 150)
UIDropDownMenu_SetText(pSelectMob, "Mob")

UIDropDownMenu_Initialize(pSelectMob, function(self, level, menuList)
	for i=1, getArraySize(dropdownSelectMobValues) do
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

	-- add2Key(r, v, 1)

	CloseDropDownMenus()
end

pSelectMob:Hide()

----------------------------------------------------------------------------------------------------------

-- Cette fonction est éxécutée lorsque l'utilisateur choisit une option dans le premier menu
function pSelectMissionType:SetValue(value)
	UIDropDownMenu_SetText(pSelectMissionType, missions_types[value])
	pSelectMissionType.value = value - 1

	pSelectNpc:Hide()
	pSelectZone:Hide()
	pSelectItem:Hide()
	pSelectMob:Hide()

	if pSelectMissionType.value == 1 then
		pSelectNpc:Show()
	elseif pSelectMissionType.value == 2 then
		pSelectZone:Show()
	elseif pSelectMissionType.value == 3 then
		pSelectItem:Show()
	elseif pSelectMissionType.value == 4 then
		pSelectMob:Show()
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
	if getArraySize(NuttenhAdmin.main_frame.missions.list.content) - 1 > 0 then
		removeLastLine()
	end
end)

-- Rewards Frame
NuttenhAdmin.main_frame.rewards = CreateFrame("Frame", "MainFrame_RewardsFrame", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.rewards:SetWidth(245)
NuttenhAdmin.main_frame.rewards:SetHeight(400)
NuttenhAdmin.main_frame.rewards:SetPoint("LEFT", 40, 5)
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

-- Titre pour les P.O.
NuttenhAdmin.main_frame.rewards.gold_title = NuttenhAdmin.main_frame.rewards:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.rewards.gold_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.rewards.gold_title:SetPoint("BOTTOMLEFT", 29, 120 + 7)
NuttenhAdmin.main_frame.rewards.gold_title:SetText("Nombre de pièces d'or")
NuttenhAdmin.main_frame.rewards.gold_title:SetTextColor(1, 1, 1, 1)

-- Input pour les P.O.
NuttenhAdmin.main_frame.rewards.gold_input = CreateFrame("EditBox", "MissionFrame_RewardFrame_GoldInput", NuttenhAdmin.main_frame.rewards, "InputBoxTemplate")
NuttenhAdmin.main_frame.rewards.gold_input:SetPoint("BOTTOMLEFT", 29, 120)
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
NuttenhAdmin.main_frame.rewards.gold_button:SetPoint("BOTTOMRIGHT", -19, 120)
NuttenhAdmin.main_frame.rewards.gold_button:SetHeight(25)
NuttenhAdmin.main_frame.rewards.gold_button:SetWidth(70)
NuttenhAdmin.main_frame.rewards.gold_button:SetText("OK")

NuttenhAdmin.main_frame.rewards.gold_button:SetScript("OnClick", function(self)
	print("Add gold : " .. NuttenhAdmin.main_frame.rewards.gold_input:GetText())
end)

NuttenhAdmin.main_frame.rewards.item_input = CreateFrame("EditBox", "MissionFrame_RewardFrame_ItemInput", NuttenhAdmin.main_frame.rewards, "InputBoxTemplate")
NuttenhAdmin.main_frame.rewards.item_input:SetPoint("BOTTOMLEFT", 29, 85)
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

-- Bouton ajouter une récompense (item)
NuttenhAdmin.main_frame.rewards.item_title = NuttenhAdmin.main_frame.rewards:CreateFontString(nil, "ARTWORK")
NuttenhAdmin.main_frame.rewards.item_title:SetFont("Fonts\\FRIZQT__.ttf", 10)
NuttenhAdmin.main_frame.rewards.item_title:SetPoint("BOTTOMLEFT", 29, 85 + 7)
NuttenhAdmin.main_frame.rewards.item_title:SetText("Identifiant de l'item")
NuttenhAdmin.main_frame.rewards.item_title:SetTextColor(1, 1, 1, 1)

NuttenhAdmin.main_frame.rewards.item_button = CreateFrame("Button", "MissionFrame_RewardFrame_ItemButton", NuttenhAdmin.main_frame.rewards, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.rewards.item_button:SetPoint("BOTTOMRIGHT", -19, 85)
NuttenhAdmin.main_frame.rewards.item_button:SetHeight(25)
NuttenhAdmin.main_frame.rewards.item_button:SetWidth(70)
NuttenhAdmin.main_frame.rewards.item_button:SetText("OK")

NuttenhAdmin.main_frame.rewards.item_button:SetScript("OnClick", function(self)
	print("Add gold : " .. NuttenhAdmin.main_frame.rewards.item_input:GetText())
end)

-- Bouton supprimer la dernière récompense
NuttenhAdmin.main_frame.rewards.remove_button = CreateFrame("Button", "MissionFrame_RewardFrame_RemoveButton", NuttenhAdmin.main_frame.rewards, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.rewards.remove_button:SetPoint("BOTTOM", 0, 15)
NuttenhAdmin.main_frame.rewards.remove_button:SetHeight(25)
NuttenhAdmin.main_frame.rewards.remove_button:SetWidth(200)
NuttenhAdmin.main_frame.rewards.remove_button:SetText("Supprimer le dernier item")

NuttenhAdmin.main_frame.rewards.remove_button:SetScript("OnClick", function(self)
	print("Remove last item")
end)

-- Rewards Frame
NuttenhAdmin.main_frame.rewards.items = CreateFrame("Frame", "MainFrame_RewardsFrame", NuttenhAdmin.main_frame.rewards)
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