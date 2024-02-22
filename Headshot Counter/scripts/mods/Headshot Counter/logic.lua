local mod = get_mod("Headshot Counter")

local breed_types = {
    ["beastmen_bestigor"] = "elite",
    ["chaos_raider"] = "elite",
    ["chaos_warrior"] = "elite",
    ["chaos_berzerker"] = "elite",
    ["skaven_plague_monk"] = "elite",
    ["skaven_storm_vermin"] = "elite",
    ["skaven_storm_vermin_commander"] = "elite",
    ["skaven_storm_vermin_with_shield"] = "elite",

    ["beastmen_minotaur"] = "monster",
    ["chaos_spawn"] = "monster",
    ["chaos_troll"] = "monster",
    ["skaven_rat_orge"] = "monster",
    ["skaven_stormfiend"] = "monster",
}

mod.hs_data = {
    melee_total = 0,
    melee_total_hs = 0,
    melee_elites_total = 0,
    melee_elites_hs = 0,
    per_enemy_type = {}
}
mod.last_run_hs_info = table.clone(mod.hs_data)
mod.count_only_first_cleaved = mod:get("hs_count_only_first_cleaved")

for breed, _ in pairs(breed_types) do
	mod.hs_data.per_enemy_type[breed] = {
        total = 0,
        hs = 0
    }
end

function mod.print_and_clear_hs_data()
    local total_percent = 100 * mod.hs_data.melee_total_hs / mod.hs_data.melee_total
    if not (total_percent ~= total_percent) then
        mod:echo("Total HS rate of the previous run : %.1f%%", total_percent)
    end

    local elites_percent = 100 * mod.hs_data.melee_elites_hs / mod.hs_data.melee_elites_total
    if not (elites_percent ~= elites_percent) then
        mod:echo("Elites HS rate of the previous run : %.1f%%", elites_percent)
    end

    mod.last_run_hs_info = table.clone(mod.hs_data)

    if mod:get("hs_count_show_detailed") then
        local header_printed = false

        for breed, data in pairs(mod.hs_data.per_enemy_type) do
            local hs_rate = 100 * data.hs / data.total
            if not (hs_rate ~= hs_rate) then

                -- avoid printing header if no HS data was gathered (first game start, restart without fighting, etc)
                if not header_printed then
                    header_printed = true
                    mod:echo("----- Breeds HS rates -----")
                end

                mod:echo("%-30s : %.1f%% ", breed, hs_rate)
            end
        end
    end

    for breed, data in pairs(mod.hs_data.per_enemy_type) do
        data.hs = 0
        data.total = 0
    end

    mod.hs_data.melee_total = 0
    mod.hs_data.melee_total_hs = 0
    mod.hs_data.melee_elites_total = 0
    mod.hs_data.melee_elites_hs = 0
end

function mod.hook_register_damage(victim_unit, damage_data)
    local attacker_unit = damage_data[DamageDataIndex.ATTACKER]
    local actual_attacker = AiUtils.get_actual_attacker_unit(attacker_unit)
    local attacker_player = Managers.player:owner(actual_attacker)
    local victim_player = Managers.player:owner(victim_unit)

    if attacker_player and not attacker_player.remote and not attacker_player.bot_player and not victim_player then
        local target_breed = Unit.alive(victim_unit) and Unit.get_data(victim_unit, "breed")
        local attack_type = damage_data[DamageDataIndex.ATTACK_TYPE]
        local damage_source = damage_data[DamageDataIndex.DAMAGE_SOURCE_NAME]
        local is_first_hit = damage_data[DamageDataIndex.FIRST_HIT]

        if target_breed and (attack_type == "light_attack" or attack_type == "heavy_attack")
            and not (damage_source == "charge_ability_hit")
            and not (damage_source == "charge_ability_hit_blast")
            and (not mod.count_only_first_cleaved or mod.count_only_first_cleaved and is_first_hit) then

            local health_extension = ScriptUnit.extension(victim_unit, "health_system")
            local current_health = health_extension:current_health()

            if current_health > 0 then
                local is_headshot = false
                local hit_zone = damage_data[DamageDataIndex.HIT_ZONE]
                if hit_zone == "head" or hit_zone == "neck" or hit_zone == "weakspot" then
                    is_headshot = true
                end

                local breed_type = breed_types[target_breed.name]
                if breed_type then
                    local per_breed = mod.hs_data.per_enemy_type[target_breed.name]

                    per_breed.total = per_breed.total + 1
                    if is_headshot then
                        per_breed.hs = per_breed.hs + 1
                    end
                end

                local is_elite = false or breed_type and breed_type == "elite"

                mod.hs_data.melee_total = mod.hs_data.melee_total + 1
                if is_headshot then
                    mod.hs_data.melee_total_hs = mod.hs_data.melee_total_hs + 1
                end

                if is_elite then
                    mod.hs_data.melee_elites_total = mod.hs_data.melee_elites_total + 1

                    if is_headshot then
                        mod.hs_data.melee_elites_hs = mod.hs_data.melee_elites_hs + 1
                    end
                end
            end
        end
    end
end
