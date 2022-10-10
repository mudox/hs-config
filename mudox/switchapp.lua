-- vim: fdm=marker fmr=〈,〉

local log = hs.logger.new("switchapp")
log.setLogLevel("debug")

local bind = bx
local hyper = bind.mods.hyper
local opt = bind.mods.opt
local optShift = bind.mods.optShift

-- stylua: ignore start
local apps = {
  -- Most commonly used applications
  { hyper,    "h", "kitty",              "net.kovidgoyal.kitty",        false },
  { hyper,    "l", "Google Chrome",      "com.google.Chrome",           false },
  { hyper,    "k", "Xcode",              "com.apple.dt.Xcode",          true  },

  { opt,      3,   "Notion",             "notion.id",                   false },
  { opt,      4,   "Figma",              "com.figma.Desktop",           false },
  { opt,      5,   "Preview",            "com.apple.Preview",           false },
  { opt,      6,   "Books",              "com.apple.iBooksX",           false },
  { opt,      8,   "Dash",               "com.kapeli.dash-setapp",      false },
  { opt,      0,   "Finder",             "com.apple.finder",            false },

  { opt,      "d", "Dictionary",         "com.apple.Dictionary",        false },
  { opt,      "p", "Proxyman",           "com.proxyman.NSProxy-setapp", false },
  { opt,      "t", "Tower",              "com.fournova.Tower3",         false },
  { opt,      "v", "Visual Studio Code", "com.microsoft.VSCode",        false },

  { optShift, 1,   "Simulator",          "com.apple.iphonesimulator",   false },

  { optShift, "g", "OmniGraffle",        "com.omnigroup.OmniGraffle7",  false },
}
-- stylua: ignore end

local alertID

hs.fnutils.each(apps, function(config)
  local combo, key, name, bundleID, execute = table.unpack(config)

  local function fn()
    log.df("openApplication")

    -- alert
    -- hs.alert.closeSpecific(alertID)

    local icon = hs.image.imageFromAppBundle(bundleID)
    alertID = hs.alert.showWithImage(name, icon, 1)

    -- open app
    -- if execute then
    os.execute(("open -a '%s'"):format(name))
    -- else
    --   hs.application.open(name, 0)
    -- end
  end

  hs.hotkey.bind(combo, tostring(key), fn, nil, fn)
end)
