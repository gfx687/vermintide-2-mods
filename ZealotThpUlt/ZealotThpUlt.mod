return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`ZealotThpUlt` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("ZealotThpUlt", {
			mod_script       = "scripts/mods/ZealotThpUlt/ZealotThpUlt",
			mod_data         = "scripts/mods/ZealotThpUlt/ZealotThpUlt_data",
			mod_localization = "scripts/mods/ZealotThpUlt/ZealotThpUlt_localization",
		})
	end,
	packages = {
		"resource_packages/ZealotThpUlt/ZealotThpUlt",
	},
}
