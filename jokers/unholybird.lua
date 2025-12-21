
SMODS.Joker{ --bird
    key = "unholybird",
    config = {
        extra = {
            mult = 20
        }
    },
    loc_txt = {
        ['name'] = 'Chickadee From Hell',
        ['text'] = {
            [1] = 'THAT FUCKING BIRD THAT I HATE',
            [2] = '{s:0.5,C:inactive}+20 Mult{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["naut_naut_jokers"] = true },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                G.E_MANAGER:add_event(event),
                 func = function()
                    SMODS.add_card {
                        set = 'Joker',
                        key = 'j_naut_unholybird'
                    }
                end,
                mult = 20
            }
        end
    end
}