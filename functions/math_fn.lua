function round(num, decimal)
	local mult = 10 ^ (decimal or 0)

	return math.floor(num * mult + 0.5) / mult
end

function mod(a, b)
    return a - (math.floor(a/b)*b)
end