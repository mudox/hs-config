-- system often auto-wake up from this kind of sleep
-- use `displaySleep` instead
local function sleep()
    hs.execute([[pmset sleepnow]])
end

local function dispalySleep()
    hs.execute([[pmset displaysleepnow]])
end

local _sleep = {
    text = 'Sleep',
    subText = 'Pub system into sleep, use `Display Sleep` instead',
    
    action = sleep,
}

local _displaySleep = {
    text = 'Display Sleep',
    subText = 'Pub display into sleep',
    
    action = dispalySleep,
}

-- Module
return {
    sleep = sleep,
    dispalySleep = dispalySleep,
    
    itemSleep = _sleep,
    itemDisplaySleep = _displaySleep,
}