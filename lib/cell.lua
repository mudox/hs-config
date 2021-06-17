local g = require('hs.geometry')
local screen = hs.screen.mainScreen():frame()

local Grid = {}

function Grid:new(rows, cols, spacing)
  local o = {rows = rows, cols = cols, spacing = spacing}

  setmetatable(o, self)
  self.__index = self

  return o
end

function Grid:cell(row, col)
  assert(row <= self.rows, 'invalid `row` value')
  assert(col <= self.cols, 'invalid `col` value')

  local w = (screen.w - self.spacing * (self.cols + 1)) / self.cols
  local h = (screen.h - self.spacing * (self.rows + 1)) / self.rows

  return g {
    x = self.spacing + (col - 1) * (self.spacing + w),
    y = self.spacing + (row - 1) * (self.spacing + h),
    w = w,
    h = h,
  }
end

function Grid:cells()
  local row = 0
  local col = 0

  return function()
    if row < self.rows then
      row = row + 1
    elseif col < self.cols then
      col = col + 1
      row = 1
    else
      return
    end

    return self:cell(row, col)
  end
end

function Grid:moveTo(win, row, col)
  win:setFrame(self:cell(row, col))
end

local spacing = 12

return {
  spacing = spacing,
  grid11 = Grid:new(1, 1, spacing), -- fullscreen with margin
  grid12 = Grid:new(1, 2, spacing),
  grid22 = Grid:new(2, 2, spacing),
  grid23 = Grid:new(2, 3, spacing),
  grid33 = Grid:new(3, 3, spacing),
}
