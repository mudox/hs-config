local log = hs.logger.new('lib.filter')
log.setLogLevel('info')

local wf = hs.window.filter

local gap = require('lib.cell').spacing
local frame = hs.screen.mainScreen():frame()

local top = hs.geometry.copy(frame)
top.h = gap

local bottom = hs.geometry.copy(frame)
bottom.y = frame.h - gap
bottom.h = gap

local left = hs.geometry.copy(frame)
left.w = gap

local right = hs.geometry.copy(frame)
right.x = frame.w - gap
right.w = gap

local mid = hs.geometry.copy(frame)
mid.x = frame.w / 2 - gap / 2
mid.w = gap

-- LuaFormatter off
wf.new()
  :setDefaultFilter({allowRegions = {top, bottom, left, right, mid}})
  :subscribe(wf.windowUnfocused,function(win, name, event)
    log.df(('windowUnFocused: %s'):format(name))

    local names = {'iTerm2', 'kitty', 'Firefox'}
    if fx.contains(names, name) then
      if name ~= hs.application.frontmostApplication():name() then
        log.df('hide %s', name)
        win:application():hide()
      end
    end
  end):pause()
-- LuaFormatter on

local function needReFullscreen(win)
  local f = win:frame()
  local sf = hs.screen.mainScreen():frame();
  local i = sf:intersect(f)

  if i.area / sf.area > 0.6 then
    log.f(('Re-fullscreen %s'):format(name))
    require('lib.layout').fullscreen(win)
  end
end

-- LuaFormatter off
wf.new({'iTerm2', 'kitty'})
  :subscribe(wf.windowFocused,function(win, name, event)
    log.df(('windowFocused: %s'):format(name))

    if needReFullscreen(win) then
      log.f(('Re-fullscreen %s'):format(name))
      local layout = require("lib.layout")
      layout.fullscreen(win)
      layout.onlyShow(win:application():bundleID())
    end
  end)
-- LuaFormatter on
