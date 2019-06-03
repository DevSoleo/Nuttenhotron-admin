function generate_key(len)
	key = ""

	for i=1,len do
		key = key .. tostring(math.random(1, 9))
	end

	return key
end

function group_key(key, chunkSize)
    local s = {}

    for i = 1, #key, chunkSize do
        s[#s + 1] = key:sub(i, i + chunkSize - 1)
    end

    return s
end

function get_mission_type(group)
	group = tostring(group)
	return group:sub(1, 1)
end

function get_setting(group, id)
	group = tostring(group)

	if id == 1 then
		return group:sub(2, 2)
	elseif id == 2 then 
		return tonumber(group:sub(1, 1)) * tonumber(group:sub(2, 2))
	elseif id == 3 then 
		return tonumber(group:sub(1, 1)) + tonumber(group:sub(2, 2))
	end
end 