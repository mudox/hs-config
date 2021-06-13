local bind = require('lib.bind')
local cell = require('lib.cell')

--- Hide all other windows
local function onlyShow(...)
  local names = {...}

  fx.each(hs.application.runningApplications(), function(app)
    if fx.contains(names, app:name()) then
      app:unhide()
    else
      app:hide()
    end
  end)

  fx.each(names, function(name)
    hs.application.launchOrFocus(name)
  end)
end

-- Build table for `hs.layout.apply`

local function spec(name, rect)
  return {name, nil, nil, nil, nil, rect}
end

-- Layout functions

--- grid 1x2
-- @param left name of application in left pane
-- @param right name of application in right pane
local function g12(left, right)
  onlyShow(left, right)

  -- layout
  local firefox = spec(left, cell.grid12:cell(1, 1))
  local code = spec(right, cell.grid12:cell(1, 2))

  hs.layout.apply {firefox, code}
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
  g22FirefoxAndCode = {
    text = 'Layout: Web & Editor',
    subText = 'Firefox (left50) - VSCode (right50)',

    action = function()
      g12('Firefox', 'Code')
    end,
  },
  g22FirefoxAndNotion = {
    text = 'Layout: Web & Note',
    subText = 'Firefox (left50) - Notion (right50)',

    action = function()
      g12('Firefox', 'Notion')
    end,
  },
}

-- Assemble module

return {chooserItems = chooserItems}
