local cmd = os.getenv('HOME') .. '/Git/hs-config/script/airpods.sh'

local function toggle()
  local output = hs.execute('sh ' .. cmd .. ' toggle')
  hs.alert(output:gsub('%s*$', '', 1), 3)
end

local function status()
  local output = hs.execute('sh ' .. cmd .. ' status')
  hs.alert(output:gsub('%s*$', '', 1), 3)
end

-- Chooser item
local toggleAirPods = {
  text = 'Toggle AirPods',
  subText = 'Connect / Disconnect NBN AirPods',
  image = hs.image.imageFromName('NSBluetoothTemplate'),

  action = function()
    require('lib.airpods').toggle()
  end
}

-- Chooser item
local showAirPodsStatus = {
  text = 'Show AirPods Status',
  subText = 'Show if AirPods is connected or not',
  image = hs.image.imageFromName('NSBluetoothTemplate'),

  action = function()
    require('lib.airpods').status()
  end
}

-- Module

local m = {
  toggle = toggle,
  status = status, 
  toggleAirPods = toggleAirPods,
  showAirPodsStatus = showAirPodsStatus,
}

return m