--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	match = {
		class = "waypaper",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "^md\\.obsidian\\.Obsidian$",
		title = "^Settings.*",
	},
	float = true,
})

hl.workspace_rule({
	workspace = "name:coding",
	monitor = "DP-2",
	gaps_out = { top = 100, bottom = 100, left = 500, right = 500 },
})

hl.on("monitor.added", function(w)
	for i = 1, 15 do
		hl.workspace_rule({ workspace = tostring(i), monitor = "DP-2" })
	end
	hl.workspace_rule({ workspace = "name:isekai", monitor = "eDP-1", default = true, persistent = true })
end)

hl.on("monitor.removed", function(w)
	for i = 1, 15 do
		hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
	end
	local main_windows = hl.get_workspace_windows("name:isekai")
	for _, info in pairs(main_windows) do
		local dsp = hl.dsp.window.move({ window = info.id, workspace = "1" })
		hl.dispatch(dsp)
	end
	hl.workspace_rule({ workspace = "name:isekai", monitor = "eDP-1" })
end)
