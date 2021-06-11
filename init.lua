-- vim: fdm=marker
-- Reload Configuration
-- Pin it to fist line
require 'lib.reload'

local bind = require 'lib.bind'

-- Disable window animation
hs.window.animationDuration = 0

-- Inspect value in console
---@diagnostic disable-next-line: lowercase-global
d = hs.inspect

-- Toggle console window
bind.altShift('x', hs.toggleConsole)

-- Grid mode
require('lib.grid')

-- Alert default style
hs.alert.defaultStyle.radius = 4
hs.alert.defaultStyle.strokeWidth = 0.5

-- Root chooser
---@diagnostic disable-next-line: lowercase-global
rootChooser = require('lib.rootchooser')
bind.alt('r', function()
  rootChooser:show()
end)

-- App shortcuts
require 'lib.appshortcuts'

-- Inspect frontmost app
require 'lib.inspectapp'

-- Pin to last line
hs.alert('Hammerspoon configuration reloaded')
