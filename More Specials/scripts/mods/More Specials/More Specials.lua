local mod = get_mod("More Specials")
local mutator = mod:persistent_table("more_specials")

mutator.start = function()
	mutator.OriginalSpecialsSettings = table.clone(SpecialsSettings)
	mutator.OriginalPacingSettingsDefault = table.clone(PacingSettings.default)
	mutator.OriginalPacingSettingsChaos = table.clone(PacingSettings.chaos)
	mutator.OriginalPacingSettingsBeastmen = table.clone(PacingSettings.beastmen)

	SpecialsSettings.default.max_specials = mod:get("more_specials_skaven_areas")
	SpecialsSettings.default_light.max_specials = mod:get("more_specials_skaven_areas")
	SpecialsSettings.skaven.max_specials = mod:get("more_specials_skaven_areas")
	SpecialsSettings.skaven_light.max_specials = mod:get("more_specials_skaven_areas")
	SpecialsSettings.chaos.max_specials = mod:get("more_specials_chaos_areas")
	SpecialsSettings.chaos_light.max_specials = mod:get("more_specials_chaos_areas")
	SpecialsSettings.beastmen.max_specials = mod:get("more_specials_chaos_areas")
	SpecialsSettings.skaven_beastmen.max_specials = mod:get("more_specials_chaos_areas")
	SpecialsSettings.chaos_beastmen.max_specials = mod:get("more_specials_chaos_areas")

	PacingSettings.default.delay_specials_threat_value = nil
	PacingSettings.chaos.delay_specials_threat_value = nil
	PacingSettings.beastmen.delay_specials_threat_value = nil

	SpecialsSettings.default.methods.specials_by_slots = {
		max_of_same = mod:get("more_specials_max_of_same"),
		coordinated_attack_cooldown_multiplier = 0.5,
		chance_of_coordinated_attack = 0.5,
		select_next_breed = "get_random_breed",
		after_safe_zone_delay = {
			5,
			20
		},
		spawn_cooldown = {
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper")
		}
	}
	SpecialsSettings.default_light.methods.specials_by_slots = {
		max_of_same = mod:get("more_specials_max_of_same"),
		coordinated_attack_cooldown_multiplier = 0.5,
		chance_of_coordinated_attack = 0.5,
		select_next_breed = "get_random_breed",
		after_safe_zone_delay = {
			5,
			20
		},
		spawn_cooldown = {
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper")
		}
	}
	SpecialsSettings.skaven.methods.specials_by_slots = {
		max_of_same = mod:get("more_specials_max_of_same"),
		coordinated_attack_cooldown_multiplier = 0.5,
		chance_of_coordinated_attack = 0.5,
		select_next_breed = "get_random_breed",
		after_safe_zone_delay = {
			5,
			20
		},
		spawn_cooldown = {
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper")
		}
	}
	SpecialsSettings.skaven_light.methods.specials_by_slots = {
		max_of_same = mod:get("more_specials_max_of_same"),
		coordinated_attack_cooldown_multiplier = 0.5,
		chance_of_coordinated_attack = 0.5,
		select_next_breed = "get_random_breed",
		after_safe_zone_delay = {
			5,
			20
		},
		spawn_cooldown = {
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper")
		}
	}
	SpecialsSettings.chaos.methods.specials_by_slots = {
		max_of_same = mod:get("more_specials_max_of_same"),
		coordinated_attack_cooldown_multiplier = 0.5,
		chance_of_coordinated_attack = 0.5,
		select_next_breed = "get_random_breed",
		after_safe_zone_delay = {
			5,
			20
		},
		spawn_cooldown = {
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper")
		}
	}
	SpecialsSettings.chaos_light.methods.specials_by_slots = {
		max_of_same = mod:get("more_specials_max_of_same"),
		coordinated_attack_cooldown_multiplier = 0.5,
		chance_of_coordinated_attack = 0.5,
		select_next_breed = "get_random_breed",
		after_safe_zone_delay = {
			5,
			20
		},
		spawn_cooldown = {
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper")
		}
	}
	SpecialsSettings.beastmen.methods.specials_by_slots = {
		max_of_same = mod:get("more_specials_max_of_same"),
		coordinated_attack_cooldown_multiplier = 0.5,
		chance_of_coordinated_attack = 0.5,
		select_next_breed = "get_random_breed",
		after_safe_zone_delay = {
			5,
			20
		},
		spawn_cooldown = {
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper")
		}
	}
	SpecialsSettings.skaven_beastmen.methods.specials_by_slots = {
		max_of_same = mod:get("more_specials_max_of_same"),
		coordinated_attack_cooldown_multiplier = 0.5,
		chance_of_coordinated_attack = 0.5,
		select_next_breed = "get_random_breed",
		after_safe_zone_delay = {
			5,
			20
		},
		spawn_cooldown = {
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper")
		}
	}
	SpecialsSettings.chaos_beastmen.methods.specials_by_slots = {
		max_of_same = mod:get("more_specials_max_of_same"),
		coordinated_attack_cooldown_multiplier = 0.5,
		chance_of_coordinated_attack = 0.5,
		select_next_breed = "get_random_breed",
		after_safe_zone_delay = {
			5,
			20
		},
		spawn_cooldown = {
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper")
		}
	}

	SpecialsSettings.default.difficulty_overrides.hard = nil
	SpecialsSettings.default.difficulty_overrides.harder = nil
	SpecialsSettings.default.difficulty_overrides.hardest = nil
	SpecialsSettings.default.difficulty_overrides.cataclysm = nil
	SpecialsSettings.default.difficulty_overrides.cataclysm_2 = nil
	SpecialsSettings.default.difficulty_overrides.cataclysm_3 = nil
	SpecialsSettings.default_light.difficulty_overrides.hard = nil
	SpecialsSettings.default_light.difficulty_overrides.harder = nil
	SpecialsSettings.default_light.difficulty_overrides.hardest = nil
	SpecialsSettings.default_light.difficulty_overrides.cataclysm = nil
	SpecialsSettings.default_light.difficulty_overrides.cataclysm_2 = nil
	SpecialsSettings.default_light.difficulty_overrides.cataclysm_3 = nil
	SpecialsSettings.skaven.difficulty_overrides.hard = nil
	SpecialsSettings.skaven.difficulty_overrides.harder = nil
	SpecialsSettings.skaven.difficulty_overrides.hardest = nil
	SpecialsSettings.skaven.difficulty_overrides.cataclysm = nil
	SpecialsSettings.skaven.difficulty_overrides.cataclysm_2 = nil
	SpecialsSettings.skaven.difficulty_overrides.cataclysm_3 = nil
	SpecialsSettings.skaven_light.difficulty_overrides.hard = nil
	SpecialsSettings.skaven_light.difficulty_overrides.harder = nil
	SpecialsSettings.skaven_light.difficulty_overrides.hardest = nil
	SpecialsSettings.skaven_light.difficulty_overrides.cataclysm = nil
	SpecialsSettings.skaven_light.difficulty_overrides.cataclysm_2 = nil
	SpecialsSettings.skaven_light.difficulty_overrides.cataclysm_3 = nil
	SpecialsSettings.chaos.difficulty_overrides.hard = nil
	SpecialsSettings.chaos.difficulty_overrides.harder = nil
	SpecialsSettings.chaos.difficulty_overrides.hardest = nil
	SpecialsSettings.chaos.difficulty_overrides.cataclysm = nil
	SpecialsSettings.chaos.difficulty_overrides.cataclysm_2 = nil
	SpecialsSettings.chaos.difficulty_overrides.cataclysm_3 = nil
	SpecialsSettings.chaos_light.difficulty_overrides.hard = nil
	SpecialsSettings.chaos_light.difficulty_overrides.harder = nil
	SpecialsSettings.chaos_light.difficulty_overrides.hardest = nil
	SpecialsSettings.chaos_light.difficulty_overrides.cataclysm = nil
	SpecialsSettings.chaos_light.difficulty_overrides.cataclysm_2 = nil
	SpecialsSettings.chaos_light.difficulty_overrides.cataclysm_3 = nil
	SpecialsSettings.beastmen.difficulty_overrides.hard = nil
	SpecialsSettings.beastmen.difficulty_overrides.harder = nil
	SpecialsSettings.beastmen.difficulty_overrides.hardest = nil
	SpecialsSettings.beastmen.difficulty_overrides.cataclysm = nil
	SpecialsSettings.beastmen.difficulty_overrides.cataclysm_2 = nil
	SpecialsSettings.beastmen.difficulty_overrides.cataclysm_3 = nil
	SpecialsSettings.skaven_beastmen.difficulty_overrides.hard = nil
	SpecialsSettings.skaven_beastmen.difficulty_overrides.harder = nil
	SpecialsSettings.skaven_beastmen.difficulty_overrides.hardest = nil
	SpecialsSettings.skaven_beastmen.difficulty_overrides.cataclysm = nil
	SpecialsSettings.skaven_beastmen.difficulty_overrides.cataclysm_2 = nil
	SpecialsSettings.skaven_beastmen.difficulty_overrides.cataclysm_3 = nil
	SpecialsSettings.chaos_beastmen.difficulty_overrides.hard = nil
	SpecialsSettings.chaos_beastmen.difficulty_overrides.harder = nil
	SpecialsSettings.chaos_beastmen.difficulty_overrides.hardest = nil
	SpecialsSettings.chaos_beastmen.difficulty_overrides.cataclysm = nil
	SpecialsSettings.chaos_beastmen.difficulty_overrides.cataclysm_2 = nil
	SpecialsSettings.chaos_beastmen.difficulty_overrides.cataclysm_3 = nil

    mutator.active = true
