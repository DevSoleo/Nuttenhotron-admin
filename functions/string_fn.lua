function split(str, delim)
    local t = {}

    for substr in string.gmatch(str, "[^" .. delim .. "]*") do
        if substr ~= nil and string.len(substr) > 0 then
            table.insert(t, substr)
        end
    end

    return t
end

function random_hash(len)
  if( len == nil or len <= 0 ) then len = 32; end;
  local holder = ""; -- a string for holding our hash temporarily

  hash_chars = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e",
                "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                "u", "v", "w", "x", "y", "z"};

  for i = 1, len do
    local index = math.random(1, #hash_chars);
    holder = holder .. hash_chars[index];
  end

  return holder;
end