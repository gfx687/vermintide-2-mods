local mod = get_mod("Headshot Counter")

local all_mods  = {
	"hs_mode_total",
	"hs_mode_elites",
	"hs_mode_both",
	"hs_mode_only_chat"
}

local options = {}
for _, quest in ipairs(all_mods) do
	table.insert(options, { text = quest, value = quest })
end

return {
	name = "Headshot Counter",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = "hs_count_reset_bind",
				type = "keybind",
				keybind_global = true,
				keybind_type = "function_call",
				keybind_trigger = "pressed",
				function_name = "print_and_clear_hs_data",
				default_value = {}
			},
			{
				setting_id = "hs_count_mode",
				type = "dropdown",
				default_value = all_mods[1],
				options = table.clone(options)
			},
			{
				setting_id = "hs_count_show_detailed",
				type = "checkbox",
				default_value = false
			},
			{
				setting_id = "hs_count_offset_x",
				type = "numeric",
				default_value = -400,
				range = { -1920, 1920 },
			},
			{
				setting_id = "hs_count_offset_y",
				type = "numeric",
				default_value = 0,
				range = { -1080, 1080 },
			},
			{
				setting_id = "hs_count_font_size",
				type = "numeric",
				default_value = 32,
				range = { 8, 128 },
			},
			{
				setting_id = "hs_count_only_first_cleaved",
				type = "checkbox",
				default_value = false
			},
			{
				setting_id = "hs_count_show_total",
				type = "checkbox",
				default_value = false
			},
		}
	}
}
