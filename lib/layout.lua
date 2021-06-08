local g = require('hs.geometry')
local mainScreenFrame = hs.screen.mainScreen():frame()
local spacing = 12

-- left half with spacing
local left50 = g.copy(mainScreenFrame)
left50.xy = g { spacing, spacing }
left50.w = mainScreenFrame.w / 2 - spacing * 1.5
left50.y2 = mainScreenFrame.y2 - spacing

-- right half with spacing
local right50 = g.copy(mainScreenFrame)
right50.x = mainScreenFrame.w / 2 + spacing * 0.5
right50.y = spacing
right50.x2 = mainScreenFrame.x2 - spacing
right50.y2 = mainScreenFrame.y2 - spacing

-- chooseer item
local layoutFirefoxAndCode = {
    text = 'Layout: Firefox - VSCode',
    subText = 'Firefox (left50) - VSCode (right50)',

    action = function()
        -- clean screen

        for _, app in ipairs(hs.application.runningApplications()) do
            if app:name() == 'Firefox' or app:name() == 'Code' then
                app:unhide()
            else
                app:hide()
            end
        end

        -- layout

        local firefox = {
            'Firefox', nil, nil,
            nil, nil, left50
        }

        local code = {
            'Code', nil, nil,
            nil, nil, right50
        }
        
        hs.layout.apply { firefox, code }
    end
}


-- Assemble module

local m = {
    layoutFirefoxAndCode = layoutFirefoxAndCode
}

return m