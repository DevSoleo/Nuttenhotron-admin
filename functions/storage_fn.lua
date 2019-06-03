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