local log = hs.logger.new('lib.task')

return {
  chooserItems = {
    addNeovimPluginSpec = {
      text = 'Create Neovim Plugin Spec File',
      subText = 'Input a unique filename',
      action = function()
        local ok, input = hs.dialog.textPrompt('File Name',
                                               'Please input a unique filename')
        if ok ~= 'OK' and not input then
          return
        end

        local cmd = os.getenv('HOME') ..
                        '/Git/hs-config/script/add_neovim_plugin_spec.sh'
        local output, status = hs.execute(('sh "%s" "%s"'):format(cmd, input))
        if not status then
          log.e(output)
        end
      end,
    },
  },
}
