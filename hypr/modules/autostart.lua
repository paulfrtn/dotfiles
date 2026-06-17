-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar & awww-daemon")
    hl.exec_cmd("sleep 1 && waypaper --restore")
    hl.exec_cmd("sleep 1 && protonvpn-app --start-minimized")
    hl.exec_cmd("sleep 1 && solaar -w hide")
end)

