local log = hs.logger.new('cleargap')
log.setLogLevel('info')

local wf = hs.window.filter
local cell = require('lib.grid')
local layout = require('lib.layout')

local gap = cell.spacing
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

wf.new():setDefaultFilter({allowRegions = {top, bottom, left, right, mid}})
  :subscribe(wf.windowUnfocused, function(win, name, event)
    log.df(('Event windowUnFocused: %s'):format(name))

    local names = {'iTerm2', 'kitty', 'Firefox'}
    if fx.contains(names, name) then
      if name ~= hs.application.frontmostApplication():name() then
        log.df('hide %s', name)
        win:application():hide()
      end
    end
  end):pause()
