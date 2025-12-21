
SMODS.Joker{ --Scheming Joker
    key = "fhchip",
    config = {
        extra = {
            chips0 = 165
        }
    },
    loc_txt = {
        ['name'] = 'Scheming Joker',
        ['text'] = {
            [1] = '{C:blue}+165{} Chips if played hand',
            [2] = 'contains a {C:attention}Full House{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
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
                    chips = 165
                }
            end
        end
    end
}