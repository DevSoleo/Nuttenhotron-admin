NuttenhAdmin = {}
NuttenhAdmin.addonName = "Event-Admin"

addonName = "Admin"
eventAdmin = "Soleo"

if vAGet("firstLaunch") ~= 1 then
	vASmoothClear()
	vASave("firstLaunch", 1)
end
