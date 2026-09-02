------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar & awww-daemon & hypridle")
	hl.exec_cmd("sleep 1 && waypaper --restore")
	hl.exec_cmd("sleep 1 && protonvpn-app --start-minimized")
	hl.exec_cmd("sleep 1 && solaar -w hide")
	hl.exec_cmd("swaync-daemon")
	hl.exec_cmd("sleep 1 && swaync")
	hl.exec_cmd("sleep 1 && swayosd-server")
end)
