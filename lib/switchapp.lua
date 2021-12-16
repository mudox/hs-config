-- vim: fdm=marker

local log = hs.logger.new("switchapp")
log.setLogLevel("debug")

local bind = require("lib.bind")
local alt = bind.mods.alt
local altShift = bind.mods.altShift

--- App Shortcusts {{{1

local appShortcuts = {
	--
	-- alt + num for most commonly used applications
	--
	{ alt, 1, "Firefox" },
	{ alt, 3, "Notion" },
	{ alt, 5, "Preview" },
	{ alt, 6, "Books" },

	--
	-- alt + key to other commonly used applications
	--
	-- {alt, '`', 'iTerm'},
	{ alt, "g", "kitty" },
	{ alt, "d", "Dictionary" },
	{ alt, "p", "Proxyman" },
	{ alt, "t", "Tower" },
	{ alt, "v", "Visual Studio Code" },
	{ alt, "x", "Xcode" },

	-- switch hand

	-- 7 is occpuied by the Pastes.app
	{ alt, 8, "Dash" },
	-- 9 is occupied by the SnippetsLab.app
	{ alt, 0, "Finder" },

	--
	-- alt + shift + num for less commonly used applications
	--
	{ altShift, 1, "Simulator" },
	-- {altShift, 2, 'Paw'},

	{ altShift, "g", "OmniGraffle" },

	-- switch hand

	--
	-- cmd + alt for relatively less commonly used applications
	--
}

-- Register app switching shortcuts

local alertID

hs.fnutils.each(appShortcuts, function(shortcut)
	local combo = shortcut[1]
	local key = tostring(shortcut[2])
	local name = shortcut[3]

	hs.hotkey.bind(combo, key, function()
		log.df("openApplication")

		-- alert
		hs.alert.closeSpecific(alertID)
		alertID = hs.alert(name, 1)

		-- open app
		local app = hs.application.open(name, 1)
		if not app then
			log.wf("failed to open application %s", name)
			return
		end

		-- adjust window frame
		-- local win = app:mainWindow()
		-- if not win then
		-- log.wf('failed to get main window of application: %s', name)
		-- return
		-- end

		-- if layout.approx(win:frame(), cell.fullscreen) then
		-- log.df('apply fullscreen to application: %s', name)
		-- layout.fullscreen(win)
		-- end
	end)
end)

--- }}}

return { shortcuts = appShortcuts }
