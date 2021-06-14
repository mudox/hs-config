local function lockScreen()
  hs.caffeinate.lockScreen()
end

-- system often auto-wake up from this kind of sleep
-- use `displaySleep` instead
local function sleep()
  lockScreen()
  hs.caffeinate.systemSleep()
  -- hs.execute([[pmset sleepnow]])
end

local function dispalySleep()
  lockScreen()
  hs.execute([[pmset displaysleepnow]])
end

-- Module
return {
  sleep = sleep,
  dispalySleep = dispalySleep,
  lockScreen = lockScreen,

  chooserItems = {
    sleep = {
      text = 'System Sleep',
      subText = 'My re-wake again ...',
      action = sleep,
    },

    displaySleep = {
      text = 'Display Sleep',
      subText = 'May re-wake again ...',
      action = dispalySleep,
    },

    lockScreen = {
      text = 'Lock Screen',
      subText = 'Back to login interface',
      action = lockScreen,
    },
  },
}
