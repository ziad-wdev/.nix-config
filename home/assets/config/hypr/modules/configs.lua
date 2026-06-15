-- Configuration
hl.config({
  debug = {
    disable_logs = false,
    gl_debugging = true,
  },
  general = {
    border_size = 2,
    gaps_in = 6,
    gaps_out = 12,
    layout = "scrolling",
  },
  decoration = {
    rounding = 2,
    rounding_power = 10.0,
    active_opacity = 1.0,
    inactive_opacity = 0.85,
    blur = {
      enabled = true,
      size = 10,
      passes = 3,
      xray = 1,
      popups = 1,
      noise = 0.025,
      contrast = 0.9,
      brightness = 1.0,
      vibrancy = 0.2,
    },
    shadow = {
      enabled = true,
      color = "0x00000080",
      range = 8,
      render_power = 3,
    },
  },
  misc = {
    disable_hyprland_logo = true,
    vrr = 1,
  },
  input = {
    kb_layout = "us,ara",
    kb_options = "grp:win_space_toggle",
    numlock_by_default = true,
    accel_profile = "flat",
    mouse_refocus = false,
    touchpad = {
      natural_scroll = true,
    },
  },
  binds = {
    scroll_event_delay = 50,
    drag_threshold = 10,
  },
})
