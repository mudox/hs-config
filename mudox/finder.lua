local ids = require("mudox.bundle").ids
local finderIcon = hs.image.imageFromAppBundle(ids.finder)

local items = {
  {
    text = "Finder: Xcode Library folder",
    path = "~/Library/Developer/Xcode",
  },
  {
    text = "Finder: Xcode DerivedData folder",
    path = "~/Library/Developer/Xcode/DerivedData",
  },
  {
    text = "Finder: Develop/Apple folder",
    path = "~/Develop/Apple",
  },
}

return {
  chooserItems = pt.map(function(item)
    item.subText = item.subText or item.path
    item.image = item.image or finderIcon
    item.action = function()
      local path = pp.expanduser(item.path)
      os.execute(('open "%s"'):format(path))
    end
    return item
  end, items),
}
