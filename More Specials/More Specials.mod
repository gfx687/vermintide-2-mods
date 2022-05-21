return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`More Specials` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("More Specials", {
			mod_script       = "scripts/mods/More Specials/More Specials",
			mod_data         = "scripts/mods/More Specials/More Specials_data",
			mod_localization = "scripts/mods/More Specials/More Specials_localization",
		})
	end,
	packages = {
		"resource_packages/More Specials/More Specials",
	},
}
