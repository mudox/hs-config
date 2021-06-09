local g = hs.grid
local c = hs.geometry.new
local margin = 10

g.ui.cellStrokeWidth = margin -- equal to margin
g.ui.cellStrokeColor = {1, 0, 0, 0.4}

-- hide keymap tips
g.ui.showExtraKeys = false

g.setMargins({w=10, h=10})