local bind = require('lib.bind')
local cell = require('lib.cell')
local fn = hs.fnutils

--- Hide all other windows
local function onlyShow(...)
  local names = {...}
  fn.each(hs.application.runningApplications(), function(app)
    if fn.contains(names, app:name()) then
      app:unhide()
    else
      app:hide()
    end
  end)
end

-- Build table for `hs.layout.apply`

local function spec(name, rect)
  return {name, nil, nil, nil, nil, rect}
end

-- Move windows
bind.ctrlAlt('h', function()
  local win = hs.window.frontmostWindow()
  cell.grid12:moveTo(win, 1, 1)
end)

bind.ctrlAlt('l', function()
  local win = hs.window.frontmostWindow()
  cell.grid12:moveTo(win, 1, 2)
end)

bind.ctrlAlt('m', function()
  local win = hs.window.frontmostWindow()
  if not win then
    return
  end

  onlyShow(win:application():name())
  cell.grid11:moveTo(win, 1, 1)
end)

-- Sheet
bind.ctrlAlt('-', function()
  local s = hs.screen.mainScreen():frame()
  local r = hs.screen.mainScreen():frame()
  r.h = r.h - 200
  r.w = math.ceil(r.h / 1.3)
  r.center = s.center

  local win = hs.window.frontmostWindow()
  win:setFrame(r)
end)

-- Form
bind.ctrlAlt('=', function()
  local s = hs.screen.mainScreen():frame()
  local r = hs.screen.mainScreen():frame()
  r.h = r.h - 200
  r.w = math.ceil(r.h * 1.3)
  r.center = s.center

  local win = hs.window.frontmostWindow()
  win:setFrame(r)
end)

-- Chooseer items

local chooserItems = {
  layoutFirefoxAndCode = {
    text = 'Layout: Firefox - VSCode',
    subText = 'Firefox (left50) - VSCode (right50)',

    action = function()
      onlyShow('Firefox', 'Code')

      -- layout
      local firefox = spec('Firefox', cell.grid12:cell(1, 1))
      local code = spec('Code', cell.grid12:cell(1, 2))

      hs.layout.apply {firefox, code}
    end,
  },
}

-- Assemble module

return {chooserItems = chooserItems}
