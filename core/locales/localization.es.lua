if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

TOCA.locale = {

	SPELLS = {
		Unknown       = "Unknown",
		Reincarnation = "Reencarnación",
		TotemicCall   = "Llamada totémica",
	},

	TOTEMS = {
		--[==[ WARNING! Changing the order of these totems will cause synchronization issues. ]==]--
		FIRE = {
		  "Tótem Nova de Fuego",
		  "Tótem lengua de Fuego",
		  "Tótem de resistencia a la Escarcha",
		  "Tótem de Magma",
		  "Tótem abrasador",
		  "Tótem de cólera",
		},
		EARTH = {
		  "Tótem Nexo Terrestre",
		  "Tótem Garra de piedra",
		  "Tótem piel de piedra",
		  "Tótem Fuerza de la tierra",
		  "Tótem de tremor",
		},
		WATER = {
		  "Tótem de limpieza de enfermedades",
		  "Tótem de resistencia al Fuego",
		  "Tótem Corriente de Sanación",
		  "Tótem Fuente de maná",
		  "Tótem Marea de maná",
		  "Tótem contraveneno",
		},
		AIR = {
		  "Tótem gracia del aire",
		  "Tótem derribador",
		  "Tótem de resistencia a la naturaleza",
		  "Tótem avizor",
		  "Tótem de aire sosegado",
		  "Tótem Viento Furioso",
		  "Tótem muro de viento",
		  "Tótem cólera de aire",
		}
	},

	INIT = {
	  "Creando perfil",
	  "Cargando perfil",
		"Recordatorio Ankh",
		"está expirando!",
	},

  UI = {
		BUTTON = {
			"Cerca",
			"Ahorrar",
			"Borrar",
		},

		TABS = {
		  OPTIONS = {
				"Marco de interfaz de usuario",
			  "Creador de conjuntos de tótems",
		  },
		  HELP = {
			  "Actualizaciones",
			  "Contactos",
			  "Crédito",
		  }
		},

		OPTIONS = {
			TITLE = "Options Menu",
		  {"Frame Totem Layout",       "|n|cffffffffClassic|r|nFour primary totems that are commonly used and selectable or profile built selection.|n|n|cffffffffGrid Vertical|r|nAll known Totems are displayed vertically organized by category row.|n|n|cffffffffGrid Horizontal|r|nAll known Totems are displayed horizontally organized by category row.|n|n|cffffffffThe totem category orders are configurable in the options menu."},
			{"Frame Layer",              "Sets the overlap over other menu and action bar items|non your screen.|nHigher frames will take precedence over items on screen."},
			{"Frame Scale",              "Increase/Decrease the size of the frame."},
			{"Reset Frame Scale",        "Reset the frame scale to the default size."},
			{"Reset Frame Position",     "Resets the frame position to center of screen."},
			{"Background Opacity",       "Increase/Decrease the background frame transparency."},
			{"Reset Background Opacity", "Reset the background opacity to the default value."},
		  {"Foreground Opacity",       "Increase/Decrease the foreground buttons/dropdown|ntransparency levels."},
			{"Reset Foreground Opacity", "Reset the foreground opacity to the default value."},
		},
		FRAME = {
			TITLE = "Frame Menu",
		  {"Lock Frame While In Combat",       "Lock the frame position while in combat.|nThis will prevent the accidental moving of the frame|nwhile accessing/clicking totems."},
		  {"Display Main Menu/Options Buttons","Toggle the Options and Close menu buttons from the frame.|nType |cffffffff/toca show|r if the frame is closed."},
			{"Display Frame/Button Borders",     "Toggle borders around the frames/buttons.|n|nBorder enabled is default."},
			{"Display Totemic Call Button",      "Toggle the Totemic Call button to display.|n|nDisplaying the Totemic Call button is by default."},
			{"Display Gryphons",                 "Toggle the cosmetic end caps on the main frame.|n|nEnabled (Gryphons) by Default"},
		},
		TIMERS = {
			TITLE = "Timers",
			{"Display Totem Timers",                  "Toggle the current totem living timer in world to|ndisplay on the current totem dropped."},
			{"Display Totem Timers In Minutes",       "Toggle the totem timer display in total seconds|nor minutes and seconds.|nBoth are default."},
			{"Display Reincarnation Timer (Cooldown)","Display the Reincarnation timer at the right top|nof the frame when you have activated Reincarnation.|nThe cooldown timer is live and also displayed."},
			{"Display Ankh Inventory Count Reminder", "Display a reminder when the Ankh reagent is low in|ncurrent your inventory.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs."},
		},
		TOOLTIP = {
			TITLE = "Tooltip",
			{"Display Totem Tooltip", "Toggle the mouseover of totem/spell details."},
		},
		NOTIFICATIONS = {
			TITLE = "Notifications [In Combat]",
			{"Notify Me When A Totem Is Expiring", "A personal notification in the chat window will alert when a totem is expiring.|nThis is only during combat."},
			{"Play A Sound When A Totem Is Expiring", "A chime will sound off when a totem is expiring.|nThis is only during combat."},
		},

		TOTEMSET = {
			"Set Selection",
			"Set Name",
			"Totem Order",
		}
	},

	COMMANDS = {
		{"options",  "Open Totem Caddy Options"},
		{"show",     "Display Totem Caddy (regardless of class)."},
		{"hide",     "Close Totem Caddy."},
		{"profile",  "Display the current saved profile."},
		{"help",     "Display the help introduction."},
		{"debug on", "Enable Debug Mode (Very Spammy)"},
		{"debug off","Disable Debug Mode (/reload)"},
	}
}

