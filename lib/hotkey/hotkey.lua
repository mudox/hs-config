local hyper = {'ctrl', 'cmd'}

-- Show information of the foregournd app
hs.hotkey.bind(hyper, ".", function()
  local app = hs.application.frontmostApplication()

  local info = string.format([[
  Foreground Application:
  App bundle path:      %s
  App name:             %s
  PID:                  %s
  IM source id:         %s
  ]],

  app:path(),
  app:name(),
  app:pid(),

  hs.keycodes.currentSourceID()
 )

print(info)
hs.openConsole()
end)
