local ids = require("mudox.bundle").ids
local finderIcon = hs.image.imageFromAppBundle(ids.finder)

local xcodeLibrary = {
  text = "Open Xcode Library folder",
  subText = "~/Library/Developer/Xcode",
  image = finderIcon,

  action = function()
    os.execute("open ~/Library/Developer/Xcode")
  end,
}

local xcodeDerivedData = {
  text = "Open Xcode DerivedData folder",
  subText = "~/Library/Developer/Xcode/DerivedData",
  image = finderIcon,

  action = function()
    os.execute("open ~/Library/Developer/Xcode/DerivedData")
  end,
}

return {
  chooserItems = {
    xcodeLibrary = xcodeLibrary,
    xcodeDerivedData = xcodeDerivedData,
  },
}
