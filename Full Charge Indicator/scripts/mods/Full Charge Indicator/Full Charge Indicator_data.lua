local mod = get_mod("Full Charge Indicator")

return {
	name = "Full Charge Indicator",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = "full_charge_offset_x",
				type = "numeric",
				default_value = -400,
				range = { -1920, 1920 },
			},
			{
				setting_id = "full_charge_offset_y",
				type = "numeric",
				default_value = 0,
				range = { -1080, 1080 },
			},
			{
				setting_id = "full_charge_font_size",
				type = "numeric",
				default_value = 48,
				range = { 8, 128 },
			},
		}
	}
}
