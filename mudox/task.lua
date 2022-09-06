-- vim: fdm=marker fmr=〈,〉

local img = require("mudox.asset").image
local ids = require("mudox.bundle").ids
local xcodeIcon = hs.image.imageFromAppBundle(ids.xcode)

local chooserItems = {}

-- Xcdoe Projects 〈

local function open(path)
  path = pp.expanduser(path)
  if pp.exists(path) then
    os.execute(('open "%s"'):format(path))
  else
    hs.alert("File not exists")
  end
end

local function openXcodeProject(project)
  return {
    text = ("Xcode: Open Project %s"):format(project.name),
    subText = project.description,
    image = xcodeIcon,
    action = function()
      local appleDir = "~/Develop/Apple"

      local path
      if project.type == "spm" then
        path = ("%s/Package.swift"):format(appleDir)
      elseif project.type == "xcworkspace" then
        path = ("%s/%s.xcworkspace"):format(appleDir, project.name)
      elseif project.type == "xcodeproj" then
        path = ("%s/%s.xcodeproj"):format(appleDir, project.name)
      elseif project.type == "playground" then
        path = ("%s/%s.playground"):format(appleDir, project.name)
      end

      open(path)
    end,
  }
end

-- type: spm|playground|xcodeproj|xcworkspace
local xcode_projects = {
  -- SPM projects
  {
    name = "Gangxia",
    description = "Vapor server",
    type = "spm",
  },

  -- Bare playgrounds
  {
    name = "Concurrency",
    description = "Tags: swift concurrency async",
    type = "playground",
  },
}

chooserItems = fx.concat(chooserItems, pt.map(openXcodeProject, xcode_projects))

-- 〉

-- Books 〈

local books = {
  {
    text = "Book: Modern Concurrency in Swift",
    subText = "Tags: swift, concurrency",
    image = img("open-book.png"),
    action = function()
      open("~/Downloads/Books/iOS/Modern Concurrency in Swift.pdf")
    end,
  },
  {
    text = "Book: Server Side Swift with Vapor",
    subText = "Tags: swift, concurrency, server",
    image = img("open-book.png"),
    action = function()
      open("~/Downloads/Books/iOS/Server Side Swift with Vapor 3rd Edition.pdf")
    end,
  },
}

chooserItems = fx.concat(chooserItems, books)

-- 〉

return {
  chooserItems = chooserItems,
}
