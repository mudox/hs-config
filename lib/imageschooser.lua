local map = hs.fnutils.map
local imap = hs.fnutils.map

local function collect_items()
  local names = {}

  for _, v in pairs(hs.image.systemImageNames) do
    table.insert(names, v)
  end

  for _, t in pairs(hs.image.additionalImageNames) do
    for _, v in pairs(t) do
      table.insert(names, v)
    end
  end

  return hs.fnutils.imap(names, function(name)
    local icon = hs.image.imageFromName(name)
    if not icon then
      return nil
    end

    return {
      text = name,
      subText = 'Click to copy the name above into clipboard',
      image = icon,
    }
  end)
end

-- Module

local m = hs.chooser.new(function(item)
  if not item then
    return
  end

  hs.pasteboard.setContents(item.text)
end)

local items = collect_items()
m:choices(items):placeholderText(('Found %s images'):format(#items))

return {
  chooserItems = {
    allImages = {
      text = 'All Images',
      subText = 'Click to copy the name into clipboard',

      action = function()
        m:show()
      end,
    },
  },
}
