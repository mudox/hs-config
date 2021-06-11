-- system often auto-wake up from this kind of sleep
-- use `displaySleep` instead
local function sleep()
  hs.caffeinate.systemSleep()
  -- hs.execute([[pmset sleepnow]]) 
end

local function dispalySleep()
  hs.execute([[pmset displaysleepnow]])
end

local function lockScreen()
  hs.caffeinate.lockScreen()
end

-- Module
return {
  sleep = sleep,
  dispalySleep = dispalySleep,
  lockScreen = lockScreen,

  chooserItems = {
    sleep = {text = 'Sleep', subText = 'Bye Bye', action = sleep},

    displaySleep = {
      text = 'Display Sleep',
      subText = 'Bye Bye',
      action = dispalySleep,
    },

    lockScreen = {
      text = 'Lock Screen',
      subText = 'Bye Bye',
      action = lockScreen,
    },
  },
}