end

mutator.stop = function()
	SpecialsSettings.default.max_specials = mutator.OriginalSpecialsSettings.default.max_specials
	SpecialsSettings.default_light.max_specials = mutator.OriginalSpecialsSettings.default_light.max_specials
	SpecialsSettings.skaven.max_specials = mutator.OriginalSpecialsSettings.skaven.max_specials
	SpecialsSettings.skaven_light.max_specials = mutator.OriginalSpecialsSettings.skaven_light.max_specials
	SpecialsSettings.chaos.max_specials = mutator.OriginalSpecialsSettings.chaos.max_specials
	SpecialsSettings.chaos_light.max_specials = mutator.OriginalSpecialsSettings.chaos_light.max_specials
	SpecialsSettings.beastmen.max_specials = mutator.OriginalSpecialsSettings.beastmen.max_specials
	SpecialsSettings.skaven_beastmen.max_specials = mutator.OriginalSpecialsSettings.skaven_beastmen.max_specials
	SpecialsSettings.chaos_beastmen.max_specials = mutator.OriginalSpecialsSettings.chaos_beastmen.max_specials

	SpecialsSettings.default.methods.specials_by_slots = mutator.OriginalSpecialsSettings.default.methods.specials_by_slots
	SpecialsSettings.default_light.methods.specials_by_slots = mutator.OriginalSpecialsSettings.default_light.methods.specials_by_slots
	SpecialsSettings.skaven.methods.specials_by_slots = mutator.OriginalSpecialsSettings.skaven.methods.specials_by_slots
	SpecialsSettings.skaven_light.methods.specials_by_slots = mutator.OriginalSpecialsSettings.skaven_light.methods.specials_by_slots
	SpecialsSettings.chaos.methods.specials_by_slots = mutator.OriginalSpecialsSettings.chaos.methods.specials_by_slots
	SpecialsSettings.chaos_light.methods.specials_by_slots = mutator.OriginalSpecialsSettings.chaos_light.methods.specials_by_slots
	SpecialsSettings.beastmen.methods.specials_by_slots = mutator.OriginalSpecialsSettings.beastmen.methods.specials_by_slots
	SpecialsSettings.skaven_beastmen.methods.specials_by_slots = mutator.OriginalSpecialsSettings.skaven_beastmen.methods.specials_by_slots
	SpecialsSettings.chaos_beastmen.methods.specials_by_slots = mutator.OriginalSpecialsSettings.chaos_beastmen.methods.specials_by_slots

	SpecialsSettings.default.difficulty_overrides = mutator.OriginalSpecialsSettings.default.difficulty_overrides
	SpecialsSettings.default_light.difficulty_overrides = mutator.OriginalSpecialsSettings.default_light.difficulty_overrides
	SpecialsSettings.skaven.difficulty_overrides = mutator.OriginalSpecialsSettings.skaven.difficulty_overrides
	SpecialsSettings.skaven_light.difficulty_overrides = mutator.OriginalSpecialsSettings.skaven_light.difficulty_overrides
	SpecialsSettings.chaos.difficulty_overrides = mutator.OriginalSpecialsSettings.chaos.difficulty_overrides
	SpecialsSettings.chaos_light.difficulty_overrides = mutator.OriginalSpecialsSettings.chaos_light.difficulty_overrides
	SpecialsSettings.beastmen.difficulty_overrides = mutator.OriginalSpecialsSettings.beastmen.difficulty_overrides
	SpecialsSettings.skaven_beastmen.difficulty_overrides = mutator.OriginalSpecialsSettings.skaven_beastmen.difficulty_overrides
	SpecialsSettings.chaos_beastmen.difficulty_overrides = mutator.OriginalSpecialsSettings.chaos_beastmen.difficulty_overrides

	PacingSettings.default.delay_specials_threat_value = mutator.OriginalPacingSettingsDefault.delay_specials_threat_value
	PacingSettings.chaos.delay_specials_threat_value = mutator.OriginalPacingSettingsChaos.delay_specials_threat_value
	PacingSettings.beastmen.delay_specials_threat_value = mutator.OriginalPacingSettingsBeastmen.delay_specials_threat_value

    mutator.active = false
