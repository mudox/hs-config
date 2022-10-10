--  vim: fdm=marker fmr=\ 〈,\ 〉

local ids = require("mudox.bundle").ids
local finderIcon = hs.image.imageFromAppBundle(ids.finder)
local graffleIcon = hs.image.imageFromAppBundle(ids.graffle)

-- Finder 〈

local finderFiles = {
  {
    title = "Finder: Xcode Library folder",
    path = "~/Library/Developer/Xcode",
  },
  {
    title = "Finder: Xcode DerivedData folder",
    path = "~/Library/Developer/Xcode/DerivedData",
  },
  {
    title = "Finder: Develop/Apple folder",
    path = "~/Develop/Apple",
  },
}

local finderItems = pt.map(function(item)
  local r = {}
  r.text = item.title
  r.subText = item.subText or item.path
  r.image = finderIcon
  r.action = function()
    os.execute(('open "%s"'):format(pp.expanduser(item.path)))
  end
  return r
end, finderFiles)

-- 〉

-- Graffle 〈

local graffleFiles = {
  { title = "Swift Class Diagrams" },
  { title = "Design Patterns" },
}

local graffleItems = pt.map(function(item)
  local path = ("~/OneDrive/Graffle/%s.graffle"):format(item.title)

  local r = {}
  r.text = item.title
  r.subText = item.subText or path
  r.image = graffleIcon
  r.action = function()
    os.execute(('open "%s"'):format(pp.expanduser(path)))
  end
  return r
end, graffleFiles)

-- 〉

local chooserItems = fx.reduce({
  finderItems,
  graffleItems,
}, fx.concat)

return {
  chooserItems = chooserItems,
}
