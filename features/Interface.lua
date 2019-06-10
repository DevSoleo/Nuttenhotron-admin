-- Création de la fenêtre principale
NuttenhAdmin.main_frame = CreateFrame("Frame", nil, UIParent)
NuttenhAdmin.main_frame:SetFrameStrata("BACKGROUND")
NuttenhAdmin.main_frame:SetMovable(true) -- Permet le déplacement de la fenêtre
NuttenhAdmin.main_frame:EnableMouse(true)
NuttenhAdmin.main_frame:RegisterForDrag("LeftButton") -- Définit le clic gauche comme le bouton à utiliser pour déplacer la fenêtre
NuttenhAdmin.main_frame:SetScript("OnDragStart", NuttenhAdmin.main_frame.StartMoving)  -- frame.StartMoving
NuttenhAdmin.main_frame:SetScript("OnDragStop", NuttenhAdmin.main_frame.StopMovingOrSizing) -- frame.StopMovingOrSizing
NuttenhAdmin.main_frame:SetWidth(600)
NuttenhAdmin.main_frame:SetHeight(500)

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
NuttenhAdmin.main_frame:SetPoint("LEFT", 20, 0)

NuttenhAdmin.main_frame:Show()

NuttenhAdmin.key = {}

function concatKey(part)

	NuttenhAdmin.key[getArraySize(NuttenhAdmin.key)] = part

end
----------------------------------------------------------------------------------------------------------

-- Création d'un bouton permettant de réduire la fenêtre
local close_button = CreateFrame("Button", "CloseButton", NuttenhAdmin.main_frame, "GameMenuButtonTemplate")
close_button:SetPoint("TOPRIGHT", 0, 0)
close_button:SetFrameStrata("HIGH")
close_button:SetFrameLevel(4)
close_button:SetHeight(27)
close_button:SetWidth(27)

-- Création du texte à afficher sur le bouton (+/-)
local fontString = close_button:CreateFontString(nil, 'ARTWORK')
fontString:SetAllPoints()
fontString:SetFont("Fonts\\FRIZQT__.TTF", 20)
fontString:SetTextColor(255, 255, 0, 1)
fontString:SetShadowOffset(1, -1)
fontString:SetText("-")

close_button.fontString = fontString

local isMinimized = false

-- Cette fonction se déclenche lorsque l'utilisateur clique sur le bouton
local function toggleFrameSize()
	if isMinimized == false then
		-- On réduit la taille de la fenêtre et on masque les principales parties qui la compose
		NuttenhAdmin.main_frame:SetHeight(60)
		NuttenhAdmin.main_frame.mission_list:Hide()
		NuttenhAdmin.main_frame.settings:Hide()
		isMinimized = true
	else
		-- On redonne à la fenêtre sa taille de base et on réaffiche les parties qui la compose
		NuttenhAdmin.main_frame:SetHeight(500)
		NuttenhAdmin.main_frame.mission_list:Show()
		NuttenhAdmin.main_frame.settings:Show()
		isMinimized = false
	end
end

close_button:SetScript("OnClick", function(self, arg1)
	if isMinimized == true then 
		fontString:SetFont("Fonts\\FRIZQT__.TTF", 20)
		fontString:SetText("-")
	else
		fontString:SetText("+")
		fontString:SetFont("Fonts\\FRIZQT__.TTF", 16)
	end

	toggleFrameSize()
end)

----------------------------------------------------------------------------------------------------------

