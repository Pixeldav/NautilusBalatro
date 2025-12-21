
SMODS.Booster {
    key = 'nautilus_pack',
    loc_txt = {
        name = "Nautilus Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to {C:attention}3{} Joker cards',
            [2] = 'from the {C:dark_edition}Nautilus Mod{}'
        },
        group_name = "naut_boosters"
    },
    config = { extra = 3, choose = 1 },
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    group_key = "naut_boosters",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Joker",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        }
    end,
    particles = function(self)
        -- No particles for joker packs
        end,
    }
    