to_big = to_big or function(x) return x end
create_badge(_string, _badge_col, _text_col, scaling)


-- ok so for some reason i absolutely NEED a localization file??? -pixel
local jokers_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "localization")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("localization/" .. file))()
end

SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.ObjectType({
	key = "NautilusAdd",
	default = "j_joker",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.Font {
    key = "emoji",
    path = "NotoEmoji-Regular.ttf",
    render_scale = 95,
    TEXT_HEIGHT_SCALE = 1,
    TEXT_OFFSET = { x = 10, y = -17 },
    FONTSCALE = 0.15,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Rarity {
	key = "damn",
	loc_txt = {
		name = "damn"
	},
	badge_colour = HEX('000000')
}

SMODS.Rarity {
	key = "unique",
	loc_txt = {
		name = "Unique"
	},
	badge_colour = HEX('000066')
}

SMODS.Rarity {
	key = "sporadic",
	loc_txt = {
		name = "Sporadic"
	},
	badge_colour = HEX('C2009D')
}

SMODS.Sound({
    key = "water",
    path = "theflood.ogg",
})

SMODS.Sound({
    key = "crunch",
    path = "crunch.ogg",
})

SMODS.ConsumableType{
    key = "FoodCards",
    shader = "foil",
    primary_colour = HEX("133B21"),
    secondary_colour = HEX("00665A"),
    collection_rows = { 4, 4 },
    shop_rate = 0,
    default = "c_naut_CoconutWhole",
    loc_txt = {
        collection = "Food Cards",
        name = "Food",
    },
}

SMODS.Booster{
    key = 'booster_nautilus',
    set = 'Booster',
    atlas = 'CustomBoosters', 
    pos = { x = 0, y = 0 },
    discovered = true,
    loc_txt= {
        name = 'Nautilus Pack',
        text = { "Pick {C:attention}#1#{} card out",
                "{C:attention}#2#{} Nautilus jokers", },
        group_name = "Nautilus Pack",
    },
    
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 1,
    cost = 5,
    kind = "NautPack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("ffac00"))
        return SMODS.create_card({
            set = "NautilusAdd",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}

SMODS.Consumable {
	-- Key for code to find it with
	key = "GreenBerry",
	set = 'FoodCards',
	loc_txt = {
		name = 'Green Crispberry',
		text = {
			"{C:mult}don\'t do it{}"
		}
	},
	atlas = "CustomConsumables",
	pos = {x = 0, y = 0},
	cost = 4,
	use = function(self, card, area, copier)
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0, func = function()
				attention_text({
					text = "Nom...",
                    play_sound("naut_crunch", 0.76, 0.4),
					scale = 1.3, 
					hold = 1.4,
					major = card,
					backdrop_colour = G.C.SECONDARY_SET.Tarot,
					align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or "cm",
					offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
					silent = true
				})
				G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
					play_sound("tarot2", 0.76, 0.4)
					delay(3);return true end}))
				play_sound("tarot2", 1, 0.4)
				card:juice_up(0.3, 0.5)
				return true 
			end}))
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 2, func = function()
				delay(0.5)
				G.STATE = G.STATES.GAME_OVER
				G.STATE_COMPLETE = false
				return true 
			end}))
			return true
	end,
    can_use = function(self, card)
        return true
    end,
    calculate = function(self, card, context)
    if context.joker_main then
    		return {
			Xmult = 0.8
		}
	end
end
}

SMODS.Consumable {
	-- Key for code to find it with
	key = "GreenBerryCooked",
	set = 'FoodCards',
	loc_txt = {
		name = 'Green Crispberry (Cooked)',
		text = {
			"{X:mult,C:white}1.25X{} Mult passively",
            "Level up all hands when eaten"
		}
	},
	atlas = "CustomConsumables",
	pos = {x = 5, y = 0},
	cost = 0,
	use = function(self, card, area, copier)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('naut_crunch')
            card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('naut_crunch')
            card:juice_up(0.8, 0.5)
            return true end }))
        update_hand_text({delay = 0}, {chips = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('naut_crunch')
            card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
        delay(1.3)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true)
        end
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
	end,
    can_use = function(self, card)
        return true
    end,
    calculate = function(self, card, context)
    if context.joker_main then
    		return {
			Xmult = 1.25
		}
	end
end
}

