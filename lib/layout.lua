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
  preview = 'com.apple.Preview',
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

-- cneter
local function center(win)
  local f = win:frame()
  local sf = hs.screen.mainScreen():frame()
  f.center = sf.center
  win:setFrame(f)
end

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
  g12_term_code = {
    text = 'Layout: Kitty & Code',
    subText = 'Browse info / man pages and edit in Visual Studio Code',

    action = function()
      g12(id.kitty, id.vscode)
    end,
  },
  g12_firefox_code = {
    text = 'Layout: Firefox & Kitty',
    subText = 'Browse web and run commands in terminal Kitty',

    action = function()
      g12(id.firefox, id.kitty)
    end,
  },
  g12_firefox_term = {
    text = 'Layout: Firefox & Code',
    subText = 'Browse web and edit in Visual Studio Code',

    action = function()
      g12(id.firefox, id.vscode)
    end,
  },
  g12_doc_code = {
    text = 'Layout: Doc & Code',
    subText = 'Browse doc in Dash and edit source code in Visual Studio Code',

    action = function()
      g12(id.dash, id.vscode)
    end,
  },
  g12_firefox_notion = {
    text = 'Layout: Firefox & Notion',
    subText = 'Browse web and take notes',

    action = function()
      g12(id.firefox, id.notion)
    end,
  },
  g12_kitty_notion = {
    text = 'Layout: Kitty & Notion',
    subText = 'Browse info page / man page and take notes',

    action = function()
      g12(id.kitty, id.notion)
    end,
  },
  g12_firefox_preview = {
    text = 'Layout: Firefox & Preview',
    subText = 'Browse web and read doc for comparing',

    action = function()
      g12(id.firefox, id.preview)
    end,
  },
  g12_preview_notion = {
    text = 'Layout: Preview & Notion',
    subText = 'Read and take notes',

    action = function()
      g12(id.preview, id.notion)
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
