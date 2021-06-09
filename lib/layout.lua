local c = require('lib.cell')

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
            -- hs.layout.left50, nil, nil
            nil, nil, c.left50
        }

        local code = {
            'Code', nil, nil,
            -- hs.layout.right50, nil, nil
            nil, nil, c.right50
        }

        hs.layout.apply { firefox, code }
    end
}


-- Assemble module

local m = {
    layoutFirefoxAndCode = layoutFirefoxAndCode
}

return m