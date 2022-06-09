-- vim: fdm=marker fmr=〈,〉

local log = hs.logger.new("switchapp")
log.setLogLevel("debug")

local bind = require("mudox.bind")
local hyper = bind.mods.hyper
local alt = bind.mods.alt
local altShift = bind.mods.altShift

local apps = {
  { alt, 1, "Firefox" },
  { alt, 3, "Notion" },
  { alt, 5, "Preview" },
  { alt, 6, "Books" },
  { alt, 8, "Dash" },
  { alt, 0, "Finder" },

  { alt, "g", "kitty" },
  { alt, "d", "Dictionary" },
  { alt, "p", "Proxyman" },
  { alt, "t", "Tower" },
  { alt, "v", "Visual Studio Code" },
  { alt, "x", "Xcode" },

  { altShift, 1, "Simulator" },

  { altShift, "g", "OmniGraffle" },

  { hyper, "h", "Google Chrome" },
  { hyper, "l", "FireFox" },
  { hyper, "j", "kitty" },
  { hyper, "k", "Xcode" },
}

local alertID

hs.fnutils.each(apps, function(config)
  local combo, key, name = table.unpack(config)

  local function fn()
    log.df("openApplication")

    -- alert
    hs.alert.closeSpecific(alertID)
    alertID = hs.alert(name, 1)

    -- open app
    local app = hs.application.open(name)
    if not app then
      log.wf("failed to open application %s", name)
      return
    end
  end

  hs.hotkey.bind(combo, tostring(key), fn, nil, fn)
end)
