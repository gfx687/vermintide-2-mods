return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`SuicideWithHostFix` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("SuicideWithHostFix", {
			mod_script       = "scripts/mods/SuicideWithHostFix/SuicideWithHostFix",
			mod_data         = "scripts/mods/SuicideWithHostFix/SuicideWithHostFix_data",
			mod_localization = "scripts/mods/SuicideWithHostFix/SuicideWithHostFix_localization",
		})
	end,
	packages = {
		"resource_packages/SuicideWithHostFix/SuicideWithHostFix",
	},
}
