local reloadConfig = {
  text = 'Reload Hammerspoon Configuration',
  subText = 'Console content will be cleared first',
  image = hs.image.imageFromAppBundle('org.hammerspoon.Hammerspoon'),

  action = function()
    require('lib.reload').reload()
  end
}

-- Module

local actions = {}
local m = hs.chooser.new(function(item)
  if not item then return end
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
install {
  reloadConfig,
  require('lib.airpods').toggleAirPods,
  require('lib.airpods').showAirPodsStatus,
  require('lib.layout').layoutFirefoxAndCode,
  require('lib.macos').itemSleep,
  require('lib.macos').itemDisplaySleep,
}

m:searchSubText(true)

return m
