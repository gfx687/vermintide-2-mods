local mod = get_mod("SuicideWithHostFix")

mod.host_respawns = mod:get("suicide_host_respawns")
mod.hide_host_frame = mod:get("suicide_hide_host_frame")
-- mod.autodie = mod:get("suicide_autodie")

function mod:on_setting_changed()
    mod.host_respawns = mod:get("suicide_host_respawns")
    mod.hide_host_frame = mod:get("suicide_hide_host_frame")
    -- mod.autodie = mod:get("suicide_autodie")

    if mod.hide_host_frame then
        mod:host_frame_hide()
    else
        mod:host_frame_show()
    end

    -- if mod.autodie then
    --     mod:die()
    -- end
end
