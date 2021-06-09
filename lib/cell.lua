local g = require('hs.geometry')
local screen = hs.screen.mainScreen():frame()
local spacing = 10

local half_x = screen.w / 2
local half_y = screen.h / 2
local half_w = half_x - spacing * 1.5
local half_h = half_y - spacing * 1.5
local size25 = g {w=half_w, h=half_h}

-- left half with spacing
local left50 = g.copy(screen)
left50.xy = g { spacing, spacing }
left50.w = half_w
left50.y2 = screen.y2 - spacing

-- right half with spacing
local right50 = g.copy(screen)
right50.x = half_x + spacing * 0.5
right50.y = spacing
right50.x2 = screen.x2 - spacing
right50.y2 = screen.y2 - spacing

-- top left
local topLeft25 = g.copy(screen)
topLeft25.xy = g { spacing, spacing }
topLeft25.wh = size25

-- bottom left
local bottomLeft25 = g.copy(topLeft25)
bottomLeft25.y = half_y + spacing * 0.5

-- top right
local topRight25 = g.copy(topLeft25)
topRight25.x = half_x + spacing * 0.5

-- bottom right
local bottomRight25 = g.copy(bottomLeft25)
bottomRight25.x = half_x + spacing * 0.5

-- Assemble module

return {
    left50 = left50,
    right50 = right50,

    topLeft25 = topLeft25,
    topRight25 = topRight25,
    bottomLeft25 = bottomLeft25,
    bottomRight25 = bottomRight25,
}