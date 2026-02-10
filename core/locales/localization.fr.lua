if GetLocale() ~= "frFR" then return end

TOCA._L = {
  TITLE = "Caddie Totem",

	INTRO = {
		{
			"|cfffa7634 Totem Caddy Devs are looking for language translators! Please click the contact tab to get more details if you would like to contribute to Totem Caddy!|r",
			"",
			"|cfffab734First time using Totem Caddy?|r",
			"Select the Help tab for more info|n|n",
			"UPDATES",
		},
		{
			"|cfffab734First time using Totem Caddy?|r|n",
			"Let's get started by dragging the Totem Caddy anywhere on your screen saving the position.",
			"> You can select totems in a category order (air, earth, fire, or water) by selecting the top arrows above the current totem icons.",
			"> The totem order can be changed under the Totem Sets in the options window.",
			"> You can also display all totems on screen in vertical/horizontal order based on totem category under the Frame Style options.",
			"> Totems will be display on your minimap for proximity",
			"> Totem/Shield timers and notifications can also be set within the options menu",
			"For addition options or create totem sets:",
			"> Select the cogwheel button or type /toca 'options', then select Totem Sets",
			"> You can select which totem for each category, give it a name, then select the bottom arrow on the main frame dropdown to access it.",
			"> Totem slot keybindings for your totem category slots: If you assign key bindings to to the totem slots for the very first time, you may have to do a '/reload'.",
			"|n",
		},
		{
			"Please feel free to reach out and let me know what improvements can be made.",
		},
		{
			"|cffffdf96Special thanks to:|cffffffff|n",
		},
		{
			"This message will not show again unless there is a new version.",
			'Type "/toca help" anytime to display this help message.'
		}
  },

	SPELLS = {
		Unknown = "Inconnue",
	},

	KEYBINDS = {
		TOTEM_RECALL    = "Appel totémique",
		TOTEM_AIR       = "Emplacement de totem : Air",
		TOTEM_EARTH     = "Emplacement Totem : Terre",
		TOTEM_FIRE      = "Emplacement de totem : Feu",
		TOTEM_WATER     = "Emplacement de totem : Eau",
		SHIELD_WATER    = "Bouclier : Eau",
		SHIELD_LIGHTNING= "Bouclier : Foudre",
		SHIELD_EARTH    = "Bouclier : Terre",
		WEAP_WIND       = "Weapon: Windfury",
		WEAP_ROCK       = "Weapon: Rockbiter",
		WEAP_FIRE       = "Weapon: Flametongue",
		WEAP_FROST      = "Weapon: Frostbrand",
	},

	INIT = {
	  "Profil du bâtiment",
	  "Profil de chargement",
		"Rappel Ankh",
		"arrive à expiration !",
		"Bienvenue à",
		"Initialisation",
		"version obsolète !"
	},

  UI = {
		FRAMESTYLES = {"Classique", "Segmenté", "Grille verticale", "Grille horizontale"},
		BUTTON = {"Fermer", "Sauvegarder", "Supprimer", "Oui", "Non"},

		TABS = {
		  OPTIONS = {"Cadre", "Ensembles", "Avis", "Weapons", "Minicarte", "Missions", "Shortcuts"},
		  HELP = {"Mises à jour", "Help", "Contact", "Crédit"}
		},

		SLIDER = {"Low", "High"},

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
			{"Anchor Tooltip to Cursor","Toggle the tooltip to follow over the mouse cursor."}
		},

		TOTEMSET = {
			{"Définir la sélection", ""},
			{"Définir le nom", ""},
			{"Ordre totémique", ""},
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

function TOCA._L.Ankh(count)
	return "Ankhs: |cffffffff".. count .."|r|n|nAnkh Inventory Count Reminder.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs"
end