TOCA.TABS = {
  OPTIONS = {
		"UI Frame",
	  "Totem Set Builder",
  },
  HELP = {
	  "Updates",
	  "Contact",
	  "Credit",
  }
}

TOCA.HELP = {
	UPDATES = {
	  "|cffffdf96Please note:|r Totem Caddy is still evolving. Improvements will be made as time continues. There is an |cff7eabd5issue tracker|r now available on |cffff9f69Curseforge|r. Enjoy!|n",
		"|cffffdf96Coming Soon:|r Language versions different clients.",
		"",
	  "|cffffdf96New Feature:|r Added an option to display the Totemic Call button (BCC version only)",
		"",
	  "|cffffdf96First time using Totem Caddy?",
		"|r",
	  "Let's get started by dragging the Totem Caddy anywhere on your screen saving the position.",
	  "You can select totems in a category order (air, earth, fire, or water) by selecting the top arrows above the current totem icons.",
	  "The set of totems are by default, and the order is currently alphabetical. The totem order can changed under the Totem Sets in the options window.",
	  "You can also display all totems on screen in vertical/horizontal order based on totem category under the Frame Style options.",
	  "For addition options or create totem sets:",
	  "Select the cogwheel button or type /toca 'options', then select Totem Sets",
	  "You can select which totem for each category, give it a name, then select the bottom arrow on the main frame dropdown to access it.",
	  "Totem slot keybindings for your totem category slots: If you assign key bindings to to the totem slots for the very first time, you may have to do a '/reload'.",
	  "\n",
	},
	CONTACT = {
	  "Please feel free to reach out and let me know what improvements can be made.",
		"",
	  "|cffffdf96Curseforge:|r https://www.curseforge.com/wow/addons/totem-caddy/",
		"",
	  "|cffffdf96Discord:|r https://discord.com/users/Porthios#8963",
	},
	CREDIT = {
	  "Special thanks to some beta testers from the Myzrael realm.",
	  "Especially to my shaman buddy |cff006aa6Shockpopz|r of Myzrael For all the valuable feedback and laughs!",
		"|n",
	  "Written by |cff006aa6Porthias|r of Myzrael (a.k.a. Port)",
	},
	FOOTER = {
	  "This message will not show again unless there is a new version.",
		'Type "/toca help" anytime to display this help message.'
	}
}

function TOCA.locale.Help()
  return "Welcome to " .. TOCA.Global.title .. " v" .. TOCA.Global.version .. "-" .. TOCA.Global.suffix .. " (" .. GetLocale() .. ")|n|n"
end

function TOCA.locale.Init()
  return "v" .. TOCA.Global.version .. "-" .. TOCA.Global.suffix .. " (" .. GetLocale() .. ") Initializing. Type /" .. TOCA.Global.command .. " for commands."
end

function TOCA.locale.Ankh()
	return "Ankhs: |cffffffff".. TOCA.InventoryCountItem(TOCA.item.ANKH) .."|r|n|nAnkh Inventory Count Reminder.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs"
end

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
	elseif (cmd == "build") then
		print(string.format("version = %s, build = %s, date = '%s', tocversion = %s.", __Gversion, __Gbuild, __Gdate, __Gtoc))
	 end
end
