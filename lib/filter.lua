local log = hs.logger.new('lib.filter')
log.setLogLevel('debug')

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
    if name ~= hs.application.frontmostApplication():name() then
      log.df('hide %s[%s]', name, win:title())
      win:application():hide()
    end
  end)
-- LuaFormatter on
