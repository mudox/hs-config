local bind = require('lib.bind')

-- Show information of the foregournd app
bind.ctrlCmd(".", function()
  hs.openConsole()

  local app = hs.application.frontmostApplication()

  local info = string.format([[
    Foreground Application:
    App name:             %s
    Bundle path:          %s
    Bundle ID:            %s
    PID:                  %s
    IM source id:         %s
    ]],

    app:name(),
    app:path(),
    app:bundleID(),
    app:pid(),

    hs.keycodes.currentSourceID()
 )

  print(info)
end)
