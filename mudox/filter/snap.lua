-- vim: fdm=marker

local log = hs.logger.new("snap")
log.setLogLevel("debug")

local wf = hs.window.filter
local cell = require("mudox.grid")
local layout = require("mudox.layout")
local approx = layout.approx

-- local rejectApps = {
-- 'Alfred',
-- 'BetterZip',
-- 'Paletro Preferences',
-- 'Problem Reporter',
-- 'Session',
-- 'Setapp',
-- 'SetappAgent',
-- 'Simulator',
-- 'Stickies',
-- 'Surge',
-- 'System Information',
-- 'System Preferences',
-- 'VLC',
-- '爱奇艺',
-- '腾讯视频',
-- }

local sheetApps = { "Numi", "Dictionary", "Hammerspoon" }

local fullscreenApps = {
	"Dash",
	"Firefox",
	"OmniGraffle",
	"Safari",
	"Sketch",
	"Tower",
	"Xcode",
	"kitty",
}

local f = wf.new()
-- f:setOverrideFilter({allowRoles = {'AXStandardWindow'}})
f:setCurrentSpace(true)

-- for _, app in ipairs(rejectApps) do
-- f:rejectApp(app)
-- end

local function snap(win, name, event)
	log.df("Event: %s, App: %s", event, name)

	local rect = win:frame()

	if approx(rect, cell.fullscreen) then
		log.df("apply [fullscreen]")
		layout.fullscreen(win)
	elseif approx(rect, cell.left) then
		log.df("approx [left]")
		-- currently noop
	elseif approx(rect, cell.right) then
		log.df("approx [right]")
		-- currently noop
	elseif approx(rect, cell.sheet()) then
		log.df("approx [sheet]")
		-- currently noop
	elseif approx(rect, cell.form()) then
		log.df("approx [form]")
		-- currently noop
	else
		-- log.df('free layout')

		-- do nothing if the application open multiple windows
		-- if #win:application():allWindows() > 1 then
		-- log.df('app opened multiple windows, skip')
		-- return
		-- end

		-- if fx.contains(fullscreenApps, name) then
		-- log.df('apply layout [fullscreen]')
		-- layout.fullscreen(win)
		-- elseif fx.contains(sheetApps, name) then
		-- log.df('apply layout [sheet]')
		-- layout.sheet(win)
		-- else
		-- log.df('not in app lists,skip')
		-- layout.form(win)
		-- end
	end
end

f:subscribe(wf.windowOnScreen, snap)
-- f:subscribe(wf.windowFocused, snap)

-- f:pause()

return { filter = f }
