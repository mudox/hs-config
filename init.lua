-- vim: fdm=marker
-- ! ORDER matters

-- Extensions to Lua language
require("mudox.lua")

-- Luarocks
local rocksdir = os.getenv("HOME") .. "/Git/hs-config/.rocks"
package:addRocksTree(rocksdir, "5.4")

-- Globals
bx = require("mudox.bind")
fx = hs.fnutils
d = hs.inspect
pl = require("pl.import_into")()
cls = hs.console.clearConsole

-- Reload
require("mudox.reload")

-- Console
require("mudox.console")

-- Log
require("mudox.log")

-- Disable window animation
hs.window.animationDuration = 0

-- Alert default style
require("mudox.alert")

-- Root chooser
alfred = require("mudox.rootchooser")
bx.hyper("space", function()
  alfred:show()
end)

-- Hammerspoon Grid UI
require("mudox.gridui")

-- Switch apps
require("mudox.switchapp")

-- Inspect frontmost app
require("mudox.inspectapp")

-- Sound
require("mudox.sound")

-- Window filters
require("mudox.filter.cleargap")
require("mudox.filter.snap")
require("mudox.filter.inputmethod")

-- Pin to last line
hs.alert("Hammerspoon configuration reloaded")
