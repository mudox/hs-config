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
    title = "Book: Modern Concurrency in Swift",
    description = "Tags: swift, concurrency",
    image = img("open-book.png"),
    path = "~/Downloads/Books/iOS/Modern Concurrency in Swift.pdf",
  },
  {
    title = "Book: Server Side Swift with Vapor",
    description = "Tags: swift, concurrency, server",
    image = img("open-book.png"),
    path = "~/Downloads/Books/iOS/Server Side Swift with Vapor 3rd Edition.pdf",
  },
  {
    title = "Book: Design Patterns",
    description = "Tags: design pattern, object oriented programming",
    image = img("open-book.png"),
    path = "~/Downloads/Books/Design Patterns (GoF).pdf",
  },
}

function openBook(book)
  return {
    text = book.title,
    subText = book.description,
    image = book.image or img("open-book.png"),
    action = function()
      open(book.path)
    end,
  }
end

chooserItems = fx.concat(chooserItems, pt.map(openBook, books))

-- 〉

return {
  chooserItems = chooserItems,
}
