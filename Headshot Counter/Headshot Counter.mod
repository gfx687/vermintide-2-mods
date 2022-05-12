return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Headshot Counter` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Headshot Counter", {
			mod_script       = "scripts/mods/Headshot Counter/Headshot Counter",
			mod_data         = "scripts/mods/Headshot Counter/Headshot Counter_data",
			mod_localization = "scripts/mods/Headshot Counter/Headshot Counter_localization",
		})
	end,
	packages = {
		"resource_packages/Headshot Counter/Headshot Counter",
	},
}
