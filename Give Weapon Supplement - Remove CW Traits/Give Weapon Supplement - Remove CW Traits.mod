return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Give Weapon Supplement - Remove CW Traits` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Give Weapon Supplement - Remove CW Traits", {
			mod_script       = "scripts/mods/Give Weapon Supplement - Remove CW Traits/Give Weapon Supplement - Remove CW Traits",
			mod_data         = "scripts/mods/Give Weapon Supplement - Remove CW Traits/Give Weapon Supplement - Remove CW Traits_data",
			mod_localization = "scripts/mods/Give Weapon Supplement - Remove CW Traits/Give Weapon Supplement - Remove CW Traits_localization",
		})
	end,
	packages = {
		"resource_packages/Give Weapon Supplement - Remove CW Traits/Give Weapon Supplement - Remove CW Traits",
	},
}
