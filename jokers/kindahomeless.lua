
SMODS.Joker{ --Kinda Homeless
    key = "kindahomeless",
    config = {
        extra = {
            mult0 = 8
        }
    },
    loc_txt = {
        ['name'] = 'Kinda Homeless',
        ['text'] = {
            [1] = '{C:red}+8{} Mult if played hand',
            [2] = 'does not contain a {C:attention}Full House{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["naut_naut_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if not (next(context.poker_hands["Full House"])) then
                return {
                    mult = 8
                }
            end
        end
    end
}