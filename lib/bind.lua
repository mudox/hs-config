return {
  alt = function(key, to, ...)
    hs.hotkey.bind({'alt'}, key, to, ...)
  end,

  altShift = function(key, to, ...)
    hs.hotkey.bind({'alt', 'shift'}, key, to, ...)
  end,

  cmdAlt = function(key, to, ...)
    hs.hotkey.bind({'cmd', 'alt'}, key, to, ...)
  end,

  ctrlCmd = function(key, to, ...)
    hs.hotkey.bind({'ctrl', 'cmd'}, key, to, ...)
  end,

  ctrlAlt = function(key, to, ...)
    hs.hotkey.bind({'ctrl', 'alt'}, key, to, ...)
  end
}
