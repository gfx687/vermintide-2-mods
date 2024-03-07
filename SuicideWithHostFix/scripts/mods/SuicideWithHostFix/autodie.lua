local mod = get_mod("SuicideWithHostFix")

-- die on mission start if setting is enabled

-- on_game_state_changed hook is not suitable for our needs, it executes to easly for /die command to work
-- function mod.handle_autodie_on_game_state_changed(status, state_name)
    -- if mod.autodie and status == "enter" and state_name == "StateIngame" then
    --     mod:die()
    -- end
-- end

-- copied from raindish's original Suicide mod
-- when used by clients they will not respawn. Host, however, will
local function is_at_inn()
    local game_mode = Managers.state.game_mode
    if not game_mode then
        return nil
    end
    return game_mode:game_mode_key() == "inn"
end

function mod.die()
    if is_at_inn() then
        mod:echo("You cannot die in the keep")
        return
    end

    local player_unit = Managers.player:local_player().player_unit
    local death_system = Managers.state.entity:system("death_system")
    death_system:kill_unit(player_unit, {})

    if Managers.player.is_server then
        if mod.host_respawns then
            mod:echo('/die command used as host. You will respawn, as per mod setting.')
        else
            mod:echo('/die command used as host. You will NOT respawn, as per mod setting.')
        end
    else
        mod:echo('/die command used as client. You will NOT RESPAWN.')
    end
end
