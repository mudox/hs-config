local log = hs.logger.new('lib.filter.snaptocell')
log.setLogLevel('info')

local wf = hs.window.filter
local cell = require('lib.cell')
local layout = require('lib.layout')

local function rectApproximate(left, right, tolerance)
  tolerance = tolerance or 10

  return math.abs(left.x1 - right.x1) < tolerance and
           math.abs(left.x2 - right.x2) < tolerance and
           math.abs(left.y1 - right.y1) < tolerance and
           math.abs(left.y2 - right.y2) < tolerance
end

local f = wf.new()
f:setDefaultFilter({allowRoles = {'AXStandardWindow'}})
f:setAppFilter('Alfred', false)
f:subscribe(wf.windowOnScreen, function(win, name, event)
  log.df(('Event windowOnScreen: %s'):format(name))

  local f = win:frame()

  if rectApproximate(f, cell.grid11:cell(1, 1)) then
    log.f(('Apply layout [fullscreen] -> %s'):format(name))
    layout.fullscreen(win)
  elseif rectApproximate(f, cell.grid12:cell(1, 1)) then
    log.f(('Dectect layout [left half] -> %s'):format(name))
  elseif rectApproximate(f, cell.grid12:cell(1, 2)) then
    log.f(('Detect layout [right half] -> %s'):format(name))
  elseif rectApproximate(f, cell.sheet()) then
    log.f(('Detect layout [sheet] -> %s'):format(name))
  elseif rectApproximate(f, cell.form()) then
    log.f(('Detect layout [form] -> %s'):format(name))
  else
    log.f(('Found unknown frame layout, apply layout [form] -> %s'):format(name))
    layout.form(win)
  end
end)
