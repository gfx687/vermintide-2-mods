local mod = get_mod("Knocked Down Do Not Die")

local buff_perks = require("scripts/unit_extensions/default_player_unit/buffs/settings/buff_perk_names")

local function merge(dst, src)
    for k, v in pairs(src) do
        dst[k] = v
    end
    return dst
end

function mod.add_talent_buff_template(self, hero_name, buff_name, buff_data, extra_data)
    local new_talent_buff = {
        buffs = {
            merge({ name = buff_name }, buff_data),
        },
    }
    if extra_data then
        new_talent_buff = merge(new_talent_buff, extra_data)
    elseif type(buff_data[1]) == "table" then
        new_talent_buff = {
            buffs = buff_data,
        }
        if new_talent_buff.buffs[1].name == nil then
            new_talent_buff.buffs[1].name = buff_name
        end
    end
    TalentBuffTemplates[hero_name][buff_name] = new_talent_buff
    BuffTemplates[buff_name] = new_talent_buff
    local index = #NetworkLookup.buff_templates + 1
    NetworkLookup.buff_templates[index] = buff_name
    NetworkLookup.buff_templates[buff_name] = index
end

function mod:add_knocked_down_debuff(player_unit)
    local buff_extension = ScriptUnit.has_extension(player_unit, "buff_system")
    buff_extension:add_buff("knocked_down_debuff_1")
end

function mod:remove_knocked_down_debuffs(player_unit)
    local buff_extension = ScriptUnit.has_extension(player_unit, "buff_system")
    local buff1 = buff_extension:get_non_stacking_buff("knocked_down_debuff_1")
    if buff1 then
        buff_extension:remove_buff(buff1.id)
    end

    local buff2 = buff_extension:get_non_stacking_buff("knocked_down_debuff_2")
    if buff2 then
        buff_extension:remove_buff(buff2.id)
    end

    local buff3 = buff_extension:get_non_stacking_buff("knocked_down_debuff_3")
    if buff3 then
        buff_extension:remove_buff(buff3.id)
    end
end

mod:add_talent_buff_template("bright_wizard", "knocked_down_debuff_1", {
    -- icon = "deus_curse_slaanesh_01",
    max_stacks = 1,
    duration = 5,
    buff_to_add = "knocked_down_debuff_2",
    duration_end_func = "add_buff_local",
    perks = {
        buff_perks.invulnerable,
    },
})

mod:add_talent_buff_template("bright_wizard", "knocked_down_debuff_2", {
    -- icon = "deus_curse_slaanesh_01",
    max_stacks = 1,
    duration = 5,
    buff_to_add = "knocked_down_debuff_3",
    duration_end_func = "add_buff_local",
    perks = {
        buff_perks.invulnerable,
    },
})

mod:add_talent_buff_template("bright_wizard", "knocked_down_debuff_3", {
    -- icon = "deus_curse_slaanesh_01",
    max_stacks = 1,
    perks = {
        buff_perks.invulnerable,
    },
})
