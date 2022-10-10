-- vim: fdm=marker fmr=〈,〉

local log = hs.logger.new("task")

local img = require("mudox.asset").image
local ids = require("mudox.bundle").ids
local xcodeIcon = hs.image.imageFromAppBundle(ids.xcode)

local chooserItems = {}

-- Xcdoe Projects 〈

local function open(path)
  path = pp.expanduser(path)
  if pp.exists(path) then
    os.execute(('open "%s"'):format(path))
    hs.alert("Open " .. pl.path.basename(path))
  else
    hs.alert("File not exists")
    log.ef("Xcode project file not found in %s", path)
  end
end

local function openXcodeProject(project)
  return {
    text = ("Xcode: Open Project %s"):format(project.name),
    subText = project.description,
    image = xcodeIcon,
    action = function()
      local projectDir = "~/Develop/Apple/" .. project.name

      local path
      if project.path == nil then
        if project.type == "spm" then
          path = ("%s/Package.swift"):format(projectDir, project.name)
        elseif project.type == "xcworkspace" then
          path = ("%s/%s.xcworkspace"):format(projectDir, project.name)
        elseif project.type == "xcodeproj" then
          path = ("%s/%s.xcodeproj"):format(projectDir, project.name)
        elseif project.type == "playground" then
          path = ("%s/%s.playground"):format(projectDir, project.name)
        end
      else
        path = project.path
      end

      open(path)
    end,
  }
end

-- type: spm|playground|xcodeproj|xcworkspace
local xcode_projects = {
  -- Workspace projects
  {
    name = "HuiLong",
    description = "UIKit warehouse",
    type = "xcworkspace",
  },
  {
    name = "XiuFeng",
    description = "SwiftUI warehouse",
    type = "xcworkspace",
  },

  -- SPM projects
  {
    name = "GangXia",
    description = "Vapor server",
    type = "spm",
  },

  -- Bare playgrounds
  {
    name = "Date",
    description = "Tags: swift date locale formatter",
    type = "playground",
  },
  {
    name = "Concurrency",
    description = "Tags: swift concurrency async",
    type = "playground",
  },
  {
    name = "Alamofire",
    description = "Tags: swift network",
    path = "/Volumes/Mudox SSD/Git/Alamofire/Alamofire.xcworkspace",
  },
  {
    name = "Moya",
    description = "Tags: swift network",
    path = "/Volumes/Mudox SSD/Git/Moya/Moya.xcodeproj",
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
  {
    title = "Book: SwiftUI by Tutorials",
    description = "Tags: ui swift swiftui app",
    image = img("open-book.png"),
    path = "~/Downloads/Books/iOS/SwiftUI by Tutorials 4th.pdf",
  },
}

local function openBook(book)
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
