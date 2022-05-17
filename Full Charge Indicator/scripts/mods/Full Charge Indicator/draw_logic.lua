local mod = get_mod("Full Charge Indicator")

local SCREEN_WIDTH = 3840
local SCREEN_HEIGHT = 2160

local function get_x()
    local x = mod:get("full_charge_offset_x")
    if x == 0 then
        return 0
    end

    local x_limit = SCREEN_WIDTH / 2
    local max_x = math.min(mod:get("full_charge_offset_x"), x_limit)
    local min_x = math.max(mod:get("full_charge_offset_x"), -x_limit)
    local clamped_x = x > 0 and max_x or min_x
    return clamped_x
end

local function get_y()
    local y = mod:get("full_charge_offset_y")
    if y == 0 then
        return 0
    end

    local y_limit = SCREEN_HEIGHT / 2
    local max_y = math.min(mod:get("full_charge_offset_y"), y_limit)
    local min_y = math.max(mod:get("full_charge_offset_y"), -y_limit)
    local clamped_y = -(y > 0 and max_y or min_y)
    return clamped_y
end

local fake_input_service = {
    get = function ()
        return
    end,
    has = function ()
        return
    end
}

local scenegraph_definition = {
    root = {
        scale = "fit",
        size = {
            SCREEN_WIDTH,
            SCREEN_HEIGHT
        },
        position = {
            0,
            0,
            UILayer.hud
        }
    }
}

local ui_definition = {
    scenegraph_id = "root",
    element = {
        passes = {
            {
                style_id = "full_charge_text",
                pass_type = "text",
                text_id = "full_charge_text",
                retained_mode = false,
                fade_out_duration = 5,
                content_check_function = function(content)
                    return not (content.full_charge == "")
                end
            }
        }
    },
    content = {
        full_charge_text = ""
        -- full_charge_last_dt = Application.time_since_launch()
    },
    style = {
        full_charge_text = {
            font_type = "hell_shark",
            font_size = mod:get("full_charge_font_size"),
            vertical_alignment = "center",
            horizontal_alignment = "center",
            text_color = Colors.get_table("orange"),
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

    mod.ui_widget.style.full_charge_text.offset[1] = get_x()
    mod.ui_widget.style.full_charge_text.offset[2] = get_y()
    mod.ui_widget.style.full_charge_text.font_size = mod:get("full_charge_font_size")
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

mod:hook_safe(IngameHud, "update", function(self)
    if not self._currently_visible_components.EquipmentUI or self:is_own_player_dead() then
        return
    end

    if not mod.ui_widget then
        mod:init()
    end

    local widget = mod.ui_widget
    local ui_renderer = mod.ui_renderer
    local ui_scenegraph = mod.ui_scenegraph

    UIRenderer.begin_pass(ui_renderer, ui_scenegraph, fake_input_service, dt)
    UIRenderer.draw_widget(ui_renderer, widget)
    UIRenderer.end_pass(ui_renderer)
end)