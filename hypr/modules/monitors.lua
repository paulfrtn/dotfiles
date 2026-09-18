------------------
---- MONITORS ----
------------------

require("modules.env")

hl.monitor({
	output = MAIN_MONITOR,
	mode = "3000x2000",
	position = "auto",
	scale = "auto",
})

hl.monitor({
	output = EXTERNAL_MONITOR,
	mode = "3440x1440",
	position = "auto",
	scale = "1.25",
})

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})
