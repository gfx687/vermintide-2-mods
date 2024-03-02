return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Knocked Down Do Not Die` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Knocked Down Do Not Die", {
			mod_script       = "scripts/mods/Knocked Down Do Not Die/Knocked Down Do Not Die",
			mod_data         = "scripts/mods/Knocked Down Do Not Die/Knocked Down Do Not Die_data",
			mod_localization = "scripts/mods/Knocked Down Do Not Die/Knocked Down Do Not Die_localization",
		})
	end,
	packages = {
		"resource_packages/Knocked Down Do Not Die/Knocked Down Do Not Die",
	},
}
