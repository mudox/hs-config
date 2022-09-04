local img = require("mudox.asset").image

local projects = {
  {
    name = "Gangxia",
    description = "Vapor server",
    type = "spm",
  },
}

local function openXcodeProject(project)
  return {
    text = ("Xcode: open project %s"):format(project.name),
    subText = project.description,
    image = img("project.png"),
    action = function()
      local appleDir = "~/Develop/Apple"
      if project.type == "spm" then
        os.execute(("open %s/Package.swift"):format(appleDir))
      elseif project.type == "xcworkspace" then
        os.execute(("open %s/%s.xcworkspace"):format(appleDir, project.name))
      elseif project.type == "xcodeproj" then
        os.execute(("open %s/%s.xcodeproj"):format(appleDir, project.name))
      end
    end,
  }
end

local function open(path)
  path = pp.expanduser(path)
  if pp.exists(path) then
    os.execute(('open "%s"'):format(path))
  else
    hs.alert("File not exists")
  end
end

return {
  chooserItems = {
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
  },
}
