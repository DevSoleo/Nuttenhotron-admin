function array_search(array, value)
	local index = {}
  
	for k, v in pairs(array) do
		index[v] = k
	end

 	return index[value]
end

function array_size(array)
	if array ~= nil then
		local counter = 0

		for index in pairs(array) do
		    counter = counter + 1
		end

		return counter
	else
		return nil
	end
end