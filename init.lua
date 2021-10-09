-- vim: fdm=marker
-- ! ORDER matters

-- Luarocks
require('lib.lua')
local rocksdir = os.getenv('HOME') .. '/Git/hs-config/.rocks'
package:addRocksTree(rocksdir, '5.4')

-- Globals
bx = require('lib.bind')
fx = hs.fnutils
d = hs.inspect
pl = require('pl.import_into')()
cls = hs.console.clearConsole

-- Reload
require('lib.reload')

-- Console
require('lib.console')

-- Log
require('lib.log')

-- Extensions to Lua language
require('lib.lua')

-- Disable window animation
hs.window.animationDuration = 0

-- Alert default style
require('lib.alert')

-- Root chooser
---@diagnostic disable-next-line: lowercase-global
rootChooser = require('lib.rootchooser')
bx.alt('r', function()
  rootChooser:show()
end)

-- Grid mode
require('lib.grid')

-- Switch apps
require('lib.switchapp')

-- Inspect frontmost app
require('lib.inspectapp')

-- Sound
require('lib.sound')

-- Window filters
-- require('lib.filter.cleargap')
-- require('lib.filter.snap')
-- require('lib.filter.inputmethod')

-- Pin to last line
hs.alert('Hammerspoon configuration reloaded')
