-- vim: fdm=marker

local bind = require('lib.bind')

local alt = {"alt"}
local altShift = {"alt", "shift"}
local cmdAlt = {"cmd", "alt"}

-- Show / hide application
local function toggleApp(name)
  hs.application.enableSpotlightForNameSearches(true)
  hs.application.launchOrFocus(name)
end

-- Maximize app window

bind.altShift('f', function()
  local appWindow = hs.window.focusedWindow()

  if appWindow then
    appWindow:setFrame(appWindow:screen():frame())
  else
    hs.alert.show('no focused window found')
  end
end)

--- App Shortcusts {{{1

local appShortcuts = {

  --
  -- alt + num to swtich the main applications in my everyday life
  --
  {alt, 'g', 'Google Chrome'}      ,
  {alt, 'd', 'Dictionary'}         ,
  {alt, 'p', 'Proxyman'}           ,
  {alt, 't', 'Tower'}              ,
  {alt, 'v', 'Visual Studio Code'} ,
  {alt, 'x', 'Xcode'}              ,
  {alt, 'k', 'DeepL'}              ,

  {alt, 1  , 'Firefox'}            ,
  {alt, 3  , 'Notion'}             ,
  {alt, 5  , 'Preview'}            ,
  {alt, 6  , 'Books'}              ,

  -- switch hand

  -- 7 is occpuied by the Pastes.app
  {alt, 8, 'Dash'},
  -- 8 is occupied by the SnippetsLab.app
  {alt, 0, 'Finder'},

  --
  -- alt + shift + num for relatively less commonly used applications
  --

  {altShift, 1  , 'Simulator'}  ,
  {altShift, 2  , 'Paw'}        ,

  {altShift, 'g', 'OmniGraffle'},

  -- switch hand

  --
  -- cmd + alt for relatively less commonly used applications
  --

}

-- Register app switching shortcuts

for i = 1, #appShortcuts do
  local shortcut = appShortcuts[i]
  local combo = shortcut[1]
  local key = tostring(shortcut[2])
  local name = shortcut[3]
  hs.hotkey.bind(combo, key, function ()
    hs.alert(name, 1)
    hs.application.enableSpotlightForNameSearches(true)
    hs.application.launchOrFocus(name)
  end)
end

--- }}}

return {
  shortcuts = appShortcuts
}
