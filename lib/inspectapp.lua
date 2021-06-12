local log = hs.logger.new 'lib.inspectapp'

-- Show information of the foregournd app
bx.ctrlCmd('.', function()
  hs.openConsole()

  local app = hs.application.frontmostApplication()

  log.i([[

  App name:             ${n}
  Bundle path:          ${p}
  Bundle ID:            ${id}
  PID:                  ${pid}
  IM source id:         ${im}
  ]] % {
    n = app:name(),
    p = app:path(),
    id = app:bundleID(),
    pid = app:pid(),
    im = hs.keycodes.currentSourceID(),
  })

end)
