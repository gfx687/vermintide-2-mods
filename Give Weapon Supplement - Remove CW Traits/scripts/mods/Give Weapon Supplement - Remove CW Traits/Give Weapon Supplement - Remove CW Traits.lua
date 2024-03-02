local mod = get_mod("Give Weapon Supplement - Remove CW Traits")

local list_to_ignore = {
    ["stagger_aoe_on_crit"] = true,
    ["deus_big_swing_stagger"] = true,
    ["deus_collateral_damage_on_melee_killing_blow"] = true,
    ["deus_ammo_pickup_reload_speed"] = true,
    ["deus_extra_shot"] = true,
    ["deus_crit_chain_lightning"] = true,
    ["home_run"] = true,
    ["bloodthirst"] = true,
    ["follow_up"] = true,
    ["serrated_blade"] = true,
    ["deus_ranged_crit_explosion"] = true,
    ["shard_strike"] = true,
    ["ranged_movespeed_on_damage_taken"] = true,
    ["shield_splinters"] = true,
    ["refilling_shot"] = true,
    ["headhunter"] = true,
    ["armor_breaker"] = true,
    ["always_blocking"] = true,
    ["shield_of_isha"] = true,
    ["piercing_projectiles"] = true,
    ["crescendo_strike"] = true,
    ["melee_heal_on_crit"] = true,
}

mod.on_all_mods_loaded = function()
    local GiveWeapon = get_mod("GiveWeapon")
    if not GiveWeapon then
        mod:echo("[Give Weapon Supplement - Remove CW Traits]: Give Weapon mod is not enabled, this mod is NOT a replacement for Give Weapon, but a supplement.")
        return
    end

    local pl = require'pl.import_into'()
    local tablex = require'pl.tablex'
    local stringx = require'pl.stringx'

    mod:hook_origin(GiveWeapon, "create_window", function(self, profile_index, loadout_inv_view)
        GiveWeapon.loadout_inv_view = loadout_inv_view
        local scale = UIResolutionScale_pow2()
        local screen_width, screen_height = UIResolution() -- luacheck: ignore screen_width
        local window_size = {905+190+15, 80+32}
        local window_position = {850-160, screen_height - window_size[2] - 5}

        self.main_window = GiveWeapon.simple_ui:create_window("give_weapon", window_position, window_size)
        GiveWeapon.main_window:create_title("give_weapon_title", "Give Weapon", 35)

        self.main_window.position = {screen_width - (905+190+15)*scale - 150, screen_height - window_size[2]*scale - 5}

        local pos_x = 5
        local pos_y = GiveWeapon.pos_y

        GiveWeapon.create_weapon_button = self.main_window:create_button("create_weapon_button", {pos_x+90, pos_y+window_size[2]-35-35}, {200, 30}, nil, ">Create Weapon<", nil)
        GiveWeapon.create_weapon_button.on_click = GiveWeapon.on_create_weapon_click

        GiveWeapon.heroes_dropdown = self.main_window:create_dropdown("heroes_dropdown", {pos_x, pos_y+window_size[2]-35},  {180, 30}, nil, GiveWeapon.hero_options, nil, 1)
        GiveWeapon.heroes_dropdown.on_index_changed = function(dropdown)
            GiveWeapon.create_item_types_dropdown(dropdown.index, window_size)
        end
        if profile_index then
            GiveWeapon.heroes_dropdown:select_index(profile_index)
        end

        GiveWeapon.add_property_button = self.main_window:create_button("add_property_button", {pos_x+180+180+5+5+260+5+40, pos_y+window_size[2]-70}, {180, 30}, nil, "Add Property", nil)
        GiveWeapon.add_property_button.on_click = function(button) -- luacheck: ignore button
            local property_name = GiveWeapon.property_names[GiveWeapon.sorted_property_names[GiveWeapon.properties_dropdown.index]]
            if property_name then
                table.insert(GiveWeapon.properties, property_name)
            end
        end

        GiveWeapon.property_names = tablex.pairmap(
            function(property_key, _)
                local full_prop_description = UIUtils.get_property_description(property_key, 0)
                local _, _, prop_description = stringx.partition(full_prop_description, " ")
                prop_description = stringx.replace(prop_description, "Damage", "Dmg")
                if property_key == "deus_power_vs_chaos" then
            prop_description = prop_description.." (CW)"
                end
                return property_key, prop_description
            end,
            WeaponProperties.properties
        )
        GiveWeapon.sorted_property_names = tablex.pairmap(
            function(property_key, _)
                local full_prop_description = UIUtils.get_property_description(property_key, 0)
                local _, _, prop_description = stringx.partition(full_prop_description, " ")
                prop_description = stringx.replace(prop_description, "Damage", "Dmg")
                if property_key == "deus_power_vs_chaos" then
            prop_description = prop_description.." (CW)"
                end
                return prop_description
            end,
            WeaponProperties.properties
        )
        table.sort(GiveWeapon.sorted_property_names)
        local properties_options = tablex.index_map(GiveWeapon.sorted_property_names)

        GiveWeapon.properties_dropdown = self.main_window:create_dropdown("properties_dropdown", {pos_x+180+180+5+5+260+5, pos_y+window_size[2]-35},  {260, 30}, nil, properties_options, nil, 1)

        local filtered_traits = table.clone(WeaponTraits.traits, true)

        if mod:get("give_weapon_remove_cw_traits") then
            for key, val in pairs(list_to_ignore) do
                filtered_traits[key] = nil
            end
        end

        GiveWeapon.trait_names = tablex.pairmap(function(trait_key, trait) return trait_key, Localize(trait.display_name) end, filtered_traits)
        GiveWeapon.sorted_trait_names = tablex.pairmap(function(trait_key, trait) -- luacheck: ignore trait_key
            return Localize(trait.display_name)
        end, filtered_traits)
        table.sort(GiveWeapon.sorted_trait_names)
        local traits_options = tablex.index_map(GiveWeapon.sorted_trait_names)

        GiveWeapon.traits_dropdown = self.main_window:create_dropdown("traits_dropdown", {pos_x+180+180+5+5, pos_y+window_size[2]-35}, {260, 30}, nil, traits_options, nil, 1)

        self.main_window.on_hover_enter = function(window)
            window:focus()
        end

        self.main_window:init()
    end)
end
