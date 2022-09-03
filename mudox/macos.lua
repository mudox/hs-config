local function dispalySleep()
  hs.execute("pmset displaysleepnow")
end

local image = require("mudox.asset").image

-- Module
return {
  chooserItems = {
    {
      text = "System Sleep",
      subText = "My re-wake again ...",
      image = image("sleeping-1.png"),
      action = hs.caffeinate.systemSleep,
    },
    {
      text = "Display Sleep",
      subText = "May re-wake again ...",
      image = image("sleeping-2.png"),
      action = dispalySleep,
    },
    {
      text = "Lock Screen",
      subText = "Back to login interface",
      image = image("padlock.png"),
      action = hs.caffeinate.lockScreen,
    },
  },
}
