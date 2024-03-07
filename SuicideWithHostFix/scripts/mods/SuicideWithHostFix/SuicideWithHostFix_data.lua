local mod = get_mod("SuicideWithHostFix")

return {
	name = "Suicide (with Host fix)",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = "suicide_host_respawns",
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = "suicide_hide_host_frame",
				type = "checkbox",
				default_value = false
			},
			-- {
			-- 	setting_id = "suicide_autodie",
			-- 	type = "checkbox",
			-- 	default_value = false
			-- },
		}
	}
}
