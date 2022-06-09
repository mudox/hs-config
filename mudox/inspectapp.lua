local log = hs.logger.new("mudox.inspectapp")
log.setLogLevel("info")

-- Show information of the foregournd app
bx.ctrlCmd(".", function()
  local win = hs.window.frontmostWindow()
  local app = win:application()

  hs.openConsole()

  log.i([[

  App name:             ${n}
  Bundle path:          ${p}
  Bundle ID:            ${id}
  PID:                  ${pid}
  ---
  Window title:         ${title}
  Window role:          ${role}
  Window subrole        ${subrole}
  ]] % {
    n = app:name(),
    p = app:path(),
    id = app:bundleID(),
    pid = app:pid(),
    -- im = hs.keycodes.currentSourceID(),
    title = win:title(),
    role = win:role(),
    subrole = win:subrole(),
  })
end)
