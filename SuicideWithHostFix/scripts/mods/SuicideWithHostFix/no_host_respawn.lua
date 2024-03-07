local mod = get_mod("SuicideWithHostFix")

-- delay host respawn by 10 seconds every time if 'Host respawns' is set to false
-- one potential tiny optimization could be to remove host entry from slots entirely, but that likely will not
-- give any noticeable improvement

-- Ideal solution would be to block host from respawning in some other way and not hook into function that
-- executes every frame(?)
mod:hook(RespawnHandler, "server_update", function(func, self, dt, t, slots)
    if not mod.host_respawns then
        for i = 1, #slots do
            local status = slots[i]
            local data = status.game_mode_data

            if data.health_state == "dead" and not status.is_bot and status.player and status.player.is_server then
                data.respawn_timer = t + 10
            end
        end
    end

    func(self, dt, t, slots)
end)
