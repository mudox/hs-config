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
  { hyper,    "h", "kitty",              "net.kovidgoyal.kitty",        false },
  { hyper,    "l", "Google Chrome",      "com.google.Chrome",           false },
  { hyper,    "k", "Xcode-beta",         "com.apple.dt.Xcode",          true  },

  { alt,      3,   "Notion",             "notion.id",                   false },
  { alt,      4,   "Figma",              "com.figma.Desktop",           false },
  { alt,      5,   "Preview",            "com.apple.Preview",           false },
  { alt,      6,   "Books",              "com.apple.iBooksX",           false },
  { alt,      8,   "Dash",               "com.kapeli.dash-setapp",      false },
  { alt,      0,   "Finder",             "com.apple.finder",            false },

  { alt,      "d", "Dictionary",         "com.apple.Dictionary",        false },
  { alt,      "p", "Proxyman",           "com.proxyman.NSProxy-setapp", false },
  { alt,      "t", "Tower",              "com.fournova.Tower3",         false },
  { alt,      "v", "Visual Studio Code", "com.microsoft.VSCode",        false },

  { altShift, 1,   "Simulator",          "com.apple.iphonesimulator",   false },

  { altShift, "g", "OmniGraffle",        "com.omnigroup.OmniGraffle7",  false },
}
-- stylua: ignore end

local alertID

hs.fnutils.each(apps, function(config)
  local combo, key, name, bundleID, execute = table.unpack(config)

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
    if execute then
      os.execute(("open -a '%s'"):format(name))
    else
      hs.application.open(name, 0)
    end
  end

  hs.hotkey.bind(combo, tostring(key), fn, nil, fn)
end)