SMODS.Consumable {
	-- Key for code to find it with
	key = "CoconutWhole",
	set = 'FoodCards',
	loc_txt = {
		name = 'Coconut',
		text = {
			"{C:attention}DON\'T LOBOTOMIZE ME{}"
		}
	},
	atlas = "CustomConsumables",
	pos = {x = 3, y = 0},
	cost = 4,
    	can_use = function(self, card)
		return #G.jokers.cards <= G.jokers.config.card_limit
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local deletable_jokers = {}
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0, func = function()
				attention_text({
					text = "BOINK!",
					scale = 1.3, 
					hold = 1.4,
					major = card,
					backdrop_colour = G.C.SECONDARY_SET.Tarot,
					align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or "cm",
					offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
					silent = true
				})
				G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
					play_sound("tarot2", 0.76, 0.4)
					delay(3);return true end}))
				play_sound("tarot2", 1, 0.4)
				card:juice_up(0.3, 0.5)
				return true 
			end}))
                    
		for k, v in pairs(G.jokers.cards) do
			if not SMODS.is_eternal(v) then
				deletable_jokers[#deletable_jokers + 1] = v
			end
		end
		local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed("naut_CoconutWhole"))
		local _first_dissolve = nil
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for k, v in pairs(deletable_jokers) do
					if v == chosen_joker then
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
				end
				return true
			end,
		}))

    force_use = function(self, card, area)
		self:use(card, area)
 end end}

SMODS.Consumable {
	-- Key for code to find it with
	key = "honglu",
	set = 'Tarot',
	loc_txt = {
		name = 'The Flood',
		text = {
			"{C:planet}\"Let\'s visit the world of wonders\"{}"
		}
	},
    config = { extra = {spawned = false} },
	atlas = "CustomConsumables",
	pos = {x = 1, y = 0},
	cost = 4,

	use = function(self, card, area, copier)
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
                                    card.ability.extra.spawned == true,
                                    func = function()
                                        play_sound('tarot2', 0.76, 0.4)
                                        if not card.ability.extra.spawned then
                                            for i = 1, 5 do
					                            SMODS.add_card { key = 'j_naut_wawa' }
				                            end
                                        end
                                        return true
                                    end
                                }))
                                play_sound('tarot2', 1, 0.4)
                                play_sound('naut_water', 1, 0.4)
                                card:juice_up(0.3, 0.5)
                                card.ability.extra.spawned = false
                                return true
                            end
                        })),
                        colour = G.C.WHITE
                    }
                }
            }
        
        }
	end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Joker {
	-- How the code refers to the joker.
	key = 'dud',
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'you got the dud',
		text = {
			"you got the {C:red,s:3}dud{}"
		}
	},
	rarity = "naut_damn",
	atlas = 'CustomJokers',
	pos = { x = 5, y = 0 },
	cost = 6,
    pools = {["NautilusAdd"] = true},
   calculate = function(self, card, context)
        if (context.end_of_round or context.reroll_shop or context.buying_card or
            context.selling_card or context.ending_shop or context.starting_shop or 
            context.ending_booster or context.skipping_booster or context.open_booster or
            context.skip_blind or context.before or context.pre_discard or context.setting_blind or
        context.using_consumeable)   then
            return {
                func = function()
                    
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
                end
            }
        end
    end
}

SMODS.Joker{ --Water
    key = "wawa",
    config = {
        extra = {
        }
    },
    loc_txt = {
        name = 'water',
        text = {
            'i\'m thirsty'
        },
    },
    pos = {
        x = 6,
        y = 0
    },
    cost = 1,
    rarity = "naut_damn",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = {["NautilusAdd"] = true},
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' 
            or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    set_ability = function(self, card, initial)
        card:set_eternal(true)
    end
}

