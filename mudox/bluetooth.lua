local img = require("mudox.asset").image
local cmd = HS_CONFIG_DIR .. "/script/bluetooth.sh"
local airpods = "a4-c6-f0-e8-38-f1"

-- local keyboard = "40-e6-4b-8a-a2-b3"

--- Toggle connection status
-- @return 'connect' or 'disconnect'
local function toggleDevice(id)
  local output = hs.execute(("sh %s toggle %s"):format(cmd, id))
  return output:gsub("%s*$", "", 1)
end

--- Check airpods connection status
-- @return 'connected' or 'disconnected'
local function status(id)
  local output = hs.execute(("sh %s status %s"):format(cmd, id))
  return output:gsub("%s*$", "", 1)
end

local function device(name, id)
  local isConnected = function()
    return status(id) == "connected"
  end

  local function toggle()
    local text
    local subText
    local image

    if isConnected() then
      text = "Disconnect " .. name
      subText = name .. " is connnected"
      image = img("airpods-on.png")
    else
      text = "Connect " .. name
      subText = name .. " is disconnnected"
      image = img("airpods-off.png")
    end

    return {
      text = text,
      subText = subText,
      image = image,

      action = function()
        local s = toggleDevice(id)
        local msg

        if s == "connect" then
          msg = ("Connecting %s"):format(name)
        else
          msg = ("Disconnecting %s"):format(name)
        end

        hs.alert(msg)
      end,
    }
  end

  return { toggle = toggle, isConnected = isConnected }
end

-- Module

local airpodsItems = device("NBN AirPods", airpods)
-- local keyboardItems = chooseItems("NBN Keyboard", keyboard)

return {
  chooserItems = {
    airpodsItems.toggle,
  },
}
