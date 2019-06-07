local main_window = CreateFrame("Frame", nil, UIParent)
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

main_window.scroll = CreateFrame("ScrollFrame", "myScrollFrame", main_window, "UIPanelScrollFrameTemplate")
main_window.scroll:SetScrollChild(main_window.content)

main_window.scroll:SetPoint("CENTER", 0, 0)
main_window.scroll:Show()
	
local form_frame = CreateFrame("Frame", nil, main_window)
form_frame:SetWidth(415)
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

NuttenhAdmin.key = "00 00 00 00 00"

function add2Key(stade, setting, value)
	local a = split(NuttenhAdmin.key, " ")

	a[stade] = value .. setting

	local key = ""

	for l=1, getArraySize(a) do
		key = key .. " " .. a[l]
	end

	NuttenhAdmin.key = key
end

local first = {}
local second = {}

for r=1, 5 do

	---------------------------------------------------------------------------------------------------------------------
	local dropdownSelectNpcValues = {"Type de mission :"}

	for o=1, getArraySize(NPC_LIST) do
		dropdownSelectNpcValues[o + 1] = NPC_LIST[tostring(o)]["name"]
	end

	local dropdownSelectNpcValue = 0
	local pSelectNpc = nil
	pSelectNpc = CreateFrame("FRAME", "DropdownSelectNpc" .. r, form_frame, "UIDropDownMenuTemplate")
	pSelectNpc.line = i
	pSelectNpc:SetPoint("TOPLEFT", 200, 50 - 15 * (r * 4) )
	UIDropDownMenu_SetWidth(pSelectNpc, 150)
	UIDropDownMenu_SetText(pSelectNpc, "Nom du PNJ :")

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

		add2Key(r, v, 1)

		CloseDropDownMenus()
	end

	pSelectNpc:Hide()

	---------------------------------------------------------------------------------------------------------------------

	local dropdownSelectZoneValues = {"Type de mission :"}

	for o=1, getArraySize(LOCATIONS_LIST) do
		dropdownSelectZoneValues[o] = LOCATIONS_LIST[tostring(o)]["zoneText"][GetLocale()]
	end

	local dropdownSelectZoneValue = 0
	local pSelectZone = nil
	pSelectZone = CreateFrame("FRAME", "DropdownSelectZone" .. r, form_frame, "UIDropDownMenuTemplate")
	pSelectZone.line = i
	pSelectZone:SetPoint("TOPLEFT", 200, 50 - 15 * (r * 4) )
	UIDropDownMenu_SetWidth(pSelectZone, 150)
	UIDropDownMenu_SetText(pSelectZone, "Lieu :")

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

		add2Key(r, v, 2)

		CloseDropDownMenus()
	end

	pSelectZone:Hide()

	---------------------------------------------------------------------------------------------------------------------

	local ppLine = nil
	local missions_types = {"Type de mission :", "Parler à un PNJ", "Trouver un lieu", "Ramasser un item", "Tuer des mobs", "Répondre à une question", "Interagir avec un joueur"}
	local dropdownValue = 1

	local ppLine = CreateFrame("FRAME", "DropdownMissionType" .. r, main_window, "UIDropDownMenuTemplate")
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

		pSelectNpc:Hide()

		if v == 1 then
			pSelectZone:Hide()
			pSelectNpc:Show()
		elseif v == 2 then
			pSelectNpc:Hide()
			pSelectZone:Show()
		end

		CloseDropDownMenus()
	end

	first[r] = ppLine

	---------------------------------------------------------------------------------------------------------------------
end


local submit_button = CreateFrame("Button", "GenerateKeyButton", main_window, "GameMenuButtonTemplate")
submit_button:SetPoint("BOTTOMLEFT", 25, 25)
submit_button:SetHeight(25)
submit_button:SetWidth(150)
submit_button:SetText("Générer la clé")

submit_button:SetScript("OnClick", function(self)
	local k = NuttenhAdmin.key:gsub("% ", "")
	print(k)
end)

local start_button = CreateFrame("Button", "StartEventButton", main_window, "GameMenuButtonTemplate")
start_button:SetPoint("BOTTOMRIGHT", -25, 25)
start_button:SetHeight(25)
start_button:SetWidth(150)
start_button:SetText("Démarrer avec cette clé")

start_button:SetScript("OnClick", function(self)
	local k = NuttenhAdmin.key:gsub("% ", "")
	eventCommand("start " .. k .. " Soleo")
end)

local close_button = CreateFrame("Button", "CloseButton1", main_window, "GameMenuButtonTemplate")
close_button:SetPoint("TOPRIGHT", -25, 25)
close_button:SetHeight(25)
close_button:SetWidth(150)
close_button:SetText("KassToa")

close_button:SetScript("OnClick", function(self)
	main_window:Hide()
end)
--[[


local editBox = CreateFrame("EditBox", "MissionsTypesDropdowna", main_window, "SearchBoxTemplate")
editBox:SetWidth(150)
editBox:SetHeight(30)
editBox:SetPoint("TOPRIGHT", -15, -15)


]]