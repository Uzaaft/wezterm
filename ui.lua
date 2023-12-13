local wezterm = require "wezterm"

local M = {}

local process_icons = {
  fish = icons.md_fish,
  lazygit = icons.dev_git_merge,
  -- TODO: Replace this icon by the neovim one when available in Nerd Fonts.
  nvim = icons.fa_code,
  zsh = icons.dev_terminal_badge,
}
wezterm.on("format-tab-title", function(tab)
  -- Use the icon for the process, falling back to the process name.
  local process = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
  process = process_icons[process] or process

  -- When there's no process info, just show a laptop icon.
  process = #process > 0 and process or icons.md_laptop

  -- Current working directory.
  local cwd = tab.active_pane.current_working_dir
  cwd = cwd and string.format("%s ", cwd.file_path:gsub(os.getenv "HOME", "~")) or ""

  -- Format and return the title.
  return string.format("(%d %s) %s", tab.tab_index + 1, process, cwd)
end)
