local get = hs.application.get
local bind = require('lib.bind')
local cell = require('lib.cell')

local id = {
  dash = 'com.kapeli.dash-setapp',
  vscode = 'com.microsoft.VSCode',
  firefox = 'org.mozilla.firefox',
  notion = 'notion.id',
  iterm2 = 'com.googlecode.iterm2',
  kitty = 'net.kovidgoyal.kitty',
}

--- Hide all other windows
-- @param ... bundle ID of application(s) to remain visible
local function onlyShow(...)
  local ids = {...}

  fx.each(ids, function(id)
    if not get(id) then
      hs.application.open(id, 3, true)
    end
  end)

  fx.each(hs.application.runningApplications(), function(app)
    if not fx.contains(ids, app:bundleID()) then
      app:hide()
    else
      app:unhide()
    end
  end)
end

-- Build table for `hs.layout.apply`

-- * 1st argument use hs.application object instead of name
local function spec(app, rect)
  return {app, nil, nil, nil, nil, rect}
end

-- Layout functions

--- grid 1x2
-- @param left bundle ID of application in left pane
-- @param right bundle ID of application in right pane
local function g12(left, right)
  onlyShow(left, right)

  -- layout
  local firefox = spec(get(left), cell.grid12:cell(1, 1))
  local code = spec(get(right), cell.grid12:cell(1, 2))

  hs.layout.apply {firefox, code}
end

-- Move windows to left halef
bind.ctrlAlt('h', function()
  local win = hs.window.frontmostWindow()
  cell.grid12:moveTo(win, 1, 1)
end)

-- Move windows to right halef
bind.ctrlAlt('l', function()
  local win = hs.window.frontmostWindow()
  cell.grid12:moveTo(win, 1, 2)
end)

-- Fullscreen with margin
local function fullscreen(win)
  onlyShow(win:application():bundleID())
  cell.grid11:moveTo(win, 1, 1)
end

bind.ctrlAlt('m', function()
  local win = hs.window.frontmostWindow()
  if not win then
    return
  end

  fullscreen(win)
end)

-- Sheet
local function sheet()
  local win = hs.window.frontmostWindow()
  win:setFrame(cell.sheet())
end
bind.ctrlAlt('-', sheet)

-- Form
local function form()
  local win = hs.window.frontmostWindow()
  win:setFrame(cell.form())
end
bind.ctrlAlt('=', form)

-- Chooseer items

local chooserItems = {
  g22TermAndCode = {
    text = 'Layout: iTerm2 & Code',
    subText = 'iTerm2 (left50) - VSCode (right50)',

    action = function()
      g12(id.iterm2, id.vscode)
    end,
  },
  g22WebAndCode = {
    text = 'Layout: Web & iTerm2',
    subText = 'Firefox (left50) - iTerm2 (right50)',

    action = function()
      g12(id.firefox, id.iterm2)
    end,
  },
  g22WebAndTerm = {
    text = 'Layout: Web & Code',
    subText = 'Firefox (left50) - VSCode (right50)',

    action = function()
      g12(id.firefox, id.vscode)
    end,
  },
  g22DocAndCode = {
    text = 'Layout: Doc & Code',
    subText = 'Dash (left50) - VSCode (right50)',

    action = function()
      g12(id.dash, id.vscode)
    end,
  },
  g22WebAndNotion = {
    text = 'Layout: Web & Note',
    subText = 'Firefox (left50) - Notion (right50)',

    action = function()
      g12(id.firefox, id.notion)
    end,
  },
}

-- Assemble module

return {
  onlyShow = onlyShow,
  fullscreen = fullscreen,

  sheet = sheet,
  form = form,

  chooserItems = chooserItems,
}
