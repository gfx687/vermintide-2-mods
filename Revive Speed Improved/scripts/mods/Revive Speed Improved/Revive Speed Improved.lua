local mod = get_mod("Revive Speed Improved")

-- assisted_respawn

mod:hook(InteractionDefinitions.assisted_respawn.server, "start", function (func, world, interactor_unit, interactable_unit, data, config, t)
    local duration = config.duration
    local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
    duration = buff_extension:apply_buffs_to_value(duration, "faster_revive")
    local config_new = { duration = duration }

    func(world, interactor_unit, interactable_unit, data, config_new, t)
end)

mod:hook(InteractionDefinitions.assisted_respawn.client, "start", function (func, world, interactor_unit, interactable_unit, data, config, t)
    local duration = config.duration
    local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
    duration = buff_extension:apply_buffs_to_value(duration, "faster_revive")
    local config_new = { duration = duration }

    func(world, interactor_unit, interactable_unit, data, config_new, t)
    data.duration = duration
end)

mod:hook(InteractionDefinitions.assisted_respawn.client, "get_progress", function (func, data, config, t)
    local config_new = { duration = data.duration }
    return func(data, config_new, t)
end)

-- pull_up

mod:hook(InteractionDefinitions.pull_up.server, "start", function (func, world, interactor_unit, interactable_unit, data, config, t)
    local duration = config.duration
    local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
    duration = buff_extension:apply_buffs_to_value(duration, "faster_revive")
    local config_new = { duration = duration }

    func(world, interactor_unit, interactable_unit, data, config_new, t)
end)

mod:hook(InteractionDefinitions.pull_up.client, "start", function (func, world, interactor_unit, interactable_unit, data, config, t)
    local duration = config.duration
    local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
    duration = buff_extension:apply_buffs_to_value(duration, "faster_revive")
    local config_new = { duration = duration }

    func(world, interactor_unit, interactable_unit, data, config_new, t)
    data.duration = duration
end)

mod:hook(InteractionDefinitions.pull_up.client, "get_progress", function (func, data, config, t)
    local config_new = { duration = data.duration }
    return func(data, config_new, t)
end)

-- release_from_hook

mod:hook(InteractionDefinitions.release_from_hook.server, "start", function (func, world, interactor_unit, interactable_unit, data, config, t)
    local duration = config.duration
    local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
    duration = buff_extension:apply_buffs_to_value(duration, "faster_revive")
    local config_new = { duration = duration }

    func(world, interactor_unit, interactable_unit, data, config_new, t)
end)

mod:hook(InteractionDefinitions.release_from_hook.client, "start", function (func, world, interactor_unit, interactable_unit, data, config, t)
    local duration = config.duration
    local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
    duration = buff_extension:apply_buffs_to_value(duration, "faster_revive")
    local config_new = { duration = duration }

    func(world, interactor_unit, interactable_unit, data, config_new, t)
    data.duration = duration
end)

mod:hook(InteractionDefinitions.release_from_hook.client, "get_progress", function (func, data, config, t)
    local config_new = { duration = data.duration }
    return func(data, config_new, t)
end)