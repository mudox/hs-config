local ICON_SIZE = 120
local cache = {}

return function(codepoint)
  -- Try fetch from cache
  local image = cache[codepoint]
  if image then
    return image
  end

  -- Draw image
  local char = hs.styledtext.new(hs.utf8.char(codepoint), { font = {
    name = "SF Pro",
    size = ICON_SIZE,
  } })

  local canvas = hs.canvas.new { x = 0, y = 0, h = 0, w = 0 }
  canvas:size(canvas:minimumTextSize(char))
  canvas[#canvas + 1] = {
    type = "text",
    text = char,
  }
  image = canvas:imageFromCanvas()

  -- Cache image
  cache[codepoint] = image

  return image
end
