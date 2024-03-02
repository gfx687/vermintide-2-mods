local mod = get_mod("Give Weapon Supplement - Remove CW Traits")

return {
	name = "Give Weapon Supplement - Remove CW Traits",
	description = mod:localize("mod_description"),
	is_togglable = false,
	options = {
		widgets = {
			{
				setting_id = "give_weapon_remove_cw_traits",
				type = "checkbox",
				default_value = false
			}
		}
	}
}
