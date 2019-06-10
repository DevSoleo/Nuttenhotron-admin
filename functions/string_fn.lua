function split(str, delim)
    local t = {}

    for sub_str in string.gmatch(str, "[^" .. delim .. "]*") do
        if sub_str ~= nil and string.len(sub_str) > 0 then
            table.insert(t, sub_str)
        end
    end

    return t
end

function splitByChunk(text, chunkSize)
	text = tostring(text)
    local s = {}

    for i=1, #text, chunkSize do
        s[#s + 1] = text:sub(i, i + chunkSize - 1)
    end

    return s
end

function crypt(k)
	local s = splitByChunk(k, 1)
	local c = ""

	local t = {"tk", "u4", "0k", "2s", "ny", "dy", "9l", "nn", "31", "rm"}

	for i,v in ipairs(s) do
	   c = c .. t[tonumber(v)]
	end

	return c
end

function cryptStr(text)
	local t = {"xt", "bm", "7j", "ag", "1l", "bn", "zb", "5e", "e4", "pl", "n2", "id", "za", "ca", "jn", "hy", "71", "49", "n9", "5f", "ob", "2h", "an", "bv", "vo"}
	local l = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}

	local s = splitByChunk(k, 1)
	local c = ""

	for i,v in ipairs(s) do
	   c = c .. t[tonumber(v)]
	end

	return c
end

