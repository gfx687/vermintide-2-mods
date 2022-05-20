local mod = get_mod("Headshot Counter")

local SCREEN_WIDTH = 3840
local SCREEN_HEIGHT = 2160
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

local hs_data = {
    melee_total = 0,
    melee_total_hs = 0,
    melee_elites_total = 0,
    melee_elites_hs = 0,
    per_enemy_type = {}
}

for breed, _ in pairs(breed_types) do
	hs_data.per_enemy_type[breed] = {
        total = 0,
        hs = 0
    }
end

local function get_x()
    local x = mod:get("hs_count_offset_x")
    if x == 0 then
        return 0
    end

    local x_limit = SCREEN_WIDTH / 2
    local max_x = math.min(mod:get("hs_count_offset_x"), x_limit)
    local min_x = math.max(mod:get("hs_count_offset_x"), -x_limit)
    local clamped_x = x > 0 and max_x or min_x
    return clamped_x
end

local function get_y()
    local y = mod:get("hs_count_offset_y")
    if y == 0 then
        return 0
    end

    local y_limit = SCREEN_HEIGHT / 2
    local max_y = math.min(mod:get("hs_count_offset_y"), y_limit)
    local min_y = math.max(mod:get("hs_count_offset_y"), -y_limit)
    local clamped_y = -(y > 0 and max_y or min_y)
    return clamped_y
end

local scenegraph_definition = {
    root = {
        scale = "fit",
        size = {
            3840,
            2160
        },
        position = {
            0,
            0,
            UILayer.hud
        }
    }
}

local fake_input_service = {
    get = function ()
        return
    end,
    has = function ()
        return
    end
}

local ui_definition = {
    scenegraph_id = "root",
    element = {
        passes = {
            {
                style_id = "hs_text",
                pass_type = "text",
                text_id = "hs_text",
                retained_mode = false,
                fade_out_duration = 5,
                content_check_function = function(content)
                  return not (content.hs_mode == 'hs_mode_only_chat')
                end
            }
        }
    },
    content = {
        hs_text = "",
        hs_mode = mod:get("hs_count_mode"),
    },
    style = {
        hs_text = {
            font_type = "hell_shark",
            font_size = mod:get("hs_count_font_size"),
            vertical_alignment = "center",
            horizontal_alignment = "center",
            text_color = Colors.get_table("white"),
            offset = {
                get_x(),
                get_y(),
                0
            }
        },
    },
    offset = {
        0,
        0,
        0
    },
}

function mod:on_disabled()
    mod.ui_renderer = nil
    mod.ui_scenegraph = nil
    mod.ui_widget = nil
end

function mod:on_setting_changed()
    if not mod.ui_widget then
        return
    end

    mod.ui_widget.style.hs_text.offset[1] = get_x()
    mod.ui_widget.style.hs_text.offset[2] = get_y()
    mod.ui_widget.style.hs_text.font_size = mod:get("hs_count_font_size")
end

function mod:init()
    if mod.ui_widget then
        return
    end

    local world = Managers.world:world("top_ingame_view")
    mod.ui_renderer = UIRenderer.create(world, "material", "materials/fonts/gw_fonts")
    mod.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
    mod.ui_widget = UIWidget.init(ui_definition)
end

function mod.print_and_clear_hs_data()
    local total_percent = 100 * hs_data.melee_total_hs / hs_data.melee_total
    if not (total_percent ~= total_percent) then
        mod:echo("Total HS rate of the previous run : %.1f%%", total_percent)
    end

    local elites_percent = 100 * hs_data.melee_elites_hs / hs_data.melee_elites_total
    if not (elites_percent ~= elites_percent) then
        mod:echo("Elites HS rate of the previous run : %.1f%%", elites_percent)
    end

    if mod:get("hs_count_show_detailed") then
        local header_printed = false

        for breed, data in pairs(hs_data.per_enemy_type) do
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

    for breed, data in pairs(hs_data.per_enemy_type) do
        data.hs = 0
        data.total = 0
    end

    hs_data.melee_total = 0
    hs_data.melee_total_hs = 0
    hs_data.melee_elites_total = 0
    hs_data.melee_elites_hs = 0
