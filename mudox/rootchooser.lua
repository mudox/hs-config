local log = hs.logger.new("rchsr")

hs.chooser.globalCallback = function(chooser, event)
  chooser:query(nil)

  if event == "willOpen" then
    hs.closeConsole()
  end

  hs.chooser._defaultGlobalCallback(event)
end

-- Module

local actions = {}

local chooser = hs.chooser.new(function(item)
  if item then
    actions[item.id]()
  end
end)

local function reinstall(items)
  actions = {}

  for _, item in ipairs(items) do
    item.id = hs.host.uuid()

    -- move `actdion` function to cache
    local action = item.action
    assert(type(action) == "function")
    item.action = nil
    actions[item.id] = action
  end

  chooser:choices(items)
end

local function collectItems()
  local collectedItems = {}

  local mods = {
    "bluetooth",
    -- "macos",
    "task",
    "finder",
    "layout",
  }

  for _, mod in ipairs(mods) do
    local clone = pl.tablex.deepcopy(require("mudox." .. mod).chooserItems)
    for _, item in pairs(clone) do
      if type(item) == "function" then
        item = item()
      end
      table.insert(collectedItems, item)
    end
  end

  return collectedItems
end

chooser:searchSubText(true):width(30):bgDark(true)

return function()
  reinstall(collectItems())
  log.f("chooser show")
  chooser:show()
end
