local log = hs.logger.new("mudox.reload")

local function reload()
  hs.console.clearConsole()
  hs.reload()
end

local function reloadConfigIfChanged(paths)
  local doReload = false

  for _, file in pairs(paths or {}) do
    if file:sub(-4) == ".lua" then
      doReload = true
      break
    end
  end

  if doReload then
    log.i("A lua config file changed, reload")
    reload()
  else
    log.i("No lua file changed, skip reloading")
  end
end

local path = os.getenv("HOME") .. "/.hammerspoon/"
local watcher = hs.pathwatcher.new(path, reloadConfigIfChanged)
watcher:start()

-- Reload manually
hs.hotkey.bind({ "alt", "shift" }, "r", reload)

return { watcher = watcher, reload = reload }
