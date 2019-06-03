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

local favoriteNumber = 42 -- A user-configurable setting

-- Create the dropdown, and configure its appearance
local dropDown = CreateFrame("FRAME", "WPDemoDropDown", main_frame, "UIDropDownMenuTemplate")
dropDown:SetPoint("CENTER")
UIDropDownMenu_SetWidth(dropDown, 200)
UIDropDownMenu_SetText(dropDown, "Favorite number: " .. favoriteNumber)

-- Create and bind the initialization function to the dropdown menu
UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
 local info = UIDropDownMenu_CreateInfo()
 if (level or 1) == 1 then
  -- Display the 0-9, 10-19, ... groups
  for i=0,4 do
   info.text, info.checked = i*10 .. " - " .. (i*10+9), favoriteNumber >= i*10 and favoriteNumber <= (i*10+9)
   info.menuList, info.hasArrow = i, true
   UIDropDownMenu_AddButton(info)
  end

 else
  -- Display a nested group of 10 favorite number options
  info.func = self.SetValue
  for i=menuList*10, menuList*10+9 do
   info.text, info.arg1, info.checked = i, i, i == favoriteNumber
   UIDropDownMenu_AddButton(info, level)
  end
 end
end)

-- Implement the function to change the favoriteNumber
function dropDown:SetValue(newValue)
 favoriteNumber = newValue
 -- Update the text; if we merely wanted it to display newValue, we would not need to do this
 UIDropDownMenu_SetText(dropDown, "Favorite number: " .. favoriteNumber)
 -- Because this is called from a sub-menu, only that menu level is closed by default.
 -- Close the entire menu with this next call
 CloseDropDownMenus()
end