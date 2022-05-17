return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Full Charge Indicator` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Full Charge Indicator", {
			mod_script       = "scripts/mods/Full Charge Indicator/Full Charge Indicator",
			mod_data         = "scripts/mods/Full Charge Indicator/Full Charge Indicator_data",
			mod_localization = "scripts/mods/Full Charge Indicator/Full Charge Indicator_localization",
		})
	end,
	packages = {
		"resource_packages/Full Charge Indicator/Full Charge Indicator",
	},
}
