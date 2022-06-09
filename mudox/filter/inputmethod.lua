local log = hs.logger.new("inputmethod")
log.setLogLevel("info")

local wf = hs.window.filter

local apps = { "kitty", "Alfred" }

local f = wf.new()

f:subscribe(wf.windowFocused, function(win, name, event)
  if fx.contains(apps, name) then
    log.f(("%s windowFocused, change to ABC"):format(name))
    hs.keycodes.setLayout("ABC")
  end
end)
