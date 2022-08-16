-- vim: fdm=marker fmr=〈,〉

local log = hs.logger.new("switchapp")
log.setLogLevel("debug")

local bind = require("mudox.bind")
local hyper = bind.mods.hyper
local alt = bind.mods.alt
local altShift = bind.mods.altShift

-- stylua: ignore start
local apps = {
  -- Most commonly used applications
  { hyper,    "h", "kitty",              "net.kovidgoyal.kitty" },
  { hyper,    "l", "Google Chrome",      "com.google.Chrome" },
  { hyper,    "k", "Xcode-beta",         "com.apple.dt.Xcode" },

  { alt,      3,   "Notion",             "notion.id" },
  { alt,      4,   "Figma",              "com.figma.Desktop" },
  { alt,      5,   "Preview",            "com.apple.Preview" },
  { alt,      6,   "Books",              "com.apple.iBooksX" },
  { alt,      8,   "Dash",               "com.kapeli.dash-setapp" },
  { alt,      0,   "Finder",             "com.apple.finder" },

  { alt,      "d", "Dictionary",         "com.apple.Dictionary" },
  { alt,      "p", "Proxyman",           "com.proxyman.NSProxy-setapp" },
  { alt,      "t", "Tower",              "com.fournova.Tower3" },
  { alt,      "v", "Visual Studio Code", "com.microsoft.VSCode" },

  { altShift, 1,   "Simulator",          "com.apple.iphonesimulator" },

  { altShift, "g", "OmniGraffle",        "com.omnigroup.OmniGraffle7" },
}
-- stylua: ignore end

local alertID

hs.fnutils.each(apps, function(config)
  local combo, key, name, bundleID = table.unpack(config)

  local function fn()
    log.df("openApplication")

    -- alert
    hs.alert.closeSpecific(alertID)

    local icon = hs.image.imageFromAppBundle(bundleID)
    if icon then
      alertID = hs.alert.showWithImage(name, icon, 1)
    else
      alertID = hs.alert(name, 1)
    end

    -- open app
    hs.application.open(name, 0)
  end

  hs.hotkey.bind(combo, tostring(key), fn, nil, fn)
end)
