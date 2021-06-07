local cmd = os.getenv('HOME') .. '/.dotfiles/hammerspoon/script/airpods.sh'

local function toggle()
  local output = hs.execute('sh ' .. cmd .. ' toggle')
  hs.alert(output:gsub('%s*$', '', 1), 3)
end

local function status()
  local output = hs.execute('sh ' .. cmd .. ' status')
  print(hs.inspect(output))
  hs.alert(output:gsub('%s*$', '', 1), 3)
end

local m = {
  toggle = toggle,
  status = status, 
}

return m