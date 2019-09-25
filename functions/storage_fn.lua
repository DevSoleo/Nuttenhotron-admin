_Admin = {}

function vASave(name, value)
	_Admin[name] = value
end

function vAGet(name)
	return _Admin[name]
end

function vADelete(name)
	_Admin[name] = nil
end

function vASmoothClear()
	wait(0.1, vASave("key", ""))
	wait(0.1, vASave("isStarted", false))
	wait(0.1, vASave("playingUsers", {}))
	wait(0.1, vASave("isStarted", false))
	wait(0.1, vASave("maxTime", ""))
	wait(0.1, vASave("GM", ""))

end