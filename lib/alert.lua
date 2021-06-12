-- Default alert style
do
  local s = hs.alert.defaultStyle
  s.radius = 8
  s.fillColor = {white = 0, alpha = .75}

  -- no stroke
  s.strokeColor = s.fillColor
  s.strokeWidth = 2
end
