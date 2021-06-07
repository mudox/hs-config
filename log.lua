local log = {
  logdir = '/tmp/mudox/hammerspoon'
  logfilename = 'hammerspoon.log'
}

os.execute('mkdir -p /tmp/mudox/Hammerspoon &>/dev/null')
log.logfile = io.open(log.logfilename)

function log:error(text)
  self.logfile:write()
end
