-- vim: fdm=marker

-- Reload Configuration
-- Pin it to fist line
require 'lib.reload'

local bind = require 'lib.bind'

-- Inspect value in console
d = hs.inspect

-- Toggle console window
bind.altShift('x', hs.toggleConsole)

-- Disable window animation
hs.window.animationDuration = 0

-- Alert default style
hs.alert.defaultStyle.radius = 4
hs.alert.defaultStyle.strokeWidth = 0.5

-- Root chooser
RootChooser = require('rootchooser')
bind.alt('r', function ()
  RootChooser:show()
end)


require 'lib.hotkey.hotkey'
require 'lib.hotkey.app'

-- Pin to last line
hs.alert('Hammerspoon configuration reloaded')