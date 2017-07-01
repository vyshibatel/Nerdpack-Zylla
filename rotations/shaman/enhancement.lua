local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rSHAMAN |cffADFF2FEnhancement |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/X - 3/X - 4/3 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Lightning Surge Totem', 'keybind(lcontrol)' , 'cursor.ground'}
}

local PreCombat = {
	{'Healing Surge', '!moving&player.health<80', 'player'},
	{'Ghost Wolf', 'movingfor>1&!player.buff(Ghost Wolf)'},
}

local Survival = {
	{'!Healing Surge', 'player.health<80&player.maelstrom>10', 'player'},
}

local Cooldowns = {

}

local Interrupts = {
	{'!Wind Shear'},
}

local xCombat = {
	{'Feral Spirit', 'toggle(Cooldowns)'},
	{'Crash Lightning', 'artifact(Alpha Wolf).enabled&prev_gcd(Feral Spirit)'},
	{'Berserking', 'player.buff(Ascendance)||!talent(7,1)||player.level<100'},
	{'Blood Fury'},
	{'Crash Lightning', 'talent(6,1)&player.buff(Crash Lightning).remains<gcd&player.area(8).enemies>2'},
	{'Boulderfist', 'player.buff(Boulderfist).remains<gcd&player.maelstrom<60&player.area(8).enemies>2'},
	{'Boulderfist', 'player.buff(Boulderfist).remains<gcd||{spell(Boulderfist).charges>1.75&player.maelstrom<200&player.area(8).enemies<3}'},
	{'Crash Lightning', 'player.buff(Crash Lightning).remains<gcd&player.area(8).enemies>1'},
	{'Stormstrike', '!talent(4,3)&player.area(8).enemies>2'},
	{'Stormstrike', 'player.buff(Stormbringer)'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<gcd'},
	{'Flametongue', 'player.buff(Flametongue).remains<gcd'},
	{'Windsong'},
	{'Ascendance'},
	{'Fury of Air', 'talent(6,2)&!player.buff(Fury of Air)'},
	{'Doom Winds'},
	{'Crash Lightning', 'player.area(8).enemies>2'},
	{'Stormstrike'},
	{'Lightning Bolt', 'talent(5,2)&player.maelstrom>50'},
	{'Lava Lash', 'player.buff(Hot Hand)'},
	{'Earthen Spike'},
	{'Crash Lightning', 'player.area(8).enemies>1||talent(6,1)||spell(Feral Spirit).cooldown>110'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<4.5'},
	{'Flametongue', 'player.buff(Flametongue).remains<4.8'},
	{'Sundering'},
	{'Lava Lash', 'player.maelstrom>80'},
	{'Rockbiter'},
	{'Flametongue'},
	{'Boulderfist'}
}

local Ranged = {
	{'Lightning Bolt'}
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<40'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, 'toggle(AoE)&player.area(8).enemies>2'},
	{xCombat, 'target.inMelee&target.inFront'},
	{Ranged, '!target.inMelee&target.range<50&target.inFront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(263, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Enhancement',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
