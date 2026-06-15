---@diagnostic disable: undefined-global
-- or specifically for just 'hl':
---@meta hl

-- Startup Commands
hl.on("hyprland.start", function ()
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("waybar")
end)


-- Variables
cmds = {
  screenshot       = "pkill slurp || hyprshot -z -m region -o ~/Pictures/screenshots",
  windowScreenshot = "pkill slurp || hyprshot -z -m window -o ~/Pictures/screenshots",
  colorPicker      = "pkill hyprpicker || hyprpicker",
  powerMenu        = "pkill wlogout || wlogout -b 5",
  appLauncher      = "pkill rofi || rofi -show drun",
  wallpaperPicker  = "pkill rofi || bash ~/.config/rofi/scripts/rofi-wallpapers.sh",
  fileManager      = "nautilus",
  terminal         = "ghostty",
  browser          = "zen-beta",
}

-- Monitor Configuration
hl.monitor({
  output = "eDP-1",
  mode = "2560x1600@165",
  position = "0x0",
  scale = 1,
})

-- Imports
require("colors")
require("modules.rules")
require("modules.configs")
require("modules.animations")
require("modules.binds")
