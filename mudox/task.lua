local log = hs.logger.new("mudox.task")

local code_bin = "/usr/local/bin/code"

return {
	chooserItems = {
		openTry = {
			text = "Try Workspace",
			subText = 'Open the "Try" workspace in VSCode',

			action = function()
				hs.execute(code_bin .. " ~/Try")
			end,
		},
		openConfig = {
			text = "Config Workspace",
			subText = 'Open the "Config" workspace in VSCode',

			action = function()
				hs.execute(code_bin .. " ~/.dotfiles/vscode/config.code-workspace")
			end,
		},
		addNeovimPluginSpec = {
			text = "Create Neovim Plugin Spec File",
			subText = "Input a unique filename",
			action = function()
				local ok, input = hs.dialog.textPrompt("File Name", "Please input a unique filename")
				if ok ~= "OK" and not input then
					return
				end

				local cmd = os.getenv("HOME") .. "/Git/hs-config/script/add_neovim_plugin_spec.sh"
				local output, status = hs.execute(('sh "%s" "%s"'):format(cmd, input))
				if not status then
					log.e(output)
				end
			end,
		},
	},
}