SMODS.Joker {
	key = 'unholybird',
	loc_txt = {
		name = 'Chickadee From Hell',
		text = {
			"{C:mult,s:1.2}THAT BIRD THAT I HATE{}",
			"{s:0.9,C:inactive}+#1# Mult{}",
            "{s:0.85,C:inactive}(Appears in flocks, does not require room){}"
		}
	},
	config = { extra = { mult = 2, spawned = false} },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,

	rarity = 1,

	atlas = 'CustomJokers',

	pos = { x = 8, y = 0 },

	cost = 2,
    pools = {["NautilusAdd"] = true},

calculate = function(self, card, context)
	if context.joker_main and not card.ability.extra.spawned then
		card.ability.extra.spawned = true

		G.E_MANAGER:add_event(Event({
			func = function()
				for i = 1, 1 do
					SMODS.add_card { key = 'j_naut_unholybird' }
				end
				return true
			end
		}))
	end
    if context.joker_main then
    		return {
			mult = card.ability.extra.mult
		}
	end
end
}

SMODS.Joker{ --Kinda Homeless
    key = "kindahomeless",
    config = {
        extra = {
            mult = 8
        }
    },
	loc_txt = {
		name = 'Kinda Homeless',
		text = {
			"{C:red}+#1#{} Mult if played hand",
			"does not contain a {C:attention}Full House{}"
		}
	},
    pos = {
        x = 3,
        y = 0
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["NautilusAdd"] = true},
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if not (next(context.poker_hands["Full House"])) then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

SMODS.Joker {
	key = 'thataintfalco',
	loc_txt = {
		name = 'Jester',
		text = {
			"{C:blue}+#1#{} Chips"
		}
	},
	config = { extra = { chips = 40} },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,

	rarity = 1,

	atlas = 'CustomJokers',

	pos = { x = 0, y = 0 },

	cost = 2,
    pools = {["NautilusAdd"] = true},
    blueprint_compat = true,

calculate = function(self, card, context)
    if context.joker_main then
    		return {
			chips = card.ability.extra.chips
		}
	end
end
}

SMODS.Joker{ --Scheming Joker
	-- How the code refers to the joker.
	key = 'fhchip',
    config = {
        extra = {
            chips = 165
        }
    },
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Scheming Joker',
		text = {
			"{C:blue}+#1#{} Chips if played hand",
            "contains a {C:attention}Full House{}"
		}
	},
    pos = {
        x = 2,
        y = 0
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["NautilusAdd"] = true},
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (next(context.poker_hands["Full House"])) then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

SMODS.Joker{ --Mental Joker
	-- How the code refers to the joker.
	key = 'fhmult',
    config = {
        extra = {
            mult = 16
        }
    },
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Mental Joker',
		text = {
			"{C:mult}+#1#{} Mult if played hand",
            "contains a {C:attention}Full House{}"
		}
	},
    pos = {
        x = 1,
        y = 0
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["NautilusAdd"] = true},
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (next(context.poker_hands["Full House"])) then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

SMODS.Joker{ --The Mansion
	-- How the code refers to the joker.
	key = 'fhxmult',
    config = {
        extra = {
            xmult = 5
        }
    },
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'The Mansion',
		text = {
			"{X:red,C:white}x5{} Mult if played hand",
            "contains a {C:attention}Full House{}"
		}
	},
    pos = {
        x = 4,
        y = 0
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
    cost = 4,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["NautilusAdd"] = true},
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (next(context.poker_hands["Full House"])) then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
    end
}


SMODS.Joker{
    key = 'eyes',
    loc_txt= {
        name = '{f:naut_emoji}👀{}',
        text = { "Copies the",
                    "Joker to its left",}
    },
    atlas = 'CustomJokers',
    rarity = 3,
    cost = 8,
    config = { extra = {spawned = false, spawned2 = false}},
    pools = {["NautilusAdd"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=9, y= 0},

calculate = function(self, card, context)

    local other_joker = nil

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
            if i > 1 then
                other_joker = G.jokers.cards[i - 1]
            end
            break
        end
    end

-- i. hate this code so much -pixel

    local blueprints = SMODS.find_card('j_blueprint')
    local eyes2 = SMODS.find_card('j_naut_eyes')
    local eyes3 = SMODS.find_card('j_naut_crazyEyes')

    if not card.ability.extra.spawned and (#blueprints > 0) and #eyes3 == 0 and context.joker_main then
    card.ability.extra.spawned = true

    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.3,
        func = function()
            play_sound("timpani")

            local second = nil
            for _, v in ipairs(eyes2) do
                v:start_dissolve(nil, second)
                second = true
            end

            local first = nil
            for _, v in ipairs(blueprints) do
                v:start_dissolve(nil, first)
                first = true
            end


            local eyes = create_card(
                'Joker', G.jokers, nil, nil, nil, nil,
                'j_naut_crazyEyes', nil
            )
            for i = 0, 0 do
              G.jokers:emplace(eyes)
              eyes:set_edition({negative = true}, false, false)
              eyes:add_to_deck()
            end

            return true
        end
    }))
