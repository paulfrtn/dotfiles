--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

require("modules.env")

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
	monitor = EXTERNAL_MONITOR,
	gaps_out = { top = 100, bottom = 100, left = 500, right = 500 },
})

hl.workspace_rule({
	workspace = "name:isekai",
	monitor = MAIN_MONITOR,
})

local docked_timer

hl.on("monitor.added", function(w)
	--Be sure that the .added do not count the laptop native monitor
	--eDP1 as an added monitor
	if w.name ~= EXTERNAL_MONITOR then
		return
	end
	for i = 1, 15 do
		hl.workspace_rule({ workspace = tostring(i), monitor = EXTERNAL_MONITOR })
	end
	hl.workspace_rule({ workspace = "name:isekai", monitor = MAIN_MONITOR, default = true, persistent = true })

	docked_timer = hl.timer(function()
		hl.dispatch(hl.dsp.focus({ workspace = "1" }))
	end, { timeout = 300, type = "oneshot" })
end)

local cleanup_timer

local function cleanup_isekai()
	local main_windows = hl.get_workspace_windows("name:isekai")
	for _, win in pairs(main_windows) do
		local dsp = hl.dsp.window.move({ window = win, workspace = "1" })
		hl.dispatch(dsp)
	end

	local ws = hl.get_active_workspace()
	if ws and ws.name == "isekai" then
		hl.dispatch(hl.dsp.focus({ workspace = "1" }))
	end
end

hl.on("monitor.removed", function(w)
	if w.name ~= EXTERNAL_MONITOR then
		return
	end

	hl.workspace_rule({ workspace = "name:isekai", monitor = MAIN_MONITOR, persistent = false })
	for i = 1, 15 do
		hl.workspace_rule({ workspace = tostring(i), monitor = MAIN_MONITOR })
	end

	cleanup_isekai()
	cleanup_timer = hl.timer(cleanup_isekai, { timeout = 300, type = "oneshot" })
end)
