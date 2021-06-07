local reloadConfig = {
  text = 'Reload Hammerspoon Configuration',
  subText = 'Console content will be cleared first',
  image = hs.image.imageFromAppBundle('org.hammerspoon.Hammerspoon'),

  action = function()
    require('lib.reload').reload()
  end
}

local toggleAirPods = {
  text = 'Toggle AirPods',
  subText = 'Connect / Disconnect NBN AirPods',
  image = hs.image.imageFromName('NSBluetoothTemplate'),

  action = function()
    require('lib.airpods').toggle()
  end
}

local showAirPodsStatus = {
  text = 'Show AirPods Status',
  subText = 'Show if AirPods is connected or not',
  image = hs.image.imageFromName('NSBluetoothTemplate'),

  action = function()
    require('lib.airpods').status()
  end
}

-- Assemble Module

local actions = {}
local m = hs.chooser.new(function(item)
  actions[item.id]()
end)

-- Install choose items
local function install(items)
  for _, item in ipairs(items) do
    item.id = hs.host.uuid()

    local action = item.action
    item.action = nil

    actions[item.id] = action
  end

  m:choices(items)
end

install {
  reloadConfig,
  toggleAirPods,
  showAirPodsStatus,
}

m:searchSubText(true)

return m
