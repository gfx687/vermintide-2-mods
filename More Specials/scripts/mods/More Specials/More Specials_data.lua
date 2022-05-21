local mod = get_mod("More Specials")

return {
	name = "More Specials",
	description = mod:localize("mod_description"),
	is_togglable = false,
	options = {
		widgets = {
			{
				setting_id = "more_specials_note",
				type = "group",
				sub_widgets = {
					{
						setting_id = "more_specials_skaven_areas",
						type = "numeric",
						default_value = 8,
						range = { 0, 16 },
					},
					{
						setting_id = "more_specials_chaos_areas",
						type = "numeric",
						default_value = 7,
						range = { 0, 16 },
					},
					{
						setting_id = "more_specials_max_of_same",
						type = "numeric",
						default_value = 4,
						range = { 0, 16 },
					},
					{
						setting_id = "more_specials_cooldown_lower",
						type = "numeric",
						default_value = 25,
						range = { 10, 90 },
					},
					{
						setting_id = "more_specials_cooldown_upper",
						type = "numeric",
						default_value = 50,
						range = { 10, 90 },
					},
				}
			}
		}
	}
}
