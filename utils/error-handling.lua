local naughty = require("naughty")

local log_file = io.open(os.getenv("HOME") .. "/.awesome_error_log", "a")

if awesome.startup_errors then
    log_file:write("Startup error: " .. awesome.startup_errors .. "\n")
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

awesome.connect_signal("debug::error", function(err)
    if in_error then return end
    in_error = true

    log_file:write("Runtime error: " .. tostring(err) .. "\n")
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "The Bad Happen!",
        text = tostring(err)
    })
    in_error = false
end)

awesome.connect_signal("exit", function()
    if log_file then
        log_file:close()
    end
end)

