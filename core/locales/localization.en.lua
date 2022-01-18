--default load in enUS, then load overwrites.

TOCA.locale = {
	init_init = "Initializing",
	init_type = "Type",
	init_commands = "for commands.",
	profile_build = "Building Profile",
  profile_load = "Loading Profile",
	spell_unknown = "Unknown Spell",
  spell_reincarnation = "Reincarnation",
	spell_totemiccall = "Totemic Call",
	tooltip_ankh = "Ankh Reminder",
	options_menu = "Options Menu",
}

function TOCA.locale.Ankh()
	return "Ankhs: |cffffffff".. TOCA.InventoryCountItem(TOCA.item.ANKH) .."|r|n|nAnkh Inventory Count Reminder.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs"
end

TOCA.locale.commands = {
	{"options", "Open Totem Caddy Options"},
	{"show", "Display Totem Caddy (regardless of class)."},
	{"hide", "Close Totem Caddy."},
	{"profile", "Display the current saved profile."},
	{"help", "Display the help introduction."},
	{"debug on", "Enable Debug Mode (Very Spammy)"},
	{"debug off", "Disable Debug Mode (/reload)"},
}

TOCA.totems.FIRE = {
  {"Fire Nova Totem",       "spell_fire_sealoffire"},
  {"Flametongue Totem",     "spell_nature_guardianward"},
  {"Frost Resistance Totem","spell_frostresistancetotem_01"},
  {"Magma Totem",           "spell_fire_selfdestruct"},
  {"Searing Totem",         "spell_fire_searingtotem"},
  {"Totem of Wrath",        "spell_fire_totemofwrath"},
  --{"Fire Elemental Totem",  "spell_fire_elemental_totem"},
}
TOCA.totems.EARTH = {
  {"Earthbind Totem",        "spell_nature_strengthofearthtotem02"},
  {"Stoneclaw Totem",        "spell_nature_stoneclawtotem"},
  {"Stoneskin Totem",        "spell_nature_stoneskintotem"},
  {"Strength of Earth Totem","spell_nature_earthbindtotem"},
  {"Tremor Totem",           "spell_nature_tremortotem"},
  --{"Earth Elemental Totem",  "spell_nature_earthelemental_totem"},
}
TOCA.totems.WATER = {
  {"Disease Cleansing Totem","spell_nature_diseasecleansingtotem"},
  {"Fire Resistance Totem",  "spell_fireresistancetotem_01"},
  {"Healing Stream Totem",   "inv_spear_04"},
  {"Mana Spring Totem",      "spell_nature_manaregentotem"},
  {"Mana Tide Totem",        "spell_frost_summonwaterelemental"},
  {"Poison Cleansing Totem", "spell_nature_poisoncleansingtotem"},
}
TOCA.totems.AIR = {
  {"Grace of Air Totem",     "spell_nature_invisibilitytotem"},
  {"Grounding Totem",        "spell_nature_groundingtotem"},
  {"Nature Resistance Totem","spell_nature_natureresistancetotem"},
  {"Sentry Totem",           "spell_nature_removecurse"},
  {"Tranquil Air Totem",     "spell_nature_brilliance"},
  {"Windfury Totem",         "spell_nature_windfury"},
  {"Windwall Totem",         "spell_nature_earthbind"},
  {"Wrath of Air Totem",     "spell_nature_slowingtotem"},
}

function TOCA.CommandList(cmd)
	if (cmd == "show") then
		TOCA.FrameMain:Show()
		TOCADB[TOCA.player.combine]["DISABLED"] = "NO"
	elseif (cmd == "hide") then
		TOCA.FrameMain:Hide()
	elseif (cmd == "sets") then
		TOCA.FrameSets:Show()
	elseif (cmd == "profile") then
		TOCA.Notification("|r Profile: " .. TOCA.player.combine)
	elseif (cmd == "options") then
		TOCA.FrameOptions:Show()
	elseif (cmd == "help") then
		TOCA.FrameHelp:Show()
	elseif (cmd == "debug on") then
		TOCA.DEBUG = true
		TOCA.Notification("DEBUG ON")
	elseif (cmd == "debug off") then
		TOCA.DEBUG = false
		TOCA.Notification("DEBUG OFF")
	end
end
