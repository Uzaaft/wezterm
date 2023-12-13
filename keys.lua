local wezterm = require "wezterm"
local act = wezterm.action

local M = {}

---@param config Config
function M.setup_keys(config)
  config.leader = { key = "a", mods = "CTRL" }
  config.keys = {
    { key = "a", mods = "LEADER|CTRL", action = wezterm.action { SendString = "\x01" } },
    { mods = "LEADER", key = "%", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { mods = "LEADER", key = "-", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "c", mods = "LEADER", action = act { SpawnTab = "CurrentPaneDomain" } },
    { key = "h", mods = "LEADER", action = act { ActivatePaneDirection = "Left" } },
    { key = "j", mods = "LEADER", action = act { ActivatePaneDirection = "Down" } },
    { key = "k", mods = "LEADER", action = act { ActivatePaneDirection = "Up" } },
    { key = "l", mods = "LEADER", action = act { ActivatePaneDirection = "Right" } },
  }
end

return M
