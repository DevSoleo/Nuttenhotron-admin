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
	bgFile="Interface/Tooltips/UI-Tooltip-Background", -- 
	edgeFile="Interface/DialogFrame/UI-DialogBox-Border",
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

NuttenhAdmin.main_frame:SetBackdropColor(0, 0, 0);
NuttenhAdmin.main_frame:SetPoint("LEFT", 20, 0)

NuttenhAdmin.main_frame:Show()

-- Close button
local close_button = CreateFrame("Button", "CloseButton1", NuttenhAdmin.main_frame, "GameMenuButtonTemplate")
close_button:SetPoint("TOPRIGHT", 0, 0)
close_button:SetFrameStrata("HIGH")
close_button:SetFrameLevel(4)
close_button:SetHeight(27)
close_button:SetWidth(27)

local fontString = close_button:CreateFontString(nil, 'ARTWORK')
fontString:SetAllPoints()
fontString:SetFont("Fonts\\FRIZQT__.TTF", 20)
fontString:SetTextColor(255, 255, 0, 1)
fontString:SetShadowOffset(1, -1)
fontString:SetText("-")

close_button.fontString = fontString

local isMinimized = false

local function toggleFrameSize()
	if isMinimized == false then
		NuttenhAdmin.main_frame:SetHeight(60)
		isMinimized = true
	else
		NuttenhAdmin.main_frame:SetHeight(450)
		isMinimized = false
	end
end

close_button:SetScript("OnClick", function(self, arg1)
	if isMinimized == true then 
		fontString:SetText("-")
	else
		fontString:SetText("+")
		fontString:SetFont("Fonts\\FRIZQT__.TTF", 16)
	end

	toggleFrameSize()
end)

-- Mission List
NuttenhAdmin.main_frame.mission_list = CreateFrame("Frame", "MissionList", NuttenhAdmin.main_frame)
NuttenhAdmin.main_frame.mission_list:SetWidth(250)
NuttenhAdmin.main_frame.mission_list:SetHeight(400)
NuttenhAdmin.main_frame.mission_list:SetPoint("RIGHT", -50, 0)
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
scrollbar:SetMinMaxValues(1, 200) 
scrollbar.scrollStep = 200 / 100
scrollbar:SetValueStep(scrollbar.scrollStep) 
scrollbar:SetValue(0) 
scrollbar:SetWidth(16) 
scrollbar:SetScript("OnValueChanged", function (self, value) 
	self:GetParent():SetVerticalScroll(value) 
end)

local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND") 
scrollbg:SetAllPoints(scrollbar) 
scrollbg:SetTexture(0, 0, 0, 0) 
NuttenhAdmin.main_frame.mission_list.scrollbar = scrollbar 

--content frame 
NuttenhAdmin.main_frame.mission_list.content = CreateFrame("Frame", nil, scrollframe) 
NuttenhAdmin.main_frame.mission_list.content:SetSize(250, 250) 

scrollframe:SetScrollChild(NuttenhAdmin.main_frame.mission_list.content)
