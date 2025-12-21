
SMODS.Consumable {
    key = 'nautilusjudgement',
    set = 'Tarot',
    pos = { x = 2, y = 0 },
    config = { 
        extra = {
            odds = 50   
        } 
    },
    loc_txt = {
        name = 'Nautilus Judgement',
        text = {
            [1] = 'Creates a random {C:attention}Joker{} card',
            [2] = 'from the {C:dark_edition}Nautilus Mod{}',
            [3] = '{C:inactive}(must have room){}'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = 'naut_naut_jokers' })
                    if new_joker then
                    end
                    G.GAME.joker_buffer = 0
                end
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
        if SMODS.pseudorandom_probability(card, 'group_0_1838e427', 1, card.ability.extra.odds, 'j_naut_nautilusjudgement', false) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("naut_ygtd")
                    
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_naut_dud' })
                    if new_joker then
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
            SMODS.calculate_effect({func = function()
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        if G.STAGE == G.STAGES.RUN then 
                            G.STATE = G.STATES.GAME_OVER
                            G.STATE_COMPLETE = false
                        end
                    end
                }))
                
                return true
            end}, card)
        end
    end,
    can_use = function(self, card)
        return true
    end
}