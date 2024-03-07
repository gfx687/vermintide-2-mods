local mod = get_mod("SuicideWithHostFix")

-- hide host frame if suicided with 'Host respawns' = false
-- code based on prop joe's True Solo QOL tweaks mod

mod.unit_frames_handler = nil

-- rebuilding and reloading mod with CTRL-SHIFT-R will not execute this second time
-- so after reloading mods use /restart to restart the level
mod:hook_safe(UnitFramesHandler, "init", function(self)
    mod.unit_frames_handler = self
end)

function mod.handle_frame_visibility_on_game_state_changed(status, state_name)
    if mod.hide_host_frame then
        mod:host_frame_hide()
    else
        mod:host_frame_show()
    end
end

-- the two funcitons below do NOT work correctly
-- unit_frame_ui.player_manager.is_server and unit_frame.player_data.player.is_server
-- seem to return info about your player and not the one frame belongs too, so by using them you cannot determine
-- who the host is
-- unit_frame.player_data.peer_id returns peer_id of the frame's player, so can maybe use that
-- for now functions hide bot frame to serve as an example

-- Potential problem
-- I did not test whever or not frames will adjust position if you simple hide one
-- meaning what would happen if you hide leftmost frame? will there be an empty space in UI
-- or maybe frames on the right will adjust position?

function mod.host_frame_hide()
    mod:pcall(function()
        local unit_frames_handler = mod.unit_frames_handler
        if not unit_frames_handler then
            -- mod:echo('[SuicideWithHostFix] unit_frames_handler is nil')
            return
        end

        for _, unit_frame in ipairs(unit_frames_handler._unit_frames) do
            local unit_frame_ui = unit_frame.widget
            local is_server = unit_frame_ui.player_manager.is_server
                -- and not unit_frame_ui.data.level_text == "BOT"

            -- for key, value in pairs(unit_frame.player_data.player) do
            --     mod:echo("found unit_frame.player_data.player member " .. key);
            -- end

            if unit_frame_ui._frame_index and is_server then
                unit_frame_ui:set_visible(false)
                unit_frame_ui._mod_stay_hidden = true
            end
        end
    end)
end

function mod.host_frame_show()
    mod:pcall(function()
        local unit_frames_handler = mod.unit_frames_handler
        if not unit_frames_handler then
            -- mod:echo('[SuicideWithHostFix] unit_frames_handler is nil')
            return
        end

        for _, unit_frame in ipairs(unit_frames_handler._unit_frames) do
            local unit_frame_ui = unit_frame.widget
            local is_server = unit_frame_ui.player_manager.is_server
                -- and not unit_frame_ui.data.level_text == "BOT"

            if unit_frame_ui._frame_index and is_server then
                unit_frame_ui:set_visible(true)
                unit_frame_ui._mod_stay_hidden = false
            end
        end
    end)
end
