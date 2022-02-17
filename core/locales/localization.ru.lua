if GetLocale() ~= "ruRU" then return end

TOCA.locale = {
  TITLE = "Тотем Кэдди",

	SPELLS = {
		Unknown = "Неизвестный",
	},

	KEYBINDS = {
		TOTEM_RECALL= "Тотемный зов",
		TOTEM_AIR   = "Слот Тотема: Воздух",
		TOTEM_EARTH = "Слот тотема: Земля",
		TOTEM_FIRE  = "Слот Тотема: Огонь",
		TOTEM_WATER = "Слот Тотема: Вода",
	},

	INIT = {
	  "Профиль здания",
	  "Загрузка профиля",
		"Анк Напоминание",
		"истекает!",
	},

  UI = {
		BUTTON = {"Закрывать", "Сохранять", "Удалить", "да", "Нет"},

		TABS = {
			OPTIONS ={"Рамка", "Набор тотемов","Уведомления", "Клавиатура"},
		  HELP = {"Обновления", "Контакт", "Кредит"}
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
		},
		FRAME = {
			TITLE = "Frame Menu",
		  {"Lock Frame While In Combat",       "Lock the frame position while in combat.|nThis will prevent the accidental moving of the frame|nwhile accessing/clicking totems."},
		  {"Display Main Menu/Options Buttons","Toggle the Options and Close menu buttons from the frame.|nType |cffffffff/toca show|r if the frame is closed.", "Menu header disabled. Type '/toca options' to reopen."},
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

		TOTEMSET = {
			"Установить выбор",
			"Имя набора",
			"Орден Тотема",
		},

		NOTIFICATIONS = {
			TITLE = "Notifications",
			{"Trigger Notifications Only During Combat",    "Notifications will only trigger while in combat."},
			{"Notify Me When A Totem Is Expiring",          "A personal notification in the chat window will alert when a totem is expiring."},
			{"Play A Sound When A Totem Is Expiring",       "A chime will sound off when a totem is expiring.|nThis is only during combat."},
			{"Notify Me When A Shield Is Expiring Or Low",  "A personal notification in the chat window will alert when your shield is running low or expiring."},
			{"Play A Sound When A Shield Is Expiring Or Low","A chime will sound off when your shield is low or expiring."},
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
