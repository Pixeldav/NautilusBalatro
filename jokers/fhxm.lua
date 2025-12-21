
SMODS.Joker{ --The Pinnacle
    key = "fhxm",
    config = {
        extra = {
            xmult0 = 5
        }
    },
    loc_txt = {
        ['name'] = 'The Pinnacle',
        ['text'] = {
            [1] = '{X:red,C:white}x5{} Mult if played hand',
            [2] = 'contains a {C:attention}Full House{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = 3,
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
                    Xmult = 5
                }
            end
        end
    end
}