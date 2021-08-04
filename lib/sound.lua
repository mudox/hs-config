local au = hs.audiodevice

local step = 5

local function outDevice()
  local d = hs.audiodevice.current()
  return d.volume and d.device or nil
end

local alertID

local function round(n)
  return n % 1 >= 5 and math.ceil(n) or math.floor(n)
end

local function tink()
  return hs.sound.getByName('Tink')
end

local function volumeUp()
  local dev = outDevice()
  if not dev then
    hs.alert('Device does not supporting changing volume')
    return
  end

  local vol = dev:volume()

  if vol < 100 then
    vol = vol + step
    vol = 10 * math.ceil(vol / 10)
    vol = math.min(100, vol)

    dev:setVolume(vol)
    tink():stop():play()
  end

  hs.alert.closeSpecific(alertID)
  alertID = hs.alert(('Volume Up: %s'):format(round(vol)))
end

local function volumeDown()
  local dev = outDevice()
  if not dev then
    hs.alert('Device does not supporting changing volume')
    return
  end

  local vol = dev:volume()

  if vol > 0 then
    vol = vol - step
    vol = 10 * math.floor(vol / 10)
    vol = math.max(0, vol)

    dev:setVolume(vol)
    tink():stop():play()
  end

  hs.alert.closeSpecific(alertID)
  alertID = hs.alert(('Volume Down: %s'):format(round(vol)))
end

local bind = require('lib.bind')

bind.ctrlAlt('[', volumeDown, nil, volumeDown)
bind.ctrlAlt(']', volumeUp, nil, volumeUp)