end

mod:command("hsc_reset", "Manually reset Headshot Counter.", function()
    mod:print_and_clear_hs_data()
end)

mod.on_game_state_changed = function(status, state_name)
    if status == "enter" and state_name == "StateLoading" then
        mod:print_and_clear_hs_data()
    end
end

mod:hook_safe(IngameHud, "update", function(self)
    if not self._currently_visible_components.EquipmentUI or self:is_own_player_dead() then
        return
    end

    if not mod.ui_widget then
        mod.init()
    end

    local widget = mod.ui_widget
    local ui_renderer = mod.ui_renderer
    local ui_scenegraph = mod.ui_scenegraph

    widget.content.hs_mode = mod:get("hs_count_mode")

    local total_percent = 100 * hs_data.melee_total_hs / hs_data.melee_total
    if total_percent ~= total_percent then
        total_percent = 0
    end

    local elites_percent = 100 * hs_data.melee_elites_hs / hs_data.melee_elites_total
    if elites_percent ~= elites_percent then
        elites_percent = 0
    end

    if widget.content.hs_mode == 'hs_mode_total' then
        local debug_data = ""
        if mod:get("hs_count_show_total") then
            debug_data = " (" .. tostring(hs_data.melee_total_hs) .. "/" .. tostring(hs_data.melee_total) .. ")"
        end

        widget.content.hs_text = "hs (t): " .. string.format("%.1f", total_percent) .. "%" .. debug_data
    elseif widget.content.hs_mode == 'hs_mode_elites' then
        local debug_data = ""
        if mod:get("hs_count_show_total") then
            debug_data = " (" .. tostring(hs_data.melee_elites_hs) .. "/" .. tostring(hs_data.melee_elites_total) .. ")"
        end

        widget.content.hs_text = "hs (e): " .. string.format("%.1f", elites_percent) .. "%" .. debug_data
    elseif widget.content.hs_mode == 'hs_mode_both' then
        widget.content.hs_text = "hs (t|e): " .. string.format("%.1f", total_percent) .. "% | " .. string.format("%.1f", elites_percent) .. "%"
    end

    UIRenderer.begin_pass(ui_renderer, ui_scenegraph, fake_input_service, dt)
    UIRenderer.draw_widget(ui_renderer, widget)
    UIRenderer.end_pass(ui_renderer)
end)

mod:hook_safe(StatisticsUtil, "register_damage", function(victim_unit, damage_data, statistics_db)
    local attacker_unit = damage_data[DamageDataIndex.ATTACKER]
    local actual_attacker = AiUtils.get_actual_attacker_unit(attacker_unit)
    local attacker_player = Managers.player:owner(actual_attacker)
    local victim_player = Managers.player:owner(victim_unit)

    if attacker_player and not attacker_player.remote and not attacker_player.bot_player and not victim_player then
        local target_breed = Unit.alive(victim_unit) and Unit.get_data(victim_unit, "breed")
        local attack_type = damage_data[DamageDataIndex.ATTACK_TYPE]
        local damage_source = damage_data[DamageDataIndex.DAMAGE_SOURCE_NAME]

        if target_breed and (attack_type == "light_attack" or attack_type == "heavy_attack")
            and not (damage_source == "charge_ability_hit")
            and not (damage_source == "charge_ability_hit_blast") then
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
                    local per_breed = hs_data.per_enemy_type[target_breed.name]

                    per_breed.total = per_breed.total + 1
                    if is_headshot then
                        per_breed.hs = per_breed.hs + 1
                    end
                end

                local is_elite = false or breed_type and breed_type == "elite"

                hs_data.melee_total = hs_data.melee_total + 1
                if is_headshot then
                    hs_data.melee_total_hs = hs_data.melee_total_hs + 1
                end

                if is_elite then
                    hs_data.melee_elites_total = hs_data.melee_elites_total + 1

                    if is_headshot then
                        hs_data.melee_elites_hs = hs_data.melee_elites_hs + 1
                    end
                end
            end
        end
    end
end)
