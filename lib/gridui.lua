local g = hs.grid
local margin = 8

g.ui.cellStrokeWidth = margin -- equal to margin
g.ui.cellStrokeColor = { 1, 0, 0, 0.4 }

g.ui.showExtraKeys = false

g.setMargins({ w = margin, h = margin })

require("lib.bind").altShift("3", function()
	hs.grid.toggleShow(nil, true)
end)
