local function reload()
  hs.console.clearConsole()
  hs.reload()
end

local function reloadConfigIfChanged(paths)
  local doReload = false

  print(paths)
  for _, file in pairs(paths or {}) do
    if file:sub(-4) == ".lua" then
      print(file .. ' changed')
      doReload = true
      break
    end
  end

  if doReload then
    print("A lua config file changed, reload")
    reload()
  else
    print("No lua file changed, skip reloading")
  end
end

local watcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfigIfChanged)
watcher:start()

-- Reload manually
hs.hotkey.bind({'alt', 'shift'}, 'r', reload)

return {
  watcher = watcher,
  reload = reload
}