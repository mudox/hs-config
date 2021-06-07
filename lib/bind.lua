local alt = {"alt"}
local altShift = {"alt", "shift"}
local cmdAlt = {"cmd", "alt"}

return {
  alt = function(key, to) hs.hotkey.bind(alt, key, to) end,
  altShift = function(key, to) hs.hotkey.bind(altShift, key, to) end,
  cmdAlt  = function(key, to) hs.hotkey.bind(cmdAlt, key, to) end,
}
