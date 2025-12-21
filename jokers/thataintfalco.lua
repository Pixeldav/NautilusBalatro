
SMODS.Joker{ --Jester
    key = "thataintfalco",
    config = {
        extra = {
            chips0 = 40
        }
    },
    loc_txt = {
        ['name'] = 'Jester',
        ['text'] = {
            [1] = '{C:blue}+40{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["naut_naut_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = 40
            }
        end
    end
}