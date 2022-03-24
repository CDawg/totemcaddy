--default load in enUS/GB, then load overwrites. https://develop.battle.net/documentation/world-of-warcraft/guides/localization

TOCA._L = {
	TITLE = "Totem Caddy",

	SPELLS = {
		Unknown = "Unknown",
	},

	KEYBINDS = {
		TOTEM_RECALL    = "Totemic Call",
		TOTEM_AIR       = "Totem Slot: Air",
		TOTEM_EARTH     = "Totem Slot: Earth",
		TOTEM_FIRE      = "Totem Slot: Fire",
		TOTEM_WATER     = "Totem Slot: Water",
		SHIELD_WATER    = "Shield: Water",
		SHIELD_LIGHTNING= "Shield: Lightning",
		SHIELD_EARTH    = "Shield: Earth",
	},

	INIT = {
	  "Building Profile",
	  "Loading Profile",
		"Ankh Reminder",
		"is expiring!",
		"Welcome to",
		"Initializing",
		"outdated version!"
	},

  UI = {
		FRAMESTYLES = {"Classic", "Segmented", "Grid Vertical", "Grid Horizontal"},
		BUTTON = {"Close", "Save", "Delete", "Yes", "No"},

		TABS = {
		  OPTIONS= {"Frame", "Totem Sets", "Notifications", "Minimap", "Assignments", "Key Bindings"},
		  HELP   = {"Updates", "Contact", "Credit"}
		},

		OPTIONS = {
			TITLE = "Options Menu",
		  {"Frame Totem Layout",       "|n|cffffffffClassic|r|nFour primary totems that are commonly used and selectable or profile built selection.|n|n|cffffffffGrid Vertical|r|nAll known Totems are displayed vertically organized by category row.|n|n|cffffffffGrid Horizontal|r|nAll known Totems are displayed horizontally organized by category row.|n|n|cffffffffThe totem category orders are configurable in the options menu."},
			{"Frame Layer",              "Sets the overlap over other menu and action bar items|non your screen.|nHigher frames will take precedence over items on screen."},
			{"Frame Scale",              "Increase/Decrease the size of the frame."},
			{"Reset Scale",              "Reset the frame scale to the default size."},
			{"Reset Position",           "Resets the frame position to center of screen."},
			{"Background Opacity",       "Increase/Decrease the background frame transparency."},
			{"Reset Background Opacity", "Reset the background opacity to the default value."},
		  {"Foreground Opacity",       "Increase/Decrease the foreground buttons/dropdown|ntransparency levels."},
			{"Reset Foreground Opacity", "Reset the foreground opacity to the default value."},
			{"Earth Shield Assignments", "Toggle Earth Shield Assignments|n Only displays for raid and Restoration Shamans"},
		},
		FRAME = {
			TITLE = "Frame Menu",
		  {"Lock Frame While In Combat",       "Lock the frame position while in combat.|nThis will prevent the accidental moving of the frame|nwhile accessing/clicking totems."},
		  {"Display Main Close Button",        "Toggle the Close button from the main frame.|nType |cffffffff/toca show|r if the frame is closed.", "Menu header disabled. Type '/toca options' to reopen."},
			{"Display Frame/Button Borders",     "Toggle borders around the frames/buttons.|n|nBorder enabled is default."},
			{"Display Totemic Call Button",      "Toggle the Totemic Call button to display.|n|nDisplaying the Totemic Call button is by default."},
			{"Display End Caps",                 "Toggle the cosmetic end caps on the main frame.|n|nEnabled (Gryphons) by Default"},
			{"Display Main Options Button",      "Toggle the Options button from the main frame."},
		},
		TIMERS = {
			TITLE = "Timers",
			{"Display Totem Timers",                  "Toggle the current totem living timer in world to|ndisplay on the current totem dropped."},
			{"Display Totem Timers In Minutes",       "Toggle the totem timer display in total seconds|nor minutes and seconds.|nBoth are default."},
			{"Display Reincarnation Timer (Cooldown)","Display the Reincarnation timer at the right top|nof the frame when you have activated Reincarnation.|nThe cooldown timer is live and also displayed."},
			{"Display Shield Details On Frame",       "Display your current shield on the Frame."},
			{"Display Ankh Inventory Count Reminder", "Display a reminder when the Ankh reagent is low in|nyour current inventory.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs."},
		},
		TOOLTIP = {
			TITLE = "Tooltip",
			{"Display Totem Tooltip",   "Toggle the mouseover of totem/spell details."},
			{"Anchor Tooltip to Cursor","Toggle this tooltip to follow over the mouse cursor."}
		},

		TOTEMSET = {
			{"Set Selection",    ""},
			{"Set Name",         ""},
			{"Totem Order",      ""},
			{"Delete Totem Set", ""},
			{"Save Totem Set",   ""},
			{"Unable to remove", ""},
			{"Totem Set Saved",  ""},
			{"Totem Set Updated",""},
		},

		NOTIFICATIONS = {
			TITLE = "Notifications",
			{"Trigger Notifications Only During Combat",        "Notifications will only trigger while in combat."},
			{"Notify Me When A Totem Is Expiring",              "A personal notification in the chat window will alert when a totem is expiring."},
			{"Play A Sound When A Totem Is Expiring",           "A chime will sound off when a totem is expiring.|n This is only during combat."},
			{"Notify Me When A Shield Is Expiring Or Low",      "A personal notification in the chat window will alert when your shield is running low or expiring."},
			{"Play A Sound When A Shield Is Expiring Or Low",   "A chime will sound off when your shield is low or expiring."},
			{"Show a Visual Alert When A Totem Is Out Of Range","A visual red border will display when you are out of range of a totem.|n Only totems that benefit an aura."},
		},

		MINIMAP = {
			{"Display Minimap Options Button",     "Hide or display the Minimap Options Button"},
			{"Display Totems On The Minimap",      "Hide or display the Minimap Totem Radius circles. (Only works outside of instances)"},
			{"Display Minimap Totem Radius Solid", "Hide or display the totem radius solid on the Minimap"},
			{"Display Minimap Totem Radius Rings", "Hide or display the totem radius rings on the Minimap"},
			{"Display Minimap Totem Icons",        "Hide or display the totem icons on the Minimap"},
		},

		ASSIGNMENTS = {
			TITLE = "Earth Shield Raid Assignments (Resto)",
			{"Test Assignments",                             "Test the Earth Shield Assignments out of raid"},
			{"Enable Raid Earth Shield Assignments",         "Hide/Display the Tank Earth Shield Assignments"},
			{"Earth Shield Assignments Scale",               "Increase/Decrease the size of the Earth Shield Assignments frame."},
			{"Notify Channel",                                "How to notify resto shamans with Earth Shield Assignments"},
			{"Channel Name", ""},
		},
	},

	COMMANDS = {
		{"options",  "Open Totem Caddy Options"},
		{"show",     "Display Totem Caddy (regardless of class)"},
		{"hide",     "Close Totem Caddy"},
		{"profile",  "Display the current saved profile"},
		{"assign",   "Open the Earth Shield Raid Assignment panel"},
		{"help",     "Display the help introduction"},
		{"debug on", "Enable Debug Mode (Very Spammy)"},
		{"debug off","Disable Debug Mode (/reload)"},
		{"build",    "View latest game version and build"},
	}
}

function TOCA._L.Ankh()
	return "Ankhs: |cffffffff".. TOCA.InventoryCountItem(TOCA.item.ANKH) .."|r|n|nAnkh Inventory Count Reminder.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs"
end
