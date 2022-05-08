-- vim: fdm=marker fmr=〈,〉

local log = hs.logger.new("switchapp")
log.setLogLevel("debug")

local bind = require("mudox.bind")
local hyper = bind.mods.hyper
local alt = bind.mods.alt
local altShift = bind.mods.altShift

-- App Shortcusts 〈

local apps = {
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
	-- hyper table
	--
	{ hyper, "o", "FireFox" },
	{ hyper, "l", "kitty" },
}

-- Register app switching shortcuts

local alertID

hs.fnutils.each(apps, function(config)
	local combo, key, name = table.unpack(config)

	local function fn()
		log.df("openApplication")

		-- alert
		hs.alert.closeSpecific(alertID)
		alertID = hs.alert(name, 1)

		-- open app
		local app = hs.application.open(name)
		if not app then
			log.wf("failed to open application %s", name)
			return
		end
	end

	hs.hotkey.bind(combo, tostring(key), fn, nil, fn)
end)

-- 〉

-- Hyper table return { shortcuts = apps }
