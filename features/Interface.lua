main_frame = CreateFrame("Frame", nil, UIParent)
main_frame:SetFrameStrata("BACKGROUND")
main_frame:SetMovable(true) -- Permet le déplacement de la fenêtre
main_frame:EnableMouse(true)
main_frame:RegisterForDrag("LeftButton") -- Définit le clic gauche comme le bouton à utiliser pour déplacer la fenêtre
main_frame:SetScript("OnDragStart", frame.StartMoving)
main_frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
main_frame:SetWidth(300)
main_frame:SetHeight(400)

main_frame:SetBackdrop({
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

main_frame:SetBackdropColor(0, 0, 0);
main_frame:SetPoint("LEFT", 20, 0)

main_frame:Show()
	
local missions_types = {"Parler à un PNJ", "Trouver un lieu", "Ramasser un item", "Tuer des mobs", "Répondre à une question", "Interagir avec un joueur"}

local dropdown = CreateFrame("FRAME", "MissionsTypesDropdown", main_frame, "UIDropDownMenuTemplate")
dropdown:SetPoint("TOPLEFT", 0, -15)
UIDropDownMenu_SetWidth(dropdown, 150)
UIDropDownMenu_SetText(dropdown, "Type de mission :")

UIDropDownMenu_Initialize(dropdown, function(self, level, menuList)
	for i=1, getArraySize(missions_types) do
		local info = UIDropDownMenu_CreateInfo()
		info.text, info.arg1, info.checked, info.func = missions_types[i], i, true, self.SetValue
		UIDropDownMenu_AddButton(info)
	end
end)

function dropdown:SetValue(value)
	UIDropDownMenu_SetText(dropdown, missions_types[value])
	CloseDropDownMenus()
end  