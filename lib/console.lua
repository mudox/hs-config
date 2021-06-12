local c = hs.console

bx.altShift('x', hs.toggleConsole)

-- Console appearance
c.toolbar(nil) -- remove toolbar
c.titleVisibility('hidden') -- hiden title & toolbar item labels
c.windowBackgroundColor({white = 1})
