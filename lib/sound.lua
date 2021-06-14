local au = hs.audiodevice

local step = 5

local function outDevice()
  local d = au.current().device
  if not d then
    hs.alert('No current output device')
  else
    return d
  end
end

local alertID

local function round(n)
  return n % 1 >= 5 and math.ceil(n) or math.floor(n)
end

local tink = hs.sound.getByName('Tink')

local function volumeUp()
  local dev = outDevice()
  local vol = dev:volume()

  if vol < 100 then
    vol = vol + step
    vol = 10 * math.ceil(vol / 10)
    vol = math.min(100, vol)

    dev:setVolume(vol)
    tink:stop():play()
  end

  hs.alert.closeSpecific(alertID)
  alertID = hs.alert(('Volume Up: %s'):format(round(vol)))
end

local function volumeDown()
  local dev = outDevice()
  local vol = dev:volume()

  if vol > 0 then
    vol = vol - step
    vol = 10 * math.floor(vol / 10)
    vol = math.max(0, vol)

    dev:setVolume(vol)
    tink:stop():play()
  end

  hs.alert.closeSpecific(alertID)
  alertID = hs.alert(('Volume Down: %s'):format(round(vol)))
end

local bind = require('lib.bind')

bind.ctrlAlt('[', volumeDown, nil, volumeDown)
bind.ctrlAlt(']', volumeUp, nil, volumeUp)