end

    if other_joker then
        return SMODS.blueprint_effect(card, other_joker, context)
    end
end


}

SMODS.Joker{
    key = 'crazyEyes',
    loc_txt= {
        name = 'Crazy{f:naut_emoji} 👀{}s',
        text = { "Copies the",
                    "Jokers to its left and right",}
    },
    atlas = 'CustomJokers',
    rarity = 4,
    cost = 8,
    config = { extra = {spawned = false}},
    pools = {["NautilusAdd"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=13, y= 0},

calculate = function(self, card, context)

    -- this code can also go to hell -pixel

    local blueprints = SMODS.find_card('j_blueprint')
    local eyes2 = SMODS.find_card('j_naut_eyes')
    local eyes3 = SMODS.find_card('j_naut_crazyEyes')
    local eyes4 = SMODS.find_card('j_naut_crazierEyes')

    if not card.ability.extra.spawned and (#blueprints > 0) and #eyes2 > 0 and #eyes4 == 0 and context.joker_main then
    card.ability.extra.spawned = true

    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.3,
        func = function()
            play_sound("timpani")

            local third = nil
            for _, v in ipairs(eyes3) do
                v:start_dissolve(nil, third)
                third = true
            end

            local second = nil
            for _, v in ipairs(eyes2) do
                v:start_dissolve(nil, second)
                second = true
            end

            local first = nil
            for _, v in ipairs(blueprints) do
                v:start_dissolve(nil, first)
                first = true
            end


            local eyes = create_card(
                'Joker', G.jokers, nil, nil, nil, nil,
                'j_naut_crazierEyes', nil
            )
            for i = 0, 0 do
              G.jokers:emplace(eyes)
              eyes:set_edition({negative = true}, false, false)
              eyes:add_to_deck()
            end

            return true
        end
    }))
end


local current_index

for i = 1, #G.jokers.cards do
    if G.jokers.cards[i] == card then
        current_index = i
        break
    end
end

local left_ret = SMODS.blueprint_effect(card, G.jokers.cards[current_index - 1], context)
local right_ret = SMODS.blueprint_effect(card, G.jokers.cards[current_index + 1], context)

if context.joker_main then
    CrazyEyesSpawnable = true
end




return SMODS.merge_effects { left_ret or {}, right_ret or {} }-- Can add as many calculate returns as you want


end






}

