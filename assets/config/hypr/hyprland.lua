---@diagnostic disable: undefined-global
-- or specifically for just 'hl':
---@meta hl

-- Remove update notifications

-- Startup Commands
hl.on("hyprland.start", function()
	-- dbus-update-activation-environment removed; UWSM handles this natively
	hl.exec_cmd("uwsm app -- awww-daemon")
	hl.exec_cmd("uwsm app -- waybar")
end)

-- Variables
cmds = {
	screenshot = "pkill slurp || uwsm app -- hyprshot -z -m region -o ~/Pictures/screenshots",
	windowScreenshot = "pkill slurp || uwsm app -- hyprshot -z -m window -o ~/Pictures/screenshots",
	colorPicker = "pkill hyprpicker || uwsm app -- hyprpicker",
	powerMenu = "pkill wlogout || uwsm app -- wlogout -b 5",
	appLauncher = "pkill rofi || uwsm app -- rofi -show drun",
	wallpaperPicker = "pkill rofi || uwsm app -- bash ~/.config/rofi/scripts/rofi-wallpapers.sh",
	fileManager = "uwsm app -- nautilus",
	terminal = "uwsm app -- ghostty",
	browser = "uwsm app -- zen-beta",
}

-- Monitor Configuration
hl.monitor({
	output = "eDP-1",
	mode = "2560x1600@165",
	position = "0x0",
	scale = 1,
})

-- Imports
require("modules.rules")
require("modules.configs")
require("modules.animations")
require("modules.binds")
require("modules.colors")
