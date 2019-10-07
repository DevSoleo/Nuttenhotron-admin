NuttenhAdmin = {}
NuttenhAdmin.addonName = "Event-Admin"

addonName = "Event-Admin"
eventAdmin = "Soleo"

if vAGet("firstLaunch") ~= 1 then
	vASmoothClear()
	vASave("firstLaunch", 1)
end
