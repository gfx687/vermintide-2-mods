local mod = get_mod("SuicideWithHostFix")

mod:dofile("scripts/mods/SuicideWithHostFix/settings")
mod:dofile("scripts/mods/SuicideWithHostFix/no_host_respawn")
mod:dofile("scripts/mods/SuicideWithHostFix/hide_host_frame")
mod:dofile("scripts/mods/SuicideWithHostFix/autodie")

mod.on_game_state_changed = function(status, state_name)
    mod:handle_frame_visibility_on_game_state_changed(status, state_name)
end

mod:command("die", "[SuicideWithHostFix] Kill yourself", function()
    mod:die()
end)

mod:command("hide_host_frame", "[SuicideWithHostFix] Hide host frame", function()
    mod:host_frame_hide()
end)

mod:command("show_host_frame", "[SuicideWithHostFix] Show host frame", function()
    mod:host_frame_show()
end)
