-- vim: fdm=marker
-- ! ORDER matters

HS_CONFIG_DIR = "/Users/Mudox/Git/hs-config"

-- Extensions to Lua language
require("mudox.lua")

-- Luarocks
local rocksdir = os.getenv("HOME") .. "/Git/hs-config/.rocks"
package:addRocksTree(rocksdir, "5.4")

-- Globals
bx = require("mudox.bind")
fx = hs.fnutils

pl = require("pl.import_into")()
pt = pl.tablex
pp = pl.path

d = hs.inspect
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

-- As of macOS Sierra and later, if you want a hs.chooser object to appear above full-screen
-- windows you must hide the Hammerspoon Dock icon first using: hs.dockicon.hide()
hs.dockicon.hide()

bx.hyper("return", require("mudox.rootchooser"))

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
