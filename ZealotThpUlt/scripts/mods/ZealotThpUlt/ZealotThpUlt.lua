local mod = get_mod("ZealotThpUlt")

mod:hook_safe(CareerAbilityWHZealot, "_run_ability", function(self)
    local player_unit = Managers.player:local_player().player_unit
    local health_extension = ScriptUnit.extension(player_unit, "health_system")
    local perm_health = health_extension:current_permanent_health()
    health_extension:convert_to_temp(perm_health)
end)
