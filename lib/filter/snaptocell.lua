local log = hs.logger.new('snaptocell')
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

local rejectApps = {
  'Alfred',
  'BetterZip',
  'Session',
  'Setapp',
  'SetappAgent',
  'Surge',
  'System Preferences',
  '爱奇艺',
  '腾讯视频',
  'System Information',
  'Paletro Preferences',
}

local sheetApps = {'Numi', 'Dictionary'}

local fullscreenApps = {
  'kitty',
  'Tower',
  'Dash',
  'Firefox',
  'Xcode',
  'Safari',
  'OmniGraffle',
  'Sketch',
}

local f = wf.new()
f:setDefaultFilter({allowRoles = {'AXStandardWindow'}})
f:setCurrentSpace(true)

for _, app in ipairs(rejectApps) do
  f:rejectApp(app)
end

f:subscribe(wf.windowOnScreen, function(win, name, event)
  log.df(('Event windowOnScreen: %s'):format(name))

  local wf = win:frame()

  if rectApproximate(wf, cell.grid11:cell(1, 1)) then
    log.f(('Apply layout [fullscreen] -> %s'):format(name))
    layout.fullscreen(win)
  elseif rectApproximate(wf, cell.grid12:cell(1, 1)) then
    log.f(('Dectect layout [left half] -> %s'):format(name))
    -- currently noop
  elseif rectApproximate(wf, cell.grid12:cell(1, 2)) then
    log.f(('Detect layout [right half] -> %s'):format(name))
    -- currently noop
  elseif rectApproximate(wf, cell.sheet()) then
    log.f(('Detect layout [sheet] -> %s'):format(name))
    -- currently noop
  elseif rectApproximate(wf, cell.form()) then
    log.f(('Detect layout [form] -> %s'):format(name))
    -- currently noop
  else
    -- do nothing if the application open multiple windows
    if #win:application():allWindows() > 1 then
      return
    end

    if fx.contains(fullscreenApps, name) then
      log.f(('Apply layout [fullscreen] -> %s'):format(name))
      layout.fullscreen(win)
    elseif fx.contains(sheetApps, name) then
      log.f(('Apply layout [sheet] -> %s'):format(name))
      layout.sheet(win)
    else
      log.f(('Apply layout [form] -> %s'):format(name))
      layout.form(win)
    end
  end
end)
