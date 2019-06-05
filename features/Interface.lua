--[[local main_window = CreateFrame("Frame", nil, UIParent)
main_window:SetFrameStrata("BACKGROUND")
main_window:SetMovable(true) -- Permet le déplacement de la fenêtre
main_window:EnableMouse(true)
main_window:RegisterForDrag("LeftButton") -- Définit le clic gauche comme le bouton à utiliser pour déplacer la fenêtre
main_window:SetScript("OnDragStart", main_window.StartMoving)  -- frame.StartMoving
main_window:SetScript("OnDragStop", main_window.StopMovingOrSizing) -- frame.StopMovingOrSizing
main_window:SetWidth(415)
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
	
local form_frame = CreateFrame("Frame", nil, main_window)
form_frame:SetWidth(415)
form_frame:SetHeight(350)
form_frame:SetPoint("BOTTOM", 0, 0)

form_frame:Show()
]]
--[[
local label_1 = form_frame:CreateFontString(nil, "ARTWORK")
label_1:SetFont("Fonts\\ARIALN.ttf", 13)
label_1:SetPoint("TOPLEFT", 25, -10)
label_1:SetText("Nom du PNJ : ")
label_1:SetTextColor(255, 255, 255, 1)
]]
--[[
local first = {}
local second = {}

for r=1, 5 do

	---------------------------------------------------------------------------------------------------------------------
	local dropdownSelectNpcValues = {"Type de mission :"}

	for o=1, getArraySize(NPC_LIST) do
		dropdownSelectNpcValues[o] = NPC_LIST[tostring(o)]["name"]
	end

	local dropdownSelectNpcValue = 0
	local pLine = nil
	pLine = CreateFrame("FRAME", "DropdownSelectNpc", form_frame, "UIDropDownMenuTemplate")
	pLine.line = i
	pLine:SetPoint("TOPLEFT", 200, 50 - 15 * (r * 4) )
	UIDropDownMenu_SetWidth(pLine, 150)
	UIDropDownMenu_SetText(pLine, "Nom du PNJ :")

	UIDropDownMenu_Initialize(pLine, function(self, level, menuList)
		for i=1, getArraySize(dropdownSelectNpcValues) do
			local info = UIDropDownMenu_CreateInfo()
			info.text, info.arg1, info.func = dropdownSelectNpcValues[i], i, self.SetValue

			if dropdownSelectNpcValue == i then
				info.checked = true
			end

			UIDropDownMenu_AddButton(info)
		end
	end)

	function pLine:SetValue(value)
		UIDropDownMenu_SetText(pLine, dropdownSelectNpcValues[value])
		dropdownSelectNpcValue = value
		local v = value - 1
		pLine.value = v

		if v == 1 then
			print("ok")
		end

		CloseDropDownMenus()
	end

	pLine:Hide()
	second[r] = pLine

	---------------------------------------------------------------------------------------------------------------------

	local ppLine = nil
	local missions_types = {"Type de mission :", "Parler à un PNJ", "Trouver un lieu", "Ramasser un item", "Tuer des mobs", "Répondre à une question", "Interagir avec un joueur"}
	local dropdownValue = 1

	local ppLine = CreateFrame("FRAME", "DropdownMissionType", main_window, "UIDropDownMenuTemplate")
	ppLine:SetPoint("TOPLEFT", 0, -15 * (r * 4))
	UIDropDownMenu_SetWidth(ppLine, 150)
	UIDropDownMenu_SetText(ppLine, "Type de mission :")

	UIDropDownMenu_Initialize(ppLine, function(self, level, menuList)
		for i=1, getArraySize(missions_types) do
			local info = UIDropDownMenu_CreateInfo()
			info.text, info.arg1, info.func = missions_types[i], i, self.SetValue

			if dropdownValue == i then
				info.checked = true
			end

			UIDropDownMenu_AddButton(info)
		end
	end)

	function ppLine:SetValue(value)
		UIDropDownMenu_SetText(ppLine, missions_types[value])
		dropdownValue = value
		local v = value - 1
		ppLine.value = v

		pLine:Hide()

		if v == 1 then
			pLine:Show()
		end

		CloseDropDownMenus()
	end

	first[r] = ppLine

	---------------------------------------------------------------------------------------------------------------------
end


local submit_button = CreateFrame("Button", "CloseButton", main_window, "GameMenuButtonTemplate")
submit_button:SetPoint("BOTTOM", 0, 25)
submit_button:SetHeight(25)
submit_button:SetWidth(150)
submit_button:SetText("Générer la clé")

submit_button:SetScript("OnClick", function(self)
	local key = ""

	for i=1, 5 do
		local f = first[i].value
		local s = second[i].value

		if f == nil then
			f = ""
		end

		if s == nil then
			s = ""
		end
		key = key .. f .. s
	end

	print(key)
end)]]
--[[


local editBox = CreateFrame("EditBox", "MissionsTypesDropdowna", main_window, "SearchBoxTemplate")
editBox:SetWidth(150)
editBox:SetHeight(30)
editBox:SetPoint("TOPRIGHT", -15, -15)


]]