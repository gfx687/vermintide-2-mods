return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Revive Speed Improved` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Revive Speed Improved", {
			mod_script       = "scripts/mods/Revive Speed Improved/Revive Speed Improved",
			mod_data         = "scripts/mods/Revive Speed Improved/Revive Speed Improved_data",
			mod_localization = "scripts/mods/Revive Speed Improved/Revive Speed Improved_localization",
		})
	end,
	packages = {
		"resource_packages/Revive Speed Improved/Revive Speed Improved",
	},
}
