
SMODS.Consumable {
    key = 'greencrispberry',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Green Crispberry',
        text = {
            [1] = 'not again'
        }
    },
    cost = 1,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
	use = function(self, card, area, copier)
			-- 50% chance: ends the run
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
    end
}