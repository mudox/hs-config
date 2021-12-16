-- vim: fdm=marker

local g = require("hs.geometry")
local screen = hs.screen.mainScreen():frame()

-- Class Grid {{{1

local Grid = {}

--- Define layout grid as rows x cols
--
-- @example
-- ```lua
-- local grid = Grid(2, 2, 10)
-- grid:cell(1, 1) -- left half pane
-- grid:cell(1, 2) -- right half pane
-- ```
-- @note row & col use 1-based index
function Grid:new(rows, cols, spacing)
	local o = { rows = rows, cols = cols, spacing = spacing }

	setmetatable(o, self)
	self.__index = self

	return o
end

--- Return `hs.geometry.rect` representing the cell in the grid
function Grid:cell(row, col)
	assert(row <= self.rows, "invalid `row` value")
	assert(col <= self.cols, "invalid `col` value")

	local w = (screen.w - self.spacing * (self.cols + 1)) / self.cols
	local h = (screen.h - self.spacing * (self.rows + 1)) / self.rows

	return g({
		x = self.spacing + (col - 1) * (self.spacing + w),
		y = self.spacing + (row - 1) * (self.spacing + h),
		w = w,
		h = h,
	})
end

--- For iterating cells in grid
--
-- @example: `for cell in grid:cells() do ... done`
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

--- Move hs.window to cell in the grid
function Grid:moveTo(win, row, col)
	win:setFrame(self:cell(row, col))
end

-- }}}

-- Predefined Grid & Cells {{{1

local spacing = 12

-- Sheet cell
local function sheet()
	local sf = hs.screen.mainScreen():frame()

	local r = g.copy(sf)
	r.h = r.h - 200
	r.w = math.ceil(r.h / 1.3)
	r.center = sf.center

	return r
end

-- Form cell
local function form()
	local sf = hs.screen.mainScreen():frame()

	local r = g.copy(sf)
	r.h = r.h - 200
	r.w = math.ceil(r.h * 1.3)
	r.center = sf.center

	return r
end

local grid11 = Grid:new(1, 1, spacing)
local grid12 = Grid:new(1, 2, spacing)

-- }}}

return {
	spacing = spacing,

	sheet = sheet,
	form = form,

	grid11 = grid11,
	fullscreen = grid11:cell(1, 1),

	grid12 = grid12,
	left = grid12:cell(1, 1),
	right = grid12:cell(1, 2),

	-- grid22 = Grid:new(2, 2, spacing),
	-- grid23 = Grid:new(2, 3, spacing),
	-- grid33 = Grid:new(3, 3, spacing),
}
