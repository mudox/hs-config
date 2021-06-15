hs.chooser.globalCallback = function(chooser, event)
  chooser:query(nil)

  if event == 'willOpen' then
    hs.closeConsole()
  end
end

-- Item: reload config

local reloadConfig = {
  text = 'Reload Hammerspoon Configuration',
  subText = 'Console content will be cleared first',
  image = hs.image.imageFromAppBundle('org.hammerspoon.Hammerspoon'),

  action = function()
    require('lib.reload').reload()
  end,
  info = 'mudox',
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
local bluetooth = require('lib.bluetooth').chooserItems
local layout = require('lib.layout').chooserItems
local image = require('lib.imageschooser').chooserItems
local task = require('lib.task').chooserItems

install {
  reloadConfig,

  -- bluetooth
  bluetooth.checkAirPods,
  bluetooth.toggleAirPods,

  bluetooth.checkKeyboard,
  bluetooth.toggleKeyboard,

  -- layout
  layout.g22DocAndCode,
  layout.g22WebAndCode,
  layout.g22WebAndNotion,

  -- mac
  mac.sleep,
  mac.displaySleep,
  mac.lockScreen,

  -- image
  image.allImages,

  -- task
  task.addNeovimPluginSpec,
}

m:searchSubText(true):width(26)

return m
