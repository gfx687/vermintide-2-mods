local mod = get_mod("Knocked Down Do Not Die")

-- check the unit you are interacting with for knocked down debuffs and slow down if yes
-- revive speed is HOST-side. CLIENT needs it too, but only for correct visualization of progress

mod:hook(InteractionDefinitions.revive.server, "start",
    function(func, world, interactor_unit, interactable_unit, data, config, t)
        local buff_extension = ScriptUnit.extension(interactable_unit, "buff_system")

        local duration = config.duration
        if buff_extension:has_buff_type("knocked_down_debuff_1") then
            duration = duration
        elseif buff_extension:has_buff_type("knocked_down_debuff_2") then
            duration = duration * 2
        elseif buff_extension:has_buff_type("knocked_down_debuff_3") then
            duration = duration * 5
        end

        local config_new = { duration = duration }

        func(world, interactor_unit, interactable_unit, data, config_new, t)
    end)

mod:hook(InteractionDefinitions.revive.client, "start",
    function(func, world, interactor_unit, interactable_unit, data, config, t)
        local buff_extension = ScriptUnit.extension(interactable_unit, "buff_system")

        local duration = config.duration
        if buff_extension:has_buff_type("knocked_down_debuff_1") then
            duration = duration
        elseif buff_extension:has_buff_type("knocked_down_debuff_2") then
            duration = duration * 2
        elseif buff_extension:has_buff_type("knocked_down_debuff_3") then
            duration = duration * 5
        end

        local config_new = { duration = duration }

        func(world, interactor_unit, interactable_unit, data, config_new, t)
        data.duration = duration
    end)

mod:hook(InteractionDefinitions.revive.client, "get_progress", function(func, data, config, t)
    local config_new = { duration = data.duration }
    return func(data, config_new, t)
end)
