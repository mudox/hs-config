local reloadConfig = {
  text = 'Reload Hammerspoon Configuration',
  subText = 'Console content will be cleared first',
  image = hs.image.imageFromAppBundle('org.hammerspoon.Hammerspoon'),

  action = function()
    require('lib.reload').reload()
  end,
  info = 'mudox'
}

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
local mac = require('lib.macos').chooserItems
local airpods = require('lib.airpods').chooserItems
local layout = require('lib.layout').chooserItems

install {
  reloadConfig,

  -- airpods
  airpods.toggle,
  airpods.check,

  -- layout
  layout.layoutFirefoxAndCode,

  -- mac
  mac.sleep,
  mac.displaySleep,
  mac.lock
}

m:searchSubText(true)

return m