-- On crée le menu de gauche, il servira à paramétrer les missions
NuttenhAdmin.main_frame.settings = CreateFrame("Frame", "SettingsFrame", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.settings:SetWidth(250)
NuttenhAdmin.main_frame.settings:SetHeight(400)
NuttenhAdmin.main_frame.settings:SetPoint("LEFT", 40, 0)

NuttenhAdmin.main_frame.settings:SetBackdrop({
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

----------------------------------------------------------------------------------------------------------

local dropdownSelectNpcValues = {"Nom du PNJ"}

for o=1, getArraySize(NPC_LIST) do
	dropdownSelectNpcValues[o + 1] = NPC_LIST[tostring(o)]["name"]
end

local dropdownSelectNpcValue = 0
local pSelectNpc = nil
pSelectNpc = CreateFrame("Frame", "DropdownSelectNpc", NuttenhAdmin.main_frame.settings, "UIDropDownMenuTemplate")
pSelectNpc.line = i
pSelectNpc:SetPoint("TOP", 0, -70)
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
pSelectZone = CreateFrame("Frame", "DropdownSelectZone", NuttenhAdmin.main_frame.settings, "UIDropDownMenuTemplate")
pSelectZone.line = i
pSelectZone:SetPoint("TOP", 0, -70)
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
local pSelectMissionType = CreateFrame("Frame", "DropdownMissionType", NuttenhAdmin.main_frame.settings, "UIDropDownMenuTemplate")
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
pSelectItem = CreateFrame("Frame", "DropdownSelectItem", NuttenhAdmin.main_frame.settings, "UIDropDownMenuTemplate")
pSelectItem.line = i
pSelectItem:SetPoint("TOP", 0, -70)
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
pSelectMob = CreateFrame("Frame", "DropdownSelectMob", NuttenhAdmin.main_frame.settings, "UIDropDownMenuTemplate")
pSelectMob.line = i
pSelectMob:SetPoint("TOP", 0, -70)
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

-- Cette fonction est éxécutée lorsque l'utilisateur choisit une option dans le menu
function pSelectMissionType:SetValue(value)
	UIDropDownMenu_SetText(pSelectMissionType, missions_types[value])
	pSelectMissionType.value = value - 1

	print(pSelectMissionType.value)

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
local add_mission_button = CreateFrame("Button", "AddMissionButton", NuttenhAdmin.main_frame.settings, "GameMenuButtonTemplate")
add_mission_button:SetPoint("BOTTOM", 0, 50)
add_mission_button:SetHeight(25)
add_mission_button:SetWidth(200)
add_mission_button:SetText("Ajouter cette mission ->")

add_mission_button:SetScript("OnClick", function(self)
	if pSelectMissionType.value > 0 then
		if pSelectMissionType.value == 1 then
			addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectNpcValues[pSelectNpc.value + 1], pSelectMissionType.value, pSelectNpc.value)
		elseif pSelectMissionType.value == 2 then
			addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectZoneValues[pSelectZone.value + 1], pSelectMissionType.value, pSelectZone.value)
		elseif pSelectMissionType.value == 3 then
			addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectItemValues[pSelectItem.value + 1], pSelectMissionType.value, pSelectItem.value)
		elseif pSelectMissionType.value == 4 then
			addLineAdmin(missions_types[pSelectMissionType.value + 1] .. " : " .. dropdownSelectMobValues[pSelectMob.value + 1], pSelectMissionType.value, pSelectMob.value)
		end
	end
end)

-- Bouton supprimer la dernière mission
local remove_mission_button = CreateFrame("Button", "RemoveMissionButton", NuttenhAdmin.main_frame.settings, "GameMenuButtonTemplate")
remove_mission_button:SetPoint("BOTTOM", 0, 15)
remove_mission_button:SetHeight(25)
remove_mission_button:SetWidth(200)
remove_mission_button:SetText("Supprimer la dernière mission")

remove_mission_button:SetScript("OnClick", function(self)
	removeLastLine()
end)





