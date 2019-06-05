main_window = CreateFrame("Frame", nil, UIParent)
main_window:SetFrameStrata("BACKGROUND")
main_window:SetMovable(true) -- Permet le déplacement de la fenêtre
main_window:EnableMouse(true)
main_window:RegisterForDrag("LeftButton") -- Définit le clic gauche comme le bouton à utiliser pour déplacer la fenêtre
main_window:SetScript("OnDragStart", frame.StartMoving)
main_window:SetScript("OnDragStop", frame.StopMovingOrSizing)
main_window:SetWidth(510)
main_window:SetHeight(400)

main_window:SetBackdrop({
	bgFile="Interface/Tooltips/UI-Tooltip-Background", -- 
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false,
	tileSize=64, 
	edgeSize=16, 
	insets={
		left=4,
		right=4,
		top=4,
		bottom=4
	}
})

main_window:SetBackdropColor(0, 0, 0);
main_window:SetPoint("LEFT", 20, 0)

main_window:Show()
	
form_frame = CreateFrame("Frame", nil, main_window)
form_frame:SetWidth(510)
form_frame:SetHeight(350)
form_frame:SetPoint("BOTTOM", 0, 0)

form_frame:Show()
--[[
local label_1 = form_frame:CreateFontString(nil, "ARTWORK")
label_1:SetFont("Fonts\\ARIALN.ttf", 13)
label_1:SetPoint("TOPLEFT", 25, -10)
label_1:SetText("Nom du PNJ : ")
label_1:SetTextColor(255, 255, 255, 1)
]]




---------------------------------------------------------------------------------------------------------------------
local dropdownSelectNpcValues = {"Type de mission :"}

for o=1, getArraySize(NPC_LIST) do
	dropdownSelectNpcValues[o] = NPC_LIST[tostring(o)]["name"]
end

local dropdownSelectNpcValue = 0
local dropdownSelectNpc = CreateFrame("FRAME", "DropdownSelectNpc", form_frame, "UIDropDownMenuTemplate")
dropdownSelectNpc:SetPoint("TOPLEFT", 200, 35)
UIDropDownMenu_SetWidth(dropdownSelectNpc, 150)
UIDropDownMenu_SetText(dropdownSelectNpc, "Nom du PNJ :")

UIDropDownMenu_Initialize(dropdownSelectNpc, function(self, level, menuList)
	for i=1, getArraySize(dropdownSelectNpcValues) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.func = dropdownSelectNpcValues[i], i, self.SetValue

		if dropdownSelectNpcValue == i then
			info.checked = true
		end

		UIDropDownMenu_AddButton(info)
	end
end)

function dropdownSelectNpc:SetValue(value)
	UIDropDownMenu_SetText(dropdownSelectNpc, dropdownSelectNpcValues[value])
	dropdownSelectNpcValue = value
	local v = value - 1

	if v == 1 then
		print("ok")
	end

	CloseDropDownMenus()
end

dropdownSelectNpc:Hide()

---------------------------------------------------------------------------------------------------------------------

local missions_types = {"Type de mission :", "Parler à un PNJ", "Trouver un lieu", "Ramasser un item", "Tuer des mobs", "Répondre à une question", "Interagir avec un joueur"}
local dropdownValue = 1

local dropdownMissionType = CreateFrame("FRAME", "DropdownMissionType", main_window, "UIDropDownMenuTemplate")
dropdownMissionType:SetPoint("TOPLEFT", 0, -15)
UIDropDownMenu_SetWidth(dropdownMissionType, 150)
UIDropDownMenu_SetText(dropdownMissionType, "Type de mission :")

UIDropDownMenu_Initialize(dropdownMissionType, function(self, level, menuList)
	for i=1, getArraySize(missions_types) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.func = missions_types[i], i, self.SetValue

		if dropdownValue == i then
			info.checked = true
		end

		UIDropDownMenu_AddButton(info)
	end
end)

function dropdownMissionType:SetValue(value)
	UIDropDownMenu_SetText(dropdownMissionType, missions_types[value])
	dropdownValue = value
	local v = value - 1

	dropdownSelectNpc:Hide()

	if v == 1 then
		dropdownSelectNpc:Show()
	end

	CloseDropDownMenus()
end

---------------------------------------------------------------------------------------------------------------------

local close_button = CreateFrame("Button", "CloseButton", main_window, "GameMenuButtonTemplate")
close_button:SetPoint("TOPRIGHT", -15, -15)
close_button:SetHeight(25)
close_button:SetWidth(80)
close_button:SetText("Ajouter")

--[[
local editBox = CreateFrame("EditBox", "MissionsTypesDropdowna", main_window, "SearchBoxTemplate")
editBox:SetWidth(150)
editBox:SetHeight(30)
editBox:SetPoint("TOPRIGHT", -15, -15)
]]