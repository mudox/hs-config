--- String interpolation
-- @example '%{k}: %{v}' % { k = 'key', v = 100}
getmetatable('').__mod = function(s, tab)
  return (s:gsub('($%b{})', function(w)
    return tab[w:sub(3, -2)] or w
  end))
end