SMODS.Joker{
    key = 'crazierEyes',
    loc_txt= {
        name = 'See-all',
        text = { "Copies the",
                    "Jokers to its left and right",
                "Copies the passive ability of the",
            "leftmost consumable"}
    },
    atlas = 'CustomJokers',
    rarity = "naut_unique",
    cost = 8,
    config = { extra = {spawned = false}},
    pools = {["NautilusAdd"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=17, y= 0},

calculate = function(self, card, context)

local current_index

for i = 1, #G.jokers.cards do
    if G.jokers.cards[i] == card then
        current_index = i
        break
    end
end

local left_ret = SMODS.blueprint_effect(card, G.jokers.cards[current_index - 1], context)
local right_ret = SMODS.blueprint_effect(card, G.jokers.cards[current_index + 1], context)
local consumable_copy = SMODS.blueprint_effect(card, G.consumeables.cards[1], context)



return SMODS.merge_effects { left_ret or {}, right_ret or {}, consumable_copy or {} }-- Can add as many calculate returns as you want


end






}

SMODS.Joker{
    key = 'eyesDice',
    loc_txt= {
        name = 'Oops! All {f:naut_emoji}👀{}',
        text = { "Creates a {f:naut_emoji}👀{} on cashout",}
    },
    atlas = 'CustomJokers',
    rarity = 4,
    cost = 7,
    config = { extra = {}},
    pools = {["NautilusAdd"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=11, y= 0},
    soul_pos = {x=12, y=0},

    calculate = function(self, card, context)
     if context.end_of_round and not context.repetition and not context.individual then
        		G.E_MANAGER:add_event(Event({
			func = function()
				for i = 1, 1 do
					SMODS.add_card { key = 'j_naut_eyes' }
				end
				return true
			end
		}))end
	end,
}

SMODS.Joker{
    key = 'portStove',

    loc_txt= {
        name = 'Portable Stove',
        text = { "{C:attention}Cooks{} certain consumables or jokers", "at the end of scoring"}
    },
    atlas = 'CustomJokers',
    rarity = 3,
    cost = 7,
    config = { extra = { berryCheck = #SMODS.find_card('c_naut_GreenBerry') }},
    pools = {["NautilusAdd"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=14, y= 0},

    calculate = function(self, card, context)
        if #SMODS.find_card('c_naut_GreenBerry') > 0 and #SMODS.find_card('j_naut_infurnias') < 0 then
            if context.final_scoring_step then
                return {
                    message = 'Cooked!',
                    colour = G.C.DARK_EDITION,
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        local _first_dissolve = nil
                        for _, v in ipairs(SMODS.find_card('c_naut_GreenBerry')) do
                            v:start_dissolve(nil, _first_dissolve)
                            _first_dissolve = true
                            for i = 1, 1 do
                                SMODS.add_card { key = 'c_naut_GreenBerryCooked' }
                            end
                        end

                        return true
                    end
                }))
                return true
            end
        }))
                }, true
            end
        end
    end
}

SMODS.Joker{
    key = 'infurnias',

    loc_txt= {
        name = 'Infurnias',
        text = { "{C:attention}Cooks{} certain consumables or jokers", "at the end of scoring", "{C:attention}Cooked{} cards are {C:dark_edition}Negative{}"}
    },
    atlas = 'CustomJokers',
    rarity = 4,
    cost = 7,
    config = { extra = { berryCheck = #SMODS.find_card('c_naut_GreenBerry') }},
    pools = {["NautilusAdd"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=15, y= 0},
    soul_pos = {x=16, y= 0},

    calculate = function(self, card, context)
        if #SMODS.find_card('c_naut_GreenBerry') > 0 then
            if context.final_scoring_step then
                return {
                    message = 'Cooked!',
                    colour = G.C.DARK_EDITION,
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                G.E_MANAGER:add_event(Event({
                    
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        local _first_dissolve = nil
                        for _, v in ipairs(SMODS.find_card('c_naut_GreenBerry')) do
                            v:start_dissolve(nil, _first_dissolve)
                            _first_dissolve = true
                            for i = 1, 1 do
							 local berry = create_card('FoodCards', G.consumeables, nil, nil, nil, nil, 'c_naut_GreenBerryCooked', nil)
							 G.consumeables:emplace(berry)
							 berry:add_to_deck()
							 berry:set_edition({negative = true}, false, false)
                            end
                        end

                        return true
                    end
                }))
                return true
            end
        }))
                }, true
            end
        end
    end
}

