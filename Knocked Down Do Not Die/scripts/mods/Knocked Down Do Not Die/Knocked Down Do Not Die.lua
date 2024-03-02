local mod = get_mod("Knocked Down Do Not Die")

mod:dofile("scripts/mods/Knocked Down Do Not Die/death_command")
mod:dofile("scripts/mods/Knocked Down Do Not Die/debuff")
mod:dofile("scripts/mods/Knocked Down Do Not Die/revive_logic")

local function make_player_invisible(player, val)
    local status_extension = ScriptUnit.has_extension(player.player_unit, "status_system")
    if not status_extension then
        mod:echo("make_player_invisible: status_extension not resolved, aborting")
        return
    end

    status_extension:set_invisible(val, nil, "random_string")
end

mod:hook_safe(GenericStatusExtension, "set_knocked_down", function(self)
    if not self.player.is_server then
        return
    end

    -- hook also triggers on revive, not only going down
    if (not self.knocked_down) then
        make_player_invisible(self.player, false)
        mod:remove_knocked_down_debuffs(self.player.player_unit)
        return
    end

    make_player_invisible(self.player, true)
    mod:add_knocked_down_debuff(self.player.player_unit)
end)