-- Mission List
NuttenhAdmin.main_frame.mission_list = CreateFrame("Frame", "MissionList", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.mission_list:SetWidth(250)
NuttenhAdmin.main_frame.mission_list:SetHeight(400)
NuttenhAdmin.main_frame.mission_list:SetPoint("RIGHT", -40, 0)
NuttenhAdmin.main_frame.mission_list:SetBackdrop({
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

local bg = NuttenhAdmin.main_frame.mission_list:CreateTexture(nil, "BACKGROUND") 
bg:SetAllPoints(NuttenhAdmin.main_frame.mission_list) 
bg:SetTexture(0, 0, 0, 0.1) 

-- Mission list scroll bar
local scrollframe = CreateFrame("ScrollFrame", nil, NuttenhAdmin.main_frame.mission_list) 
scrollframe:SetPoint("TOPLEFT", 10, -10) 
scrollframe:SetPoint("BOTTOMRIGHT", -10, 10)

local texture = scrollframe:CreateTexture() 
texture:SetAllPoints() 
-- texture:SetTexture(0.5, 0.5, 0.5, 1) 
NuttenhAdmin.main_frame.mission_list.scrollframe = scrollframe 

--scrollbar 
local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate") 
scrollbar:SetPoint("TOPLEFT", NuttenhAdmin.main_frame.mission_list, "TOPRIGHT", -20, -18) 
scrollbar:SetPoint("BOTTOMLEFT", NuttenhAdmin.main_frame.mission_list, "BOTTOMRIGHT", -20, 18) 
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
NuttenhAdmin.main_frame.mission_list.scrollbar = scrollbar 

--content frame 
NuttenhAdmin.main_frame.mission_list.content = CreateFrame("Frame", nil, scrollframe) 
NuttenhAdmin.main_frame.mission_list.content:SetSize(250, 250) 

scrollframe:SetScrollChild(NuttenhAdmin.main_frame.mission_list.content)

function addLineAdmin(text, mission_type, setting)
	local lineNumber = getArraySize(NuttenhAdmin.main_frame.mission_list.content)
	NuttenhAdmin.main_frame.mission_list.content[lineNumber] = NuttenhAdmin.main_frame.mission_list.content:CreateFontString(nil, "ARTWORK")
	NuttenhAdmin.main_frame.mission_list.content[lineNumber]:SetFont("Fonts\\ARIALN.ttf", 12)
	NuttenhAdmin.main_frame.mission_list.content[lineNumber]:SetPoint("TOPLEFT", 0, 10 - (lineNumber * 20))
	NuttenhAdmin.main_frame.mission_list.content[lineNumber]:SetText(lineNumber .. ". " .. tostring(text))
	NuttenhAdmin.main_frame.mission_list.content[lineNumber]:SetTextColor(1, 1, 1, 1)
	NuttenhAdmin.main_frame.mission_list.content[lineNumber]["mission_type"] = mission_type
	NuttenhAdmin.main_frame.mission_list.content[lineNumber]["setting"] = setting
end

function removeLastLine()
	local lineNumber = getArraySize(NuttenhAdmin.main_frame.mission_list.content) - 1

	NuttenhAdmin.main_frame.mission_list.content[lineNumber]:Hide()
	NuttenhAdmin.main_frame.mission_list.content[lineNumber] = nil
end

-- Bouton pour générer la clé 
NuttenhAdmin.main_frame.key_button = CreateFrame("Button", "GenerateKeyButton", NuttenhAdmin.main_frame, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.key_button:SetPoint("BOTTOMLEFT", 90, 15)
NuttenhAdmin.main_frame.key_button:SetHeight(25)
NuttenhAdmin.main_frame.key_button:SetWidth(150)
NuttenhAdmin.main_frame.key_button:SetText("Générer la clé !")

NuttenhAdmin.main_frame.key_button:SetScript("OnClick", function(self)
	-- local k = NuttenhAdmin.key:gsub("% ", "")

	for i=1, getArraySize(NuttenhAdmin.main_frame.mission_list.content) - 1 do
		concatKey(NuttenhAdmin.main_frame.mission_list.content[i]["mission_type"] .. NuttenhAdmin.main_frame.mission_list.content[i]["setting"])
	end
end)

-- Bouton pour générer la clé 
NuttenhAdmin.main_frame.start_button = CreateFrame("Button", "StartEventButton", NuttenhAdmin.main_frame, "GameMenuButtonTemplate")
NuttenhAdmin.main_frame.start_button:SetPoint("BOTTOMRIGHT", -90, 15)
NuttenhAdmin.main_frame.start_button:SetHeight(25)
NuttenhAdmin.main_frame.start_button:SetWidth(150)
NuttenhAdmin.main_frame.start_button:SetText("Démarrer l'event !")

NuttenhAdmin.main_frame.start_button:SetScript("OnClick", function(self)
	-- local k = NuttenhAdmin.key:gsub("% ", "")
	print("start " .. NuttenhAdmin.key .. " " .. UnitName("player"))
	PlaySound("READYCHECK", "SFX")
end)