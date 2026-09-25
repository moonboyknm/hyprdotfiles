-- #######################################################################################
-- THE IMPERIAL HYPRLAND CONFIGURATION (LUA PORT)
-- #######################################################################################

-----------------------------------------------------
---- MONITOR STRATEGY
-----------------------------------------------------
-- Set scale to 1.2 for optimal laptop screen density
hl.monitor({ output = "eDP-1", mode = "1920x1080@120", position = "0x0", scale = "1" })
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "1920x0", scale = "1" })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1" })

-----------------------------------------------------
---- ENVIRONMENT (The Atmosphere)
-----------------------------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("HYPRSHOT_DIR", "/home/moonboyknm/Pictures/Screenshots/")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-----------------------------------------------------
---- AUTOSTART (The Vanguard)
-----------------------------------------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	-- UI Components
	hl.exec_cmd("waybar &")
	hl.exec_cmd("swaync &")
	hl.exec_cmd("nm-applet --indicator &")
	hl.exec_cmd("blueberry-tray &")

	-- Wallpaper & Idle
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("sleep 1; waypaper --restore")
	hl.exec_cmd("hypridle")

	-- System Applications
	hl.exec_cmd("blueman")
	hl.exec_cmd("clipse -listen")
	hl.exec_cmd("kdeconnectd")
end)

-----------------------------------------------------
---- INPUT & GENERAL STRATEGY
-----------------------------------------------------
hl.config({
	input = {
		kb_layout = "us",
		follow_mouse = 1,
		touchpad = { natural_scroll = false },
		sensitivity = 0,
	},

	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 0,
		col = {
			active_border = {
				colors = { "rgba(ff0000ff)", "rgba(cc0000ff)" },
				angle = 45,
			},
			inactive_border = "rgba(222222aa)",
		},
		layout = "dwindle",
	},

	decoration = {
		rounding = 1,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		blur = {
			enabled = true,
			size = 3,
			passes = 3,
			new_optimizations = true,
		},
	},

	animations = { enabled = true },
	dwindle = { preserve_split = true },
	master = { new_status = "master" },
})

-----------------------------------------------------
---- GESTURES & ANIMATIONS
-----------------------------------------------------

-- Existing 3-finger gestures
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.gesture({
	fingers = 3,
	direction = "down",
	action = "close",
})

hl.curve("myBezier", {
	type = "bezier",
	points = {
		{ 0.05, 0.9 },
		{ 0.1, 1.05 },
	},
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 3,
	bezier = "myBezier",
	style = "slide",
})

hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 3,
	bezier = "default",
	style = "popin 10%",
})

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 1,
	bezier = "default",
})

hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 3,
	bezier = "default",
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 1,
	bezier = "default",
})

-----------------------------------------------------
---- WINDOW RULES
-----------------------------------------------------

-- Scratchpad Routing for Spotify
hl.window_rule({
	name = "spotify-scratchpad",
	match = { class = "^(Spotify)$" },
	workspace = "special:magic",
})

-- Floating Windows
hl.window_rule({
	name = "clipse-float",
	match = { class = "clipse" },
	float = true,
	size = "622 652",
})

-- Opacity Rules
hl.window_rule({
	name = "opacity-floating",
	match = { float = true },
	opacity = "1.0 1.0",
})

hl.window_rule({
	name = "opacity-tiled",
	match = { float = false },
	opacity = "1.0 0.75",
})

hl.window_rule({
	name = "opacity-obsidian",
	match = { class = "^(obsidian)$" },
	opacity = "0.95 0.95",
})

hl.window_rule({
	name = "opacity-gedit",
	match = { class = "^(gedit)$" },
	opacity = "0.90 0.75",
})

-- Special Workspace (Scratchpad)
hl.window_rule({
	name = "scratchpad",
	match = { class = "^(Scratchpad)$" },
	no_anim = true,
	float = true,
	size = "(monitor_w*0.7) (monitor_h*0.7)",
	center = true,
})

-----------------------------------------------------
---- KEYBINDINGS
-----------------------------------------------------
local mainMod = "SUPER"

-----------------------------------------------------
---- APPLICATION LAUNCHING
-----------------------------------------------------
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("wofi --show drun --width=500 --height=300"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("/home/moonboyknm/Documents/Scripts/rofi_search.sh"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("code"))

-----------------------------------------------------
---- SYSTEM CONTROLS
-----------------------------------------------------
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/powermenu.sh"))

-----------------------------------------------------
---- SCREEN & MEDIA
-----------------------------------------------------

-- Volume OSD
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume-osd.sh down"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume-osd.sh up"))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume-osd.sh mute"))

-- Media Playback
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

-- Brightness OSD
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness-osd.sh down"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness-osd.sh up"))

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-----------------------------------------------------
---- WINDOW MANAGEMENT
-----------------------------------------------------
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-----------------------------------------------------
---- FOCUS
-----------------------------------------------------
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-----------------------------------------------------
---- WORKSPACES
-----------------------------------------------------
for i = 1, 10 do
	local key = i % 10

	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-----------------------------------------------------
---- MOUSE BINDS
-----------------------------------------------------
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-----------------------------------------------------

-----------------------------------------------------
---- SPECIAL WORKSPACE & EXTRAS
-----------------------------------------------------
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))

hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("alacritty --class clipse -e clipse"))

-----------------------------------------------------
---- CONFIG EDITING
-----------------------------------------------------
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty -e nvim ~/.config/hypr/hyprland.lua"))
