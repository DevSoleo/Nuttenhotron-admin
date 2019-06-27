NuttenhAdmin = {}
NuttenhAdmin.addonName = "Event-Admin"

addonName = "Event-Admin"
eventAdmin = "Soleo"

local function hookPlayerMove(...)
	print("ok")
end
hooksecurefunc("CameraOrSelectOrMoveStart"	, hookPlayerMove)
hooksecurefunc("CameraOrSelectOrMoveStop"	, hookPlayerMove)


hooksecurefunc("MoveForwardStart"	, hookPlayerMove)
hooksecurefunc("MoveBackwardStart"	, hookPlayerMove)
hooksecurefunc("StrafeLeftStart"	, hookPlayerMove)
hooksecurefunc("StrafeRightStart"	, hookPlayerMove)
hooksecurefunc("JumpOrAscendStart"	, hookPlayerMove)
hooksecurefunc("ToggleAutoRun"		, hookPlayerMove)

