local wezterm = require "wezterm"

-- local launch_menu = {}
local padding = {
  left = "1cell",
  right = "1cell",
  top = "0.5cell",
  bottom = "0.5cell",
}

-- Reload the configuration every ten minutes
wezterm.time.call_after(600, function()
  wezterm.reload_configuration()
end)

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
  local names = { name, "mini-file-icons", "Hack Nerd Font", "SauceCodePro Nerd Font" }
  return wezterm.font_with_fallback(names, params)
end

local function get_theme()
  local _time = os.date("*t")
  if _time.hour >= 1 and _time.hour < 9 then
    return "Rosé Pine (base16)"
  elseif _time.hour >= 9 and _time.hour < 17 then
    return "tokyonight_night"
  elseif _time.hour >= 17 and _time.hour < 21 then
    return "Catppuccin Mocha"
  elseif _time.hour >= 21 and _time.hour < 24 or _time.hour >= 0 and _time.hour < 1 then
    return "kanagawabones"
  end
end

return {
  bidi_enabled = true,
  bidi_direction = "AutoLeftToRight",
  color_scheme = get_theme(),
  font = font_with_fallback({
    family = "FiraCode Nerd Font",
    harfbuzz_features = {
      "zero",
    },
  }),
  font_rules = {
    {
      intensity = "Bold",
      font = font_with_fallback {
        family = "Liga SFMono Nerd Font",
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
        family = "Iosevka Nerd Font",
        -- family = "Dank Mono",
        weight = "Medium",
        italic = true,
      },
    },
    {
      italic = true,
      font = font_with_fallback {
        -- family = "Dank Mono",
        family = "Iosevka Nerd Font",
        weight = "Regular",
        italic = true,
      },
    },
  },
  send_composed_key_when_left_alt_is_pressed = true,
  send_composed_key_when_right_alt_is_pressed = true,
  initial_cols = 128,
  initial_rows = 32,
  use_dead_keys = false,
  window_padding = padding,
  window_decorations = "RESIZE",
  hide_tab_bar_if_only_one_tab = true,
  selection_word_boundary = " \t\n{}[]()\"'`,;:@",
  -- disable_default_key_bindings = true,
  line_height = 1.25,
  font_size = 12,
  window_background_opacity = 0.95,
  bold_brightens_ansi_colors = false,
  -- swap_backspace_and_delete = false,
  -- term = "wezterm",
  -- freetype_load_target = "Light",
 }
