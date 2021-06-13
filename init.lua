-- vim: fdm=marker
require('lib.log')

-- Extensions to Lua language
require 'lib.lua'

-- Reload Configuration
require 'lib.reload'

-- Globals
bx = require 'lib.bind'
fx = hs.fnutils
d = hs.inspect

-- Disable window animation
hs.window.animationDuration = 0

-- Alert default style
require 'lib.alert'

-- Root chooser
---@diagnostic disable-next-line: lowercase-global
rootChooser = require('lib.rootchooser')
bx.alt('r', function()
  rootChooser:show()
end)

-- Grid mode
require 'lib.grid'

-- App shortcuts
require 'lib.appshortcuts'

-- Inspect frontmost app
require 'lib.inspectapp'

-- Sound
require 'lib.sound'

-- Console
require 'lib.console'

-- Pin to last line
hs.alert('Hammerspoon configuration reloaded')
