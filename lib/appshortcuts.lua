-- vim: fdm=marker
local bind = require('lib.bind')
local alt = bind.mods.alt
local altShift = bind.mods.altShift

--- App Shortcusts {{{1

local appShortcuts = {
  --
  -- alt + num for most commonly used applications
  --
  {alt, 1, 'Firefox'},
  {alt, 3, 'Notion'},
  {alt, 5, 'Preview'},
  {alt, 6, 'Books'},

  --
  -- alt + key to other commonly used applications
  --
  {alt, 'g', 'Google Chrome'},
  {alt, 'd', 'Dictionary'},
  {alt, 'p', 'Proxyman'},
  {alt, 't', 'Tower'},
  {alt, 'v', 'Visual Studio Code'},
  {alt, 'x', 'Xcode'},
  {alt, 'k', 'DeepL'},

  -- switch hand

  -- 7 is occpuied by the Pastes.app
  {alt, 8, 'Dash'},
  -- 9 is occupied by the SnippetsLab.app
  {alt, 0, 'Finder'},

  --
  -- alt + shift + num for less commonly used applications
  --
  {altShift, 1, 'Simulator'},
  -- {altShift, 2, 'Paw'},

  {altShift, 'g', 'OmniGraffle'},

  -- switch hand

  --
  -- cmd + alt for relatively less commonly used applications
  --

}

-- Register app switching shortcuts

hs.fnutils.each(appShortcuts, function(shortcut)
  local combo = shortcut[1]
  local key = tostring(shortcut[2])
  local name = shortcut[3]
  hs.hotkey.bind(combo, key, function()
    hs.alert(name, 1)
    hs.application.enableSpotlightForNameSearches(true)
    hs.application.launchOrFocus(name)
  end)
end)

--- }}}

return {shortcuts = appShortcuts}
