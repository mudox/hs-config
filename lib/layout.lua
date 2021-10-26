-- vim: fdm=marker
local log = hs.logger.new('layout')
log.setLogLevel('debug')

local getApp = hs.application.get
local ctrlCmd = require('lib.bind').ctrlCmd
local cell = require('lib.grid')

-- Helpers {{{1

--- Determine if 2 rects approximate
local function approx(left, right, tolerance)
  tolerance = tolerance or 10

  return math.abs(left.x1 - right.x1) < tolerance and
           math.abs(left.x2 - right.x2) < tolerance and
           math.abs(left.y1 - right.y1) < tolerance and
           math.abs(left.y2 - right.y2) < tolerance
end

-- Hide other applications through system menu
local function hideOthers(name)
  local app = hs.application.get(name)
  if not app then
    return
  end
  return app:selectMenuItem('Hide Others')
end

--- Hide all other applications
-- @param ... bundle ID of application(s) to remain visible
local function onlyShow(...)
  local ids = {...}
  log.df('onlyShow')

  fx.each(hs.application.runningApplications(), function(app)
    if not fx.contains(ids, app:bundleID()) then
      if not app:isHidden() and #app:visibleWindows() > 0 then
        log.df('hide app %s', app:name())
        app:hide()
      end
    else
      if app:isHidden() and #app:allWindows() > 0 then
        log.df('unhide app %s', app:name())
        app:unhide()
      end
    end
  end)
end

--- Build table for `hs.layout.apply`
-- * 1st argument use hs.application object instead of name
local function spec(app, rect)
  return {app, nil, nil, nil, nil, rect}
end

-- }}}

-- Layout functions {{{1

-- Fullscreen
local function fullscreen(win)
  cell.grid11:moveTo(win, 1, 1)
  local id = win:application():bundleID()
  local ret = hideOthers(id)
  if not ret then
    log.wf('`hideOthers` failed on %s, fallback to `onlyShow`', id)
    onlyShow(win:application():bundleID())
  end
end

--- Center window
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
ctrlCmd('-', sheet)

-- Form
local function form()
  local win = hs.window.frontmostWindow()
  win:setFrame(cell.form())
end
ctrlCmd('=', form)

-- Left
ctrlCmd('h', function()
  local win = hs.window.frontmostWindow()
  cell.grid12:moveTo(win, 1, 1)
end)

-- Right
ctrlCmd('l', function()
  local win = hs.window.frontmostWindow()
  cell.grid12:moveTo(win, 1, 2)
end)

-- Fullscreen
ctrlCmd('m', function()
  local win = hs.window.frontmostWindow()
  fullscreen(win)
end)

--- Grid 1x2
-- @param left bundle ID of application in left pane
-- @param right bundle ID of application in right pane
local function g12(left, right)
  onlyShow(left, right)

  -- layout
  local firefox = spec(getApp(left), cell.grid12:cell(1, 1))
  local code = spec(getApp(right), cell.grid12:cell(1, 2))

  hs.layout.apply {firefox, code}
end

-- }}}

-- Chooseer items {{{1

local id = {
  dash = 'com.kapeli.dash-setapp',
  vscode = 'com.microsoft.VSCode',
  firefox = 'org.mozilla.firefox',
  notion = 'notion.id',
  iterm2 = 'com.googlecode.iterm2',
  kitty = 'net.kovidgoyal.kitty',
  preview = 'com.apple.Preview',
  xcode = 'com.apple.dt.Xcode',
}

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
    text = 'Layout: Dash & Code',
    subText = 'Browse doc and edit in VSCode',

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
  g12_xcode_dash = {
    text = 'Layout: Xcode & Dash',
    subText = 'Browse doc and edit in Xcode',

    action = function()
      g12(id.xcode, id.dash)
    end,
  },
}

-- }}}

-- Assemble module

return {
  approx = approx,

  hideOthers = hideOthers,
  onlyShow = onlyShow,
  fullscreen = fullscreen,

  sheet = sheet,
  form = form,

  chooserItems = chooserItems,
}
