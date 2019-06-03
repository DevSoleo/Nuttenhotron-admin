function get_array_index(array, value)
  local index = {}
  
  for k, v in pairs(array) do
     index[v] = k
  end

  return index[value] + 1
end

function get_array_size(array)
	counter = 0

	for index in pairs(array) do
	    counter = counter + 1
	end

	return counter
end