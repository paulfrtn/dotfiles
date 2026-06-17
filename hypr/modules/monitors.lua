------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "eDP-1",
    mode     = "3000x2000",
    position = "auto",
    scale    = "auto",
})

hl.monitor({
    output   = "DP-2",
    mode     = "3440x1440",
    position = "auto",
    scale    = "1.25",
})

hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})

