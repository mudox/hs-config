local log = hs.logger.new('lua')

--- String interpolation
-- @example '%{k}: %{v}' % { k = 'key', v = 100}
getmetatable('').__mod = function(s, tab)
  return (s:gsub('($%b{})', function(w)
    return tab[w:sub(3, -2)] or w
  end))
end

--- Add Luarocks search paths to `package.path`
-- @param dir path same as in `luarocks --tree {path}`
-- @param ver lua version string
function package:addRocksTree(dir, ver)
  local pathdir = dir .. '/share/lua/' .. ver
  -- LuaFormatter off
  self.path = table.concat({
    ([[%s/?.lua]]):format(pathdir),
    ([[%s/?/init.lua]]):format(pathdir),
    self.path,
  }, ';')

  local cpathdir = dir .. '/lib/lua/' .. ver
  self.cpath = table.concat({
    ([[%s/?.so]]):format(cpathdir),
    self.cpath
  }, ';')
  -- LuaFormatter on
end
