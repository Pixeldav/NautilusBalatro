
SMODS.Consumable {
    key = 'honglu',
    set = 'Tarot',
    pos = { x = 1, y = 0 },
    config = { 
        extra = {
            repetitions = 85   
        } 
    },
    loc_txt = {
        name = 'The Flood',
        text = {
            [1] = '{C:planet}\"Let\'s visit the world of wonders\"{}'
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
            func = function()
                play_sound("naut_theflood")
                
                return true
            end,
        }))
        return {
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = "Happiness",
                        scale = 1.3,
                        hold = 0.2,
                        major = card,
                        backdrop_colour = G.C.YELLOW,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                        'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true,
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            })),
            extra = {
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = "Wrath",
                            scale = 1.3,
                            hold = 0.2,
                            major = card,
                            backdrop_colour = G.C.RED,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true,
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                })),
                colour = G.C.WHITE,
                extra = {
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            attention_text({
                                text = "Sorrow",
                                scale = 1.3,
                                hold = 0.2,
                                major = card,
                                backdrop_colour = G.C.BLUE,
                                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                                offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                                silent = true,
                            })
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.06 * G.SETTINGS.GAMESPEED,
                                blockable = false,
                                blocking = false,
                                func = function()
                                    play_sound('tarot2', 0.76, 0.4)
                                    return true
                                end
                            }))
                            play_sound('tarot2', 1, 0.4)
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    })),
                    colour = G.C.WHITE,
                    extra = {
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                attention_text({
                                    text = "Joy",
                                    scale = 1.3,
                                    hold = 0.2,
                                    major = card,
                                    backdrop_colour = G.C.SECONDARY_SET.Planet,
                                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                    'tm' or 'cm',
                                    offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                                    silent = true,
                                })
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.06 * G.SETTINGS.GAMESPEED,
                                    blockable = false,
                                    blocking = false,
                                    func = function()
                                        play_sound('tarot2', 0.76, 0.4)
                                        return true
                                    end
                                }))
                                play_sound('tarot2', 1, 0.4)
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        })),
                        colour = G.C.WHITE
                    }
                }
            }
            ,
            func = function()
                for i = 1, 85 do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_naut_wawa' })
                            if new_joker then
                                new_joker:add_sticker('eternal', true)
                            end
                            used_card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                    delay(0.6)
                    
                end
                return true
            end
        }
    end,
    can_use = function(self, card)
        return true
    end
}