local alt = {"alt"}
local altShift = {"alt", "shift"}
local cmdAlt = {"cmd", "alt"}
local ctrlCmd = {"ctrl", "cmd"}

return {
  alt = function(key, to) hs.hotkey.bind(alt, key, to) end,
  altShift = function(key, to) hs.hotkey.bind(altShift, key, to) end,
  cmdAlt  = function(key, to) hs.hotkey.bind(cmdAlt, key, to) end,
  ctrlCmd  = function(key, to) hs.hotkey.bind(ctrlCmd, key, to) end,
}
