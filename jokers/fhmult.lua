
SMODS.Joker{ --Mental Joker
    key = "fhmult",
    config = {
        extra = {
            mult0 = 16
        }
    },
    loc_txt = {
        ['name'] = 'Mental Joker',
        ['text'] = {
            [1] = '{C:red}+16{} Mult if played hand',
            [2] = 'contains a {C:attention}Full House{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
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
            if next(context.poker_hands["Full House"]) then
                return {
                    mult = 16
                }
            end
        end
    end
}