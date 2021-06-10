local cmd = os.getenv('HOME') .. '/Git/hs-config/script/airpods.sh'
local name = 'NBN AirPods'

--- Toggle connection status
-- @return 'connect' or 'disconnect'
local function toggle()
  local output = hs.execute('sh ' .. cmd .. ' toggle')
  return output:gsub('%s*$', '', 1), 3
end

--- Check airpods connection status
-- @return 'connected' or 'disconnected'
local function status()
  local output = hs.execute('sh ' .. cmd .. ' status')
  return output:gsub('%s*$', '', 1), 3
end

-- Chooser item

-- Module

local m = {
  toggle = toggle,
  status = status,

  chooserItems = {

    toggle = {
      text = 'Toggle AirPods',
      subText = 'Connect / Disconnect NBN AirPods',
      image = hs.image.imageFromName('NSBluetoothTemplate'),

      action = function()
        local s = toggle()
        local msg = ''

        if s == 'connect' then
          msg = ('Connecting %s'):format(name)
        else
          msg = ('Disconnecting %s'):format(name)
        end

        hs.alert(msg)
      end
    },

    check = {
      text = 'Show AirPods Status',
      subText = 'Show if AirPods is connected or not',
      image = hs.image.imageFromName('NSBluetoothTemplate'),

      action = function()
        local s = status()
        local msg

        if s == 'connected' then
          msg = ('%s Conncted'):format(name)
        else
          msg = ('%s Disconncted'):format(name)
        end

        hs.alert(msg)
      end
    }
  }
}

return m
