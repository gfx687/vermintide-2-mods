local mod = get_mod("Headshot Counter")

mod:dofile("scripts/mods/Headshot Counter/logic")

local SCREEN_WIDTH = 3840
local SCREEN_HEIGHT = 2160

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

    mod.count_only_first_cleaved = mod:get("hs_count_only_first_cleaved")
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

mod:command("hsc_reset", "Manually reset Headshot Counter.", function()
    mod:print_and_clear_hs_data()
end)

mod.on_game_state_changed = function(status, state_name)
    if status == "enter" and state_name == "StateLoading" then
        mod:print_and_clear_hs_data()
    end
end

-- draw HS data on the screen
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

    local total_percent = 100 * mod.hs_data.melee_total_hs / mod.hs_data.melee_total
    if total_percent ~= total_percent then
        total_percent = 0
    end

    local elites_percent = 100 * mod.hs_data.melee_elites_hs / mod.hs_data.melee_elites_total
    if elites_percent ~= elites_percent then
        elites_percent = 0
    end

    if widget.content.hs_mode == 'hs_mode_total' then
        local debug_data = ""
        if mod:get("hs_count_show_total") then
            debug_data = " (" .. tostring(mod.hs_data.melee_total_hs) .. "/" .. tostring(mod.hs_data.melee_total) .. ")"
        end

        widget.content.hs_text = "hs (t): " .. string.format("%.1f", total_percent) .. "%" .. debug_data
    elseif widget.content.hs_mode == 'hs_mode_elites' then
        local debug_data = ""
        if mod:get("hs_count_show_total") then
            debug_data = " (" .. tostring(mod.hs_data.melee_elites_hs) .. "/" .. tostring(mod.hs_data.melee_elites_total) .. ")"
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
    mod.hook_register_damage(victim_unit, damage_data)
end)

mod.get_last_run_info = function ()
    if mod.hs_data.melee_total == 0 then
        return mod.last_run_hs_info
    end
    return mod.hs_data
end
