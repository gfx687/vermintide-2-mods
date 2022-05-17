local mod = get_mod("Full Charge Indicator")

mod:dofile("scripts/mods/Full Charge Indicator/draw_logic")

-- TODO : add icon instead of text
-- TODO : show second charge of manbow
-- TODO : show second charge of rapier
-- TODO : show second charge of pickaxe

mod:hook_safe(BuffExtension, "trigger_procs", function(self, event, ...)
    if event == "on_charge_finished" then
        mod.ui_widget.content.full_charge_text = ""
    elseif event == "on_full_charge" then
        mod.ui_widget.content.full_charge_text = "CHARGED"
    end
end)