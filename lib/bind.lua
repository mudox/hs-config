local alt = {'alt'}
local altShift = {'alt', 'shift'}
local altCmd = {'alt', 'cmd'}
local ctrlCmd = {'ctrl', 'cmd'}
local ctrlAlt = {'ctrl', 'alt'}
local ctrlAltCmd = {'ctrl', 'alt', 'cmd'}

return {
  mods = {
    alt = alt,
    altShift = altShift,
    altCmd = altCmd,
    ctrlCmd = ctrlCmd,
    ctrlAlt = ctrlAlt,
  },

  alt = function(key, to, ...)
    hs.hotkey.bind(alt, key, to, ...)
  end,

  altShift = function(key, to, ...)
    hs.hotkey.bind(altShift, key, to, ...)
  end,

  cmdAlt = function(key, to, ...)
    hs.hotkey.bind(altCmd, key, to, ...)
  end,

  ctrlCmd = function(key, to, ...)
    hs.hotkey.bind(ctrlCmd, key, to, ...)
  end,

  ctrlAlt = function(key, to, ...)
    hs.hotkey.bind(ctrlAlt, key, to, ...)
  end,

  ctrlAltCmd = function(key, to, ...)
    hs.hotkey.bind(ctrlAltCmd, key, to, ...)
  end,
}
