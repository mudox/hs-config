local log = hs.logger.new("rchsr")

hs.chooser.globalCallback = function(chooser, event)
  chooser:query(nil)

  if event == "willOpen" then
    hs.closeConsole()
  end
end

-- Module

local actions = {}
local m = hs.chooser.new(function(item)
  if not item then
    return
  end
  actions[item.id]()
end)

local function install(items)
  for _, item in ipairs(items) do
    item.id = hs.host.uuid()

    local action = item.action
    item.action = nil

    actions[item.id] = action
  end

  m:choices(items)
end

-- Install chooser items here!
local chooserItems = {}
local mods = {
  "macos",
  "bluetooth",
  "layout",
  "imageschooser",
}

fx.each(mods, function(mod)
  local dict = require("mudox." .. mod).chooserItems

  local keys = pl.tablex.keys(dict)
  local items = pl.tablex.values(dict)

  log.f("%s -> %s", mod, keys)
  assert(type(items) == "table" and #items > 0)

  pl.tablex.insertvalues(chooserItems, items)
end)

install(chooserItems)

m:searchSubText(true):width(26)

return m
