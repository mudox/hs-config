local img = require("mudox.asset").image

return {
  chooserItems = {
    read1 = {
      text = "Read 'Modern Concurrency in Swift'",
      subText = "Tags: swift, concurrency, reading",
      image = img("open-book.png"),
      action = function()
        os.execute("open '/Users/mudox/Downloads/Books/iOS/Modern Concurrency in Swift.pdf'")
      end,
    },
  },
}
