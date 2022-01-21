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

--WARNING! Changing the order of these totems will cause synchronization issues.
TOCA.totemspells.FIRE = {
  "Fire Nova Totem",
  "Flametongue Totem",
  "Frost Resistance Totem",
  "Magma Totem",
  "Searing Totem",
  "Totem of Wrath",
}
TOCA.totemspells.EARTH = {
  "Earthbind Totem",
  "Stoneclaw Totem",
  "Stoneskin Totem",
  "Strength of Earth Totem",
  "Tremor Totem",
}
TOCA.totemspells.WATER = {
  "Disease Cleansing Totem",
  "Fire Resistance Totem",
  "Healing Stream Totem",
  "Mana Spring Totem",
  "Mana Tide Totem",
  "Poison Cleansing Totem",
}
TOCA.totemspells.AIR = {
  "Grace of Air Totem",
  "Grounding Totem",
  "Nature Resistance Totem",
  "Sentry Totem",
  "Tranquil Air Totem",
  "Windfury Totem",
  "Windwall Totem",
  "Wrath of Air Totem",
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
