SMODS.Rarity {
    key = "damn",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('000000'),
    loc_txt = {
        name = "damn"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}