local cmd = os.getenv('HOME') .. '/Git/hs-config/script/bluetooth.sh'
local airpods = '38-ec-0d-58-93-7f'
local keyboard = '40-e6-4b-8a-a2-b3'

--- Toggle connection status
-- @return 'connect' or 'disconnect'
local function toggle(id)
  local output = hs.execute(('sh %s toggle %s'):format(cmd, id))
  return output:gsub('%s*$', '', 1)
end

--- Check airpods connection status
-- @return 'connected' or 'disconnected'
local function status(id)
  local output = hs.execute(('sh %s status %s'):format(cmd, id))
  return output:gsub('%s*$', '', 1)
end

--- Build chooser items for given device
-- @return {toggle = , check =,}
local function chooseItems(name, id)
  local toggleItem = {
    text = ('Toggle %s'):format(name),
    subText = ('Connect / Disconnect %s'):format(name),
    image = hs.image.imageFromName('NSBluetoothTemplate'),

    action = function()
      local s = toggle(id)
      local msg

      if s == 'connect' then
        msg = ('Connecting %s'):format(name)
      else
        msg = ('Disconnecting %s'):format(name)
      end

      hs.alert(msg)
    end,
  }

  local checkItem = {
    text = ('Show %s Status'):format(name),
    subText = ('Show if %s is connected or not'):format(name),
    image = hs.image.imageFromName('NSBluetoothTemplate'),

    action = function()
      local s = status(id)
      local msg

      if s == 'connected' then
        msg = ('%s Conncted'):format(name)
      else
        msg = ('%s Disconncted'):format(name)
      end

      hs.alert(msg)
    end,
  }

  return {toggle = toggleItem, check = checkItem}
end

-- Module

local airpodsItems = chooseItems('NBN AirPods', airpods)
local keyboardItems = chooseItems('NBN Keyboard', keyboard)

return {
  chooserItems = {
    checkAirPods = airpodsItems.check,
    toggleAirPods = airpodsItems.toggle,

    -- checkKeyboard = keyboardItems.check,
    -- toggleKeyboard = keyboardItems.toggle,
  },
}
