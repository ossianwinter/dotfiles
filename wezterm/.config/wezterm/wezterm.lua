local wezterm = require "wezterm"

function color_scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Modus-Vivendi"
  else
    return "Modus-Operandi"
  end
end

wezterm.on("window-config-reloaded", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  overrides.color_scheme = color_scheme_for_appearance(appearance)
  window:set_config_overrides(overrides)
end)

return {
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
}