SMODS.Joker{
    key = 'unity',
    loc_txt= {
        name = 'Unity',
        text = { "{s:2,C:dark_edition}???{}",}
    },
    atlas = 'CustomJokers',
    rarity = "naut_damn",
    cost = 100,
    config = { extra = {spawned = false}},
    pools = {["NautilusAdd"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=6, y= 1},

calculate = function(self, card, context)

if context.joker_main then
	error("Use a good game engine, stupid")
end


end






}

SMODS.Joker{
    key = 'theHole',
    loc_txt= {
        name = 'Hole',
        text = { "{X:chips,C:white}+#2#X{} chips for each card destroyed",
                "{C:mult}Self-destructs{} when {X:chips,C:white}2X{} chips are reached",
            "{C:inactive}Currently{} {X:chips,C:white}+#1#X{} {C:inactive}chips{} "}
    },
    atlas = 'CustomJokers',
    rarity = 2,
    cost = 6,
    config = { extra = { xchips1 = 1, xchipsgain = 0.1} },
    pools = {["NautilusAdd"] = true},
	loc_vars = function(self, info_queue, card)
		return { vars = { to_big(card.ability.extra.xchips1), to_big(card.ability.extra.xchipsgain) } }
	end,

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=20, y=0},

calculate = function(self, card, context)

if context.removed then
    card.ability.extra.xchips1 = card.ability.extra.xchips1 + (card.ability.extra.xchipsgain * #context.removed)
end
if context.joker_main then
    if to_big(card.ability.extra.xchips1) >= to_big(2) then
        card:destroy()
    end
			return {
				Xchip_mod = to_big(card.ability.extra.xchips1),
			}


end
end,
}

-- CROSS-MOD!!! ################################################################################################################################

SMODS.Joker{
    key = 'exoticEyes',
    loc_txt= {
        name = 'Photocular',
        text = { "Retriggers the Joker to",
                    "its left and right",
                    "for every {C:attention}Copy/Blueprint",
                    "{C:attention}/Joker Retrigger{} Joker",
                    "{s:0.85,C:inactive}somewhat buggy. oh well{}"}
    },
    atlas = 'CustomJokers',
    rarity = "cry_exotic",
    cost = 8,
    config = { extra = {spawned = false, spawned2 = false}},
    pools = {["NautilusAdd"] = true},
    dependencies = {"Cryptid"},

    
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = "naut_EEyesInfoQ", set = "Other"}
	end,

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=18, y= 1},
    soul_pos = {x=19, y=1, extra = {x=20, y=1}},

calculate = function(self, card, context)
	local current_index
	for i = 1, #G.jokers.cards do
		if G.jokers.cards[i] == card then
			current_index = i
			break
		end
	end

	local blueprints   = SMODS.find_card('j_blueprint')
	local bstorms      = SMODS.find_card('j_brainstorm')
	local canvas       = SMODS.find_card('j_cry_canvas')
	local boredoms     = SMODS.find_card('j_cry_boredom')
	local wees         = SMODS.find_card('j_cry_weegaming')
	local nosounds     = SMODS.find_card('j_cry_nosound')
	local chads        = SMODS.find_card('j_cry_chad')
	local flips        = SMODS.find_card('j_cry_flipside')
	local loopies      = SMODS.find_card('j_cry_loopy')
	local oldbprints   = SMODS.find_card('j_cry_oldblueprint')
	local specgrams    = SMODS.find_card('j_cry_spectrogram')

	if context.retrigger_joker_check and not context.retrigger_joker then
		local am_target = false

		if context.other_card and context.other_card == card then
			am_target = true
		end
		if context.triggering_card and context.triggering_card == card then
			am_target = true
		end
		if context.retrigger_target and context.retrigger_target == card then
			am_target = true
		end

		if not am_target and context.retrigger_origin_x and card.T then
			local eps = 1e-6
			if math.abs(card.T.x - context.retrigger_origin_x) < eps then
				am_target = true
			end
		end

		if am_target then
			local num_retriggers = #blueprints + #bstorms + #boredoms + #wees + #nosounds + #canvas + #flips + #chads + #loopies + #oldbprints + #specgrams - 1
			if num_retriggers <= 0 then
				num_retriggers = 1
			end

			return {
				message = localize("k_again_ex"),
				repetitions = num_retriggers,
				card = card,
			}
		end
	end

	local left_ret = nil
	local right_ret = nil
	if current_index and current_index > 1 then
		left_ret = SMODS.blueprint_effect(card, G.jokers.cards[current_index - 1], context)
	end
	if current_index and current_index < #G.jokers.cards then
		right_ret = SMODS.blueprint_effect(card, G.jokers.cards[current_index + 1], context)
	end

	return SMODS.merge_effects { left_ret or {}, right_ret or {} }
end





}





















































