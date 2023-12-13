---@type Wezterm
local wezterm = require "wezterm"
local icons = wezterm.nerdfonts
local act = wezterm.action

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
  local names = { name, "mini-file-icons", "Hack Nerd Font", "SauceCodePro Nerd Font" }
  return wezterm.font_with_fallback(names, params)
end

local config = wezterm.config_builder()

require("icons").setup(config)
config.term = "wezterm"
-- More speed
config.front_end = "WebGpu"
-- ALL the speed
config.webgpu_power_preference = "HighPerformance"
config.cursor_thickness = 2
config.default_cursor_style = "SteadyBar"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.line_height = 1.2
config.font_size = 14
config.cell_width = 0.9
config.tab_bar_at_bottom = true
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "RESIZE"
config.audible_bell = "Disabled"
config.hide_tab_bar_if_only_one_tab = true
config.use_dead_keys = false
config.selection_word_boundary = " \t\n{}[]()\"'`,;:@"
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.window_background_opacity = 0.85
config.macos_window_background_blur = 100
config.underline_position = -6
config.underline_thickness = "250%"
config.font = font_with_fallback {
  family = "VictorMono Nerd Font",
  harfbuzz_features = {
    "zero",
  },
}
config.font_rules = {
  {
    intensity = "Bold",
    font = font_with_fallback {
      family = "VictorMono Nerd Font",
      harfbuzz_features = {
        "zero",
      },
      weight = "Medium",
    },
  },
  {
    italic = true,
    intensity = "Bold",
    font = font_with_fallback {
      family = "VictorMono Nerd Font",
      weight = "Medium",
      italic = true,
    },
  },
  {
    italic = true,
    font = font_with_fallback {
      family = "VictorMono Nerd Font",
      weight = "Regular",
      italic = true,
    },
  },
}

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
require("keys").setup_keys(config)
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

return config --[[@as Wezterm]]