end

mutator.toggle = function()
	if Managers.state.game_mode == nil or (Managers.state.game_mode._game_mode_key ~= "inn" and Managers.player.is_server) then
		mod:echo("You must be in the keep to do that!")
		return
	end
	if Managers.matchmaking:_matchmaking_status() ~= "idle" then
		mod:echo("You must cancel matchmaking before toggling this.")
		return
	end
	if not mutator.active then
		if not Managers.player.is_server then
			mod:echo("You must be the host to activate this.")
			return
		end
		mutator.start()
		local settings = string.format("Settings: skaven - %s, chaos - %s, dupes - %s, timers - [%ss - %ss]",
			mod:get("more_specials_skaven_areas"),
			mod:get("more_specials_chaos_areas"),
			mod:get("more_specials_max_of_same"),
			mod:get("more_specials_cooldown_lower"),
			mod:get("more_specials_cooldown_upper"))
		mod:chat_broadcast("more_specials ENABLED. " .. settings)
	else
		mutator.stop()
		mod:chat_broadcast("more_specials DISABLED.")
	end
end

mod.on_game_state_changed = function(status, state)
	if not Managers.player.is_server and mutator.active and Managers.state.game_mode ~= nil then
		mutator.stop()
		mod:echo("more_specials mutator was disabled because you are no longer the server.")
	end
end

mod:command("more_specials", "Add more specials to the game. Don't use with Ons versions that change specials (plus with /makeitharder, dutch, spicy). If you did - restart the game.", function() mutator.toggle() end)
