
SMODS.Joker{ --New Joker
    key = "newjoker",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'New Joker',
        ['text'] = {
            [1] = 'A {C:blue}custom{} joker with {C:red}unique{} effects.',
            [2] = '{C:inactive}does jack shit for now{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
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
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["naut_naut_jokers"] = true }
}