local opt = { "alt" }
local optShift = { "alt", "shift" }
local optCmd = { "alt", "cmd" }
local ctrlCmd = { "ctrl", "cmd" }
local ctrlOpt = { "ctrl", "alt" }
local ctrlOptCmd = { "ctrl", "alt", "cmd" }
local hyper = { "ctrl", "alt", "cmd", "shift" }

local M = {
  mods = {
    opt = opt,
    optShift = optShift,
    optCmd = optCmd,
    ctrlCmd = ctrlCmd,
    ctrlOpt = ctrlOpt,
    hyper = hyper,
  },

  opt = function(key, to, ...)
    hs.hotkey.bind(opt, key, to, ...)
  end,

  optShift = function(key, to, ...)
    hs.hotkey.bind(optShift, key, to, ...)
  end,

  cmdOpt = function(key, to, ...)
    hs.hotkey.bind(optCmd, key, to, ...)
  end,

  ctrlCmd = function(key, to, ...)
    hs.hotkey.bind(ctrlCmd, key, to, ...)
  end,

  ctrlOpt = function(key, to, ...)
    hs.hotkey.bind(ctrlOpt, key, to, ...)
  end,

  ctrlOptCmd = function(key, to, ...)
    hs.hotkey.bind(ctrlOptCmd, key, to, ...)
  end,

  hyper = function(key, to, ...)
    hs.hotkey.bind(hyper, key, to, ...)
  end,
}

M.prefix = M.ctrlOptCmd

return M
